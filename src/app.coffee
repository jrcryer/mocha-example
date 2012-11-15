class AppHistory
  constructor: (@capacity=0) ->
    @items = []
    @length = 0

  removeDuplicates: (item) =>
    @items  = @items.filter (existing) -> existing isnt   item
    @length = @items.length

  add: (item) ->
    return false if item is ''
    this.removeDuplicates(item)
    @items  = [item].concat @items
    @length = @items.length

  get: (index) ->
    @items[index]

  first: ->
    this.get(0)

  last: ->
    this.get(@length - 1)


root = exports ? window
root.AppHistory = AppHistory