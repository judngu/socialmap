var width = 700,
  height = 700;

var color = d3.scale.category20();

var force = d3.layout.force()
  .charge(-120)
  .linkDistance(300)
  .size([width, height]);

var svg = d3.select("body").append("svg")
  .attr("width", width)
  .attr("height", height);

var data = document.getElementById('data').innerHTML;
  graph = JSON.parse(data);

force.nodes(graph.nodes)
  .links(graph.links)
  .start();

var link = svg.selectAll(".link")
  .data(graph.links)
  .enter().append("line")
  .attr("class", "link")
  .style("marker-end",  "url(#suit)")
;

svg.append("defs").selectAll("marker")
  .data(["suit", "licensing", "resolved"])
.enter().append("marker")
  .attr("id", function(d) { return d; })
  .attr("viewBox", "0 -5 10 10")
  .attr("refX", 25)
  .attr("refY", 0)
  .attr("markerWidth", 15)
  .attr("markerHeight", 15)
  .attr("orient", "auto")
.append("path")
  .attr("d", "M0,-5L10,0L0,5 L10,0 L0, -5")
  .style("stroke", "#999")
  .style("opacity", "0.6");


var node = svg.selectAll(".node")
  .data(graph.nodes)
  .enter().append("g")
  .attr("class", "node")
  .call(force.drag);

node.append("circle")
  .attr("r", 15)
  .style("fill", function (d) {
  return color(d.group);
})

node.append("text")
  .attr("dx", 20)
  .attr("dy", ".35em")
  .text(function(d) { return d.name });

force.on("tick", function () {
  link.attr("x1", function (d) {
      return d.source.x;
  })
      .attr("y1", function (d) {
      return d.source.y;
  })
      .attr("x2", function (d) {
      return d.target.x;
  })
      .attr("y2", function (d) {
      return d.target.y;
  });

  d3.selectAll("circle").attr("cx", function (d) {
      return d.x;
  })
      .attr("cy", function (d) {
      return d.y;
  });

  d3.selectAll("text").attr("x", function (d) {
      return d.x;
  })
      .attr("y", function (d) {
      return d.y;
  });

});
