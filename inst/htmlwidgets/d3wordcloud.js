HTMLWidgets.widget({

  name: 'd3wordcloud',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required

    }

  },

  renderValue: function(el, x, instance) {

    console.log(el);

    var data = HTMLWidgets.dataframeToD3(x.data);

    var fill = d3.scale.category20();

    var scale = d3.scale.linear()
      .domain([d3.min(data, function(d) { return d.size; }),
               d3.max(data, function(d) { return d.size; })])
      .range([10, 90]);

    d3.layout.cloud().size([300, 300])
      .words(data)
      .padding(5)
      .rotate(function() { return ~~(Math.random() * 2) * 90; })
      .font("Impact")
      .fontSize(function(d) { return d.size; })
      .on("end", draw)
      .start();

    function draw(words) {
      d3.select(el).append("svg")
        .attr("width", "100%")
        .attr("height", "100%")
        .append("g")
        .attr("transform", "translate(150,150)")
        .selectAll("text")
        .data(words)
        .enter().append("text")
        .style("font-size", function(d) { return scale(d.size) + "px"; })
        .style("font-family", "Impact")
        .style("fill", function(d, i) { return fill(i); })
        .attr("text-anchor", "middle")
        .attr("transform", function(d) {
          return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
        })
        .text(function(d) { return d.text; });
    }

  },

  resize: function(el, width, height, instance) {

  }

});
