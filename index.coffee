module.exports = class ScrollableTable
  style: __dirname
  name: 'd-scrollable-table'

  init: ->
    @model.setNull 'hiddenClass', 'u-hidden'

  create: ->
    @model.on 'change', 'update.**', =>
      setTimeout @scroll.bind(@, @content, true), 0

  scrollParent: (table) ->
    @dom.on 'scroll', table.parentNode, @scroll.bind(@, table.parentNode)

  scroll: (@content, force) ->
    # This is due to 2nd arg being event by default
    force = undefined unless force is true

    return unless @content?
    return unless @table = @content.querySelector('table')
    {scrollTop, scrollLeft} = @content
    cols = @_getCols()
    if scrollTop isnt @scrollTop or force
      @_scrollY scrollTop
    if scrollLeft isnt @scrollLeft or cols isnt @cols or force
      @_scrollX scrollLeft, cols, (cols isnt @cols)

  _scrollY: (@scrollTop) ->
    {scrollTop} = @content
    @table.classList.toggle '-scrollY', !!scrollTop

    for node in @table.querySelectorAll('.table-scrollY, thead')
      @_addTransform node, 'translateY', "translateY(#{ scrollTop }px)"

  _scrollX: (@scrollLeft, @cols = 0, resetRestThead) ->
    {scrollLeft} = @content

    for i in [1..5]
      @table.classList.toggle "-th-#{i}", (i is @cols)
    @table.classList.toggle '-scrollX', !!scrollLeft

    if @cols > 0
      cells = @table.querySelectorAll \
          ".table-scrollX, tbody th, thead tr:first-child th:nth-child(-n+#{ @cols })"
      for cell in cells
        @_addTransform cell, 'translateX', "translateX(#{ scrollLeft }px)"

    @_resetRestThead() if resetRestThead

  _addTransform: (node, type, value) ->
    regex = /// #{ type }\([^\)]*\) ///
    for transform in ['webkitTransform', 'msTransform', 'transform']
      if (node.style[transform] || '').trim()
        if regex.test node.style[transform]
          node.style[transform] = node.style[transform].replace regex, value
        else
          node.style[transform] += ' ' + value
      else
        node.style[transform] = value

  _resetRestThead: ->
    cells = @table.querySelectorAll \
        "thead tr:first-child th:nth-child(n+#{ @cols + 1 })"
    for cell in cells
      for transform in ['webkitTransform', 'msTransform', 'transform']
        cell.style[transform] = ''

  _getCols: ->
    hiddenClass = @model.get('hiddenClass')
    headCell = @table.querySelector "tbody tr:not(.#{ hiddenClass }) th"
    headCells = headCell.parentNode.querySelectorAll('th').length
    headCells
