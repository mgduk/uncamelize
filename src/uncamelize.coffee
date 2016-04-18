isPlainObject = require 'lodash.isplainobject'

module.exports = (o) ->

    # config options that should be arrays, but may be defined as space-separated strings
    configArrayKeys = ['specialCases', 'merge']

    # ensures that all config keys in configArraysKeys are arrays not strings
    arraysAsArrays = (o) ->
        for own k, v of o when k in configArrayKeys and typeof v is 'string'
            o[k] = v.split ' '
        return o

    # uncamelize() default options
    config = arraysAsArrays
        specialCases: 'URL URLs SSH CMS ID HTTP HTTPS HTML XML QA UAT GitLab GitHub'

    # deals with words with abnormal capitalisation, such as initialisms and camelcased names
    handleSpecialCases = (s) ->
        return s unless config.specialCases

        # replace known abbreviations with correct case
        for abbrev in config.specialCases
            s = s.replace new RegExp("\\b#{abbrev}\\b","ig"), abbrev

        # look for special case words that uncamelize breaks (e.g. naturally camelcased words, like 'GitHub')
        for abbrev in config.specialCases
            uncamelized = uncamelize abbrev, false
            if uncamelized != abbrev
                s = s.replace new RegExp("\\b#{uncamelized}\\b","ig"), abbrev

        return s

    # does the actual uncamelizing business
    uncamelize = (s, specialCases = true) ->
        s = (''+s).replace(/((?=.)[^A-Z ])([A-Z])(?=[^A-Z])/g, '$1 $2').trim()
        s = handleSpecialCases s if specialCases
        return s

    ####
    # If this module is called with a string, it will uncamelize it using default options.
    # Call it with an object hash map to receive back a customised function

    # if called with a string, we will immediately uncamelize that string with default options
    if typeof o is 'string'
        return uncamelize o

    # if called with an object, set options from object and return a function to be called later
    else if isPlainObject o
        o.merge = [] unless o.merge
        o = arraysAsArrays o

        for own key, value of o
            # merge with existing, if requested
            value = config[key].concat value if key in o.merge
            config[key] = value

        return uncamelize

    else
        throw new TypeError 'Expected a string or plain object'
