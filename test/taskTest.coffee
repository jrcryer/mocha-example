chai = require 'chai'
{TaskList, Task} = require '../src/task'

chai.should()

describe 'Task instance', ->
  task1 = task2 = null

  it 'should have a name', ->
    task1 = new Task 'feed the cat'
    task1.name.should.equal 'feed the cat'

  it 'should be initially incomplete', ->
    task1.status.should.equal 'incomplete'
  
  it 'should be able to complete', ->
    task1.complete().should.be.true
    task1.status.should.equal 'complete'

  it 'should be able to be dependent on another task', ->
    task1 = new Task 'wash dishes'
    task2 = new Task 'dry dishes'
    task2.dependsOn task1
    task2.status.should.equal 'dependent'
    task2.parent.should.equal task1
    task1.child.should.equal task2

  it 'should refuse completion if it is dependent on an uncomplete task', ->
    (-> task2.complete()).should.throw "Dependent task 'wash dishes' is not completed"

describe 'TaskList', ->
  taskList = null

  it 'should start with no tasks', ->
    taskList = new TaskList
    taskList.tasks.length.should.equal 0
    taskList.length.should.equal 0

  it 'should accept new tasks as tasks', ->
    task = new Task 'buy milk'
    taskList.add task
    taskList.tasks[0].name.should.equal 'buy milk'
    taskList.length.should.equal 1

  it 'should accept new tasks as string', ->
    taskList.add 'take out garbage'
    taskList.tasks[1].name.should.equal 'take out garbage'
    taskList.length.should.equal 2

  it 'should remove tasks', ->
    i = taskList.length - 1
    taskList.remove taskList.tasks[1]
    taskList.length.should.equal i

  it 'should print out the list', ->
    taskList = new TaskList
    task0 = new Task 'buy milk'
    taskList.add task0

    task1 = new Task 'go to store'
    taskList.add task1

    task2 = new Task 'another task'
    taskList.add task2

    task3 = new Task 'sub-task'
    taskList.add task3

    task4 = new Task 'sub-sub-task'
    taskList.add task4

    task0.dependsOn task1
    task4.dependsOn task3
    task3.dependsOn task2
    task1.complete()
    expected = """Tasks

- buy milk (depends on 'go to store')
- go to store (completed)
- another task
- sub-task (depends on 'another task')
- sub-sub-task (depends on 'sub-task')

"""
     
    taskList.print().should.equal expected

