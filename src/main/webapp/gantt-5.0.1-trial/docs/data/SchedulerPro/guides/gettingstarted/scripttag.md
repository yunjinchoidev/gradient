# Loading using `<script>`

## Include script and CSS

To include Bryntum Scheduler Pro on your page using a plain old script tag, just include a tag like the following before
including any script that uses the Scheduler Pro:

```html
<script type="text/javascript" src="path-to-scheduler-pro/schedulerpro.umd.js"></script>
```

Also include the CSS for the theme you want to use:

```html
<link rel="stylesheet" type="text/css" href="path-to-scheduler-pro/schedulerpro.[theme].css" id="bryntum-theme">
```

## Use it in your code

From your scripts you can access our classes in the global bryntum namespace:

```javascript
var schedulerPro = new bryntum.schedulerpro.SchedulerPro();
```

For a complete example, check out the <a href="../examples-scheduler/scripttag" target="_blank">scripttag example</a>.


<p class="last-modified">Last modified on 2022-03-04 9:57:14</p>