chai = require 'chai'
{AppHistory} = require '../src/app'

chai.should()

describe 'Application History', ->

  history = null

  it 'should initially be empty', ->
    history = new AppHistory
    history.length.should.equal 0

  it 'should be able to add items to history', ->
    history = new AppHistory
    history.add 'test'

    history.length.should.equal 1

  it 'should add items to front of queue', ->
    history = new AppHistory
    history.add 'test'

    history.first().should.equal 'test'

  it 'should push items further down the queue as more are added', ->
    history = new AppHistory
    history.add 'test 1'
    history.add 'test 2'
    history.add 'test 3'

    history.last().should.equal 'test 1'

  it 'should be allow items access via zero based index', ->
    history = new AppHistory
    history.add 'test 1'
    history.add 'test 2'
    history.add 'test 3'

    history.get(1).should.equal 'test 2'

  it 'should ensure items are unique in the queue', ->
    history = new AppHistory
    history.add 'test 1'
    history.add 'test 2'
    history.add 'test 1'

    history.first().should.equal 'test 1'
    history.last().should.equal 'test 2'
    history.length.should.equal 2 

  it 'should not allow empty string to be inserted', ->
    history = new AppHistory
    history.add ''
    
    history.length.should.equal 0
