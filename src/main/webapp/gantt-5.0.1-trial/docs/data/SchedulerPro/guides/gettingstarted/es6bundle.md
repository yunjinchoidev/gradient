# Loading using EcmaScript module bundle

## Include CSS

Include the CSS for the theme you want to use on page:

```html
<link rel="stylesheet" type="text/css" href="path-to-scheduler-pro/schedulerpro.[theme].css" id="bryntum-theme">
```

## Import from the module bundle

In your application code, import the classes you need from the bundle:

```javascript
import { SchedulerPro } from '../build/schedulerpro.module.js';
```

And then use them:

```javascript
const schedulerPro = new SchedulerPro({
    /*...*/
})
```

For a complete example, check out the <a href="../examples-scheduler/esmodule" target="_blank">EcmaScript module example</a>.


<p class="last-modified">Last modified on 2022-03-04 9:57:14</p>