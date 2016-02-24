# site-load-tester

An app to load test a website and return latency information in a useful form.

## Running the app

Set the URL(s) that you want to load test in `urls.txt` following the format `GET 192.168.0.1`

Run `cf push` in the app directory.  Note you must be logged into a Cloud Foundry space and have the ability to deploy apps to it.
The app will be called `site-load-test` by default (changeable in `manifest.yml`) and will start the load test immediately.

## Looking at results

On conclusion of the load test a variety of reports will be available.

`/dump.[csv,json]` and `report.[json,plot,text]` are the default dumps and reports produced by vegeta

`plot.html` is a graph produced using data from `dump.json` and plotly.js

## Collecting results

By running `./collect.sh site-load-test` you can retrieve all the availble result files.  Files will be prepended with the current time (unix) and will be place in `/data`

## Modifying `plot.html`

Should you want to edit what is shown in the plot, the JavaScript that generates it can be found in `/components/plot_script.js`

### Sources
This app utilises:
vegeta - https://github.com/tsenart/vegeta
plotly - https://github.com/plotly/plotly.js
