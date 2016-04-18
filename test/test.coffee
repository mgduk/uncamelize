chai = require 'chai'
expect = chai.expect
uncamelize = require '../src/uncamelize'

describe 'uncamelize', ->
    it 'doesn\'t change "foobar"', -> expect(uncamelize('foobar')).to.equal 'foobar'
    it 'doesn\'t change "FOOBAR"', -> expect(uncamelize('FOOBAR')).to.equal 'FOOBAR'
    it 'converts "fooBar" to "foo Bar"', -> expect(uncamelize('fooBar')).to.equal 'foo Bar'
    it 'converts "foo barBaz" to "foo bar Baz"', -> expect(uncamelize('foo barBaz')).to.equal 'foo bar Baz'
    it 'converts "foo☻Baz" to "foo ☻Baz"', -> expect(uncamelize('foo☻Baz')).to.equal 'foo☻ Baz'
    it 'converts "foo1Bar" to "foo1 Bar"', -> expect(uncamelize('foo1Bar')).to.equal 'foo1 Bar'
    it 'converts "foo123Bar" to "foo123 Bar"', -> expect(uncamelize('foo123Bar')).to.equal 'foo123 Bar'
    it 'converts "FooBar" to "Foo Bar"', -> expect(uncamelize('FooBar')).to.equal 'Foo Bar'
    it 'converts " FooBar" to "Foo Bar"', -> expect(uncamelize(' FooBar')).to.equal 'Foo Bar'
    it 'converts "☻FooBar" to "☻ Foo Bar"', -> expect(uncamelize('☻FooBar')).to.equal '☻ Foo Bar'
    it 'converts "123fooBar" to "123 foo Bar"', -> expect(uncamelize('123fooBar')).to.equal '123foo Bar'
    it 'converts "123FooBar" to "123 foo Bar"', -> expect(uncamelize('123FooBar')).to.equal '123 Foo Bar'

    it 'correctly uncamelizes default special cases', ->
        expect(uncamelize 'httpUrlsGitHubHtml').to.equal 'HTTP URLs GitHub HTML'
    it 'maintains correct spacing with non-camelized words', ->
        expect(uncamelize('Something FooBar Baz')).to.equal 'Something Foo Bar Baz'
    it 'maintains correct spacing with non-camelized words including special cases', ->
        expect(uncamelize('HTTP GitHub URLs')).to.equal 'HTTP GitHub URLs'


    describe 'when called with', ->
        it 'a string, returns a string', ->
            ret = uncamelize('foo')
            expect(ret).to.be.a 'string'

        it 'an object, returns a function', ->
            ret = uncamelize specialCases: 'FOO'
            expect(ret).to.be.a 'function'

        it 'an empty object, returns a function', ->
            ret = uncamelize {}
            expect(ret).to.be.a 'function'

        it 'a function, throws', ->
            expect(-> uncamelize ->).to.throw TypeError

        it 'a non-plain object, throws', ->
            expect(-> uncamelize new Date).to.throw TypeError

        it 'a number, throws', ->
            expect(-> uncamelize 12345).to.throw TypeError

        it 'an array, throws', ->
            expect(-> uncamelize ['foo', 'bar']).to.throw TypeError

    describe 'when called with an options object', ->

        it 'respects a single special case given as a string', ->
            u = uncamelize specialCases: 'FOO'
            expect(u 'fooBar').to.equal 'FOO Bar'

        it 'respects multiple special cases given as a string', ->
            u = uncamelize specialCases: 'FOO BAR'
            expect(u 'fooBar').to.equal 'FOO BAR'

        it 'respects multiple special cases given as an array', ->
            u = uncamelize specialCases: ['fOo', 'BAR', 'BAZ']
            expect(u 'fooBarBaz').to.equal 'fOo BAR BAZ'

        it 'overrides built in special cases when given specialCases', ->
            u = uncamelize specialCases: 'FOO BAR'
            expect(u 'htmlHttp').to.equal 'html Http'

        it 'optionally merges given special cases with default special cases', ->
            u = uncamelize specialCases: 'FOO BAR', merge: 'specialCases'
            expect(u 'htmlHttpFooBar').to.equal 'HTML HTTP FOO BAR'

