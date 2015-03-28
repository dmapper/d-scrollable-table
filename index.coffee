module.exports = class ScrollableTable
  style: __dirname
  name: 'scrollable-table'

  scroll: (content) ->
    return unless content?
    return unless table = content.querySelector('table')
    {scrollTop, scrollLeft} = content
    headCell = table.querySelector('tbody th:first-child')
    headCells = headCell.parentNode.querySelectorAll('th').length
    for i in [1..5]
      table.classList.toggle "-th-#{i}", (i is headCells)
    table.classList.toggle '-scrollX', !!scrollLeft
    table.classList.toggle '-scrollY', !!scrollTop

    for node in table.querySelectorAll('thead')
      for transform in ['webkitTransform', 'msTransform', 'transform']
        node.style[transform] = "translateY(#{ scrollTop }px)"

    cells = table.querySelectorAll \
        "tbody th, thead tr:first-child th:nth-child(-n+#{ headCells })"
    for cell in cells
      for transform in ['webkitTransform', 'msTransform', 'transform']
        cell.style[transform] = "translateX(#{ scrollLeft }px)"
