
module.exports = (s) ->
    (''+s).replace(/((?=.)[^A-Z])([A-Z])(?=[^A-Z])/g, '$1 $2').trim()
