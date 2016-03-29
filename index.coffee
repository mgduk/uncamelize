
module.exports = (s) ->
    (''+s).replace(/((?=.)[a-z])([A-Z])(?=[^A-Z])/g, '$1 $2').trim()

