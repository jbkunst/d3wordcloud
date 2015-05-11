var la;
HTMLWidgets.widget({

  name: 'd3wordcloud',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required

    };

  },

  renderValue: function(el, x, instance) {

    console.log(el);
    console.log(x);

    la = el;

    var data = HTMLWidgets.dataframeToD3(x.data);

    console.log(data);

    var width = el.offsetWidth;
    var height = el.offsetHeight;

    var fill = d3.scale.category20();
    var scale = d3.scale.log()
      .domain([d3.min(data, function(d) { return d.size; }),
               d3.max(data, function(d) { return d.size; })])
      .range([10, 90]);

    d3.layout.cloud()
      .size([width, height])
      .words(data)
      .padding(5)
      .rotate(function() { return Math.floor(Math.random() * 120) + 1 - 60; })
      .font("Impact")
      .fontSize(function(d) { return d.size; })
      .on("end", draw)
      .start();

    function draw(words) {
      d3.select(el).append("svg")
        .attr("width", width)
        .attr("height", height)
        .append("g")
        //.attr("transform", "translate(150,150)")
        .attr("transform", "translate("+ width/2 +","+ height/2+")")
        .selectAll("text")
        .data(words)
        .enter().append("text")
        .style("font-size", function(d) { return scale(d.size) + "px"; })
        .style("fill", function(d, i) { return fill(i); })
        .style("font-family", "Impact")
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
