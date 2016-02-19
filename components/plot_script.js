'</div>
<script>
  var json = JSON.parse(document.getElementById('json').getAttribute('data-json'));
  var x_array = [];
  var y_array = [];
  for (var i=0; i < json.length-1; i++) {
    x_array.push(json[i]["timestamp"])
    var y_val = parseInt(json[i]["latency"])/1000000;
    y_array.push(y_val);
  }

  var avg = average(y_array);
  var stdDev = standardDeviation(y_array);

  var avg_line = [];
  var one_above = [];
  for (var i=0; i<json.length-1; i++) {
    avg_line.push(avg);
    one_above.push(avg+stdDev);
  }

  var trace0 = {
    x: x_array,
    y: y_array,
    name: 'Latency',
    type: 'scatter'
  };

  var trace1 = {
    x: x_array,
    y: avg_line,
    name: 'Average Latency',
    type: 'scatter'
  };

  var trace2 = {
    x: x_array,
    y: one_above,
    name: 'One standard deviation above mean',
    type: 'scatter'
  };

  var data = [trace0, trace1, trace2];
  Plotly.newPlot('myDiv', data);


  function average(data) {
    var sum = data.reduce(function(sum, value) {
      return sum + value;
      }, 0);
    var avg = sum/data.length;
    return avg;
  }

  function standardDeviation(values) {
    var avg = average(values);
    var squareDiffs = y_array.map(function(value) {
      var diff = value - avg;
      var sqrDiff = diff * diff;
      return sqrDiff;
    });
    var avgSquareDiff = average(squareDiffs);
    var stdDev = Math.sqrt(avgSquareDiff);
    return stdDev;
  }
</script>