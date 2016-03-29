chai = require 'chai'
expect = chai.expect
uncamelize = require '..'

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
