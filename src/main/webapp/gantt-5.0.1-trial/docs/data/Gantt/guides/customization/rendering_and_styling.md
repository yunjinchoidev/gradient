# Rendering and styling

Gantt is styled using SASS (scss). It ships with both compiled CSS bundles for its five themes and the original scss
files. You can also programmatically modify the appearance of cells, headers and task bars using "renderer" methods.

**Note:** Trial version has no SASS and Themes. You need the fully licensed version to be able to follow the
instructions below.

## Styling the left grid / table tree section 

The left section of the Gantt is inherited from the [Bryntum Grid](https://bryntum.com/products/grid). Any styling
you want to perform on columns, cells or rows is described 
[here](https://bryntum.com/docs/grid/guide/Grid/customization/styling#using-renderers-and-css).

## Styling task bars

### Styling using task data fields

Tasks can be styled in a few different ways. The easiest way is by applying a CSS class using
the [cls](#Gantt/model/TaskModel#field-cls)
data field in the `TaskModel`. You can also apply inline styles through the data using
the [style](#Gantt/model/TaskModel#field-style)
field. See example data below setting background to **red** and adding a myClass CSS class to the task bar element:

```json
{
    "id"          : 13,
    "name"        : "Setup load balancer",
    "percentDone" : 50,
    "style"       : "background:red",
    "cls"         : "myClass",
    "startDate"   : "2022-01-14",
    "duration"    : 3,
    "endDate"     : "2019-01-17"
}
```

### Styling at runtime using the `taskRenderer`

You can also use the [taskRenderer](#Gantt/view/GanttBase#config-taskRenderer) method to apply styles at runtime. This 
method receives a `renderData` parameter which you can use to set:

- `cls` - A CSS class to add to the task bar element
- `wrapperCls` - A CSS class to add to the outer task wrapping element
- `iconCls` - A CSS class representing a task icon element
- `style` - An inline style string (or object) to add to the task bar element
- `indicators` - An array that can be populated with TimeSpan records or their config objects to have them rendered in the 
  task row (See the [indicators](../examples/indicators) demo for more information)

The function return value can be any markup to render inside the task bar.

```javascript
new Gantt({
    taskRenderer({ taskRecord, renderData }) {
        if (taskRecord.endDate < Date.now()) {
            // fade out tasks in the past
            renderData.style = "opacity:0.5";
        }

        // Skip showing names for parent task bars
        return taskRecord.isParent ? '' : taskRecord.name;
    }
});
```

## Rendering custom HTML content inside a task bar

You can fully control the markup of the task bar using the [taskRenderer](#Gantt/view/GanttBase#config-taskRenderer)
method. Below is a demo showing the intials of the assigned resources rendered inside the task bar.

<div class="external-example" data-file="Gantt/guides/customization/taskRenderer.js"></div>

If you instead want to output some data about each time axis tick (like hours worked on a task per day), you can look at
the [custom task bar example](../examples/custom-taskbar) for inspiration:

![Custom task bar](Gantt/custom-taskbar.png "Custom task bar")

## Rendering custom indicator icons inside a task row

You can render icons inside a task row to indicate things like deadline or other important task dates using the 
[indicators](#Gantt/feature/Indicators) feature. Try a live demo of it [here](../examples/indicators)

![Indicators](Gantt/indicators.png "Indicators")

## Styling dependency lines

The inter-task dependencies are rendered as SVG lines which you can easily customize using regular CSS. To change 
the appearance of all dependency lines globally, simply do: 

```CSS
/* Lines */
.b-sch-dependency {
  stroke       : #000; /* Black lines */
  stroke-width : 2;    /* Slightly thicker */
}

/* Arrow markers */
.b-sch-dependency-arrow {
  fill : #000; /* Black arrows too */
}
```

<div class="external-example" data-file="Gantt/guides/customization/stylingDependencies.js"></div>

To modify individual dependencies, you can use the [cls](#Gantt/model/DependencyModel#field-cls) data field to add a CSS
class to the SVG element representing the dependency:

```JSON
{
  "id"       : 1,
  "fromTask" : 11,
  "toTask"   : 15,
  "lag"      : 2,
  "cls"      : "important"
}
```

And here is the CSS to change the appearance:

```CSS
.b-sch-dependency.important {
  stroke       : #e44b4b;
  marker-start : url(#arrowEndCritical);
}

.b-sch-dependency-arrow#arrowEndCritical {
  fill : #e44b4b;
}
```

## Using a theme

Gantt ships with five themes, stockholm, default, light, dark and material. Each theme is compiled into a self containing
bundle under build/. Simply include it on your page to use it:

```html
<link rel="stylesheet" href="build/gantt.stockholm.css" data-bryntum-theme>
<link rel="stylesheet" href="build/gantt.default.css" data-bryntum-theme>
<link rel="stylesheet" href="build/gantt.light.css" data-bryntum-theme>
<link rel="stylesheet" href="build/gantt.dark.css" data-bryntum-theme>
<link rel="stylesheet" href="build/gantt.material.css" data-bryntum-theme>
```

<div class="note">
The <code>data-bryntum-theme</code> attribute on the link tag is not strictly required, but it allows you to 
programmatically switch the theme at runtime using <code>DomHelper.setTheme()</code>.
</div>

If you are using a build process based on WebPack or similar, depending on your setup you might also be able to include
the themes using `import`:

```javascript
import 'build/gantt.stockholm.css';
```

### Comparison of themes:

![Classic theme](Gantt/themes/thumb.classic.png "Default theme")
![Classic-Light theme](Gantt/themes/thumb.classic-light.png "Light theme")
![Classic-Dark theme](Gantt/themes/thumb.classic-dark.png "Dark theme")
![Material theme](Gantt/themes/thumb.material.png "Material theme")
![Stockholm theme](Gantt/themes/thumb.stockholm.png "Stockholm theme")

In most of the included examples you can switch theme on the fly by clicking on the info icon found in the header and
then picking a theme in the dropdown.

### Combining products

The "normal" themes described above includes all the CSS you need to use Gantt and its helper widgets such as
Popups, TextFields and so on. When combining multiple different Bryntum products on a single page using "normal" themes,
the shared styling will be included multiple times.

To avoid this, each theme is available in a version that only has the product specific styling. These are called `thin`
themes (named `[product][theme].thin.css` -> `gantt.stockholm.thin.css`). When using them you will need to include one
for each used level in the Bryntum product hierarchy (Gantt -> `Core + Grid + Scheduler + Scheduler Pro + Gantt` and so
on).

For example to combine Gantt and Calendar using the Stockholm theme, you would include:

`core.stockholm.thin.css` + `grid.stockholm.thin.css` + `scheduler.stockholm.thin.scss` +
`schedulerpro.stockholm.thin.scss` + `gantt.stockholm.thin.scss` + `calendar.stockholm.thin.scss`

Which in your html file might look something like this:

```html
<link rel="stylesheet" href="core.stockholm.thin.css" data-bryntum-theme>
<link rel="stylesheet" href="grid.stockholm.thin.css" data-bryntum-theme>
<link rel="stylesheet" href="scheduler.stockholm.thin.css" data-bryntum-theme>
<link rel="stylesheet" href="schedulerpro.stockholm.thin.css" data-bryntum-theme>
<link rel="stylesheet" href="gantt.stockholm.thin.css" data-bryntum-theme>
<link rel="stylesheet" href="calendar.stockholm.thin.css" data-bryntum-theme>
```

<div class="note">
Nothing prevents you from always using thin CSS bundles, but please note that there might be a slight network overhead 
from pulling in multiple CSS files as opposed to a single on with the normal themes.
</div>

## Creating a theme

To create your own theme, follow these steps:

1. Make a copy of an existing theme found under resources/sass/themes, for example light.scss
2. Edit the variables in it to suit your needs (you can find all available variables by looking in resources/sass/variables.scss)
3. Compile it to CSS and bundle it using your favorite SASS compiler/bundler
4. Include your theme on your page (and remove any default theme you where using)

## Using renderers and CSS

For performance reasons, scheduled task elements are reused when scrolling, meaning that you should not manipulate them
directly. Instead the contents of cells, headers and tasks can be customized using renderers. Renderers are functions
with access to a cell/header/tasks data (such as style and CSS classes, and in some cases elements). They can
manipulate the data to alter appearances or return a value to have it displayed.

For more information, see the [theme](../examples/theme) demo or check API docs for:
* [Cell renderer](#Grid/column/Column#config-renderer)
* [Column header renderer](#Grid/column/Column#config-headerRenderer)
* [Task renderer](#Gantt/view/Gantt#config-taskRenderer)


<p class="last-modified">Last modified on 2022-03-04 9:57:13</p>