# d-scrollable-table

> Scrollable table with fixed (floating) thead and N first column(s)

## Usage

```js
app.component( require('d-scrollable-table') );
```

```html
<div style="overflow: auto" on-scroll="scrollable.scroll($element)">
  <view is="d-scrollable-table" as="scrollable"></view>
  <table>
  
    <tbody>
      <tr>
        <!-- 
          IMPORTANT! Cells that should be fixed when scrolling horizontally
          MUST be <th>. So if you want 3 first columns to be fixed when 
          scrolling, make sure that first 3 cells in each row of <tbody>
          are <th> and all the others are <td>
        -->
        <th>Fixed 1</th>
        <th>Fixed 2</th>
        <th>Fixed 3</th>
        
        <td>Normal</td>
        <td>Normal</td>
        <!-- ... -->
        <td>Normal</td>
      </tr>
      <!-- ... -->
      <tr>
        <!-- ... -->
      </tr>
    </tbody>
    
    <thead>
      <!-- 
        IMPORTANT! thead MUST be on the very bottom after <tbody>.
        All browsers will still render it on the top so don't worry.
        All cells must be <th>.
      -->      
      <tr>
        <th>...</th>
        <th>...</th>
        <!-- ... -->
        <th>...</th>
      <tr>
    </thead>
    
  </table>
</div>
```

## Licence

MIT