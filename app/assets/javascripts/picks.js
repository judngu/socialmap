var color = d3.scale.category20();

var force = d3.layout.force()
  .charge(-120)
  .linkDistance(250)
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
  .attr("refX", 15)
  .attr("refY", 0)
  .attr("markerWidth", 15)
  .attr("markerHeight", 15)
  .attr("orient", "auto")
.append("path")
  .attr("d", "M0,-5L10,0L0,5 L10,0 L0, -5")
  .style("stroke", "#999")
  .style("opacity", "0.4");


var node = svg.selectAll(".node")
  .data(graph.nodes)
  .enter().append("g")
  .attr("class", "node")
  .call(force.drag)
   .on('dblclick', connectedNodes); //Added code ;

node.append("circle")
  .attr("r", 10)
  .style("fill", function (d) {
  return color(d.group);
})


node.append("text")
  .attr("dx", 10)
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
  node.each(collide(0.5));
});

var padding = 50,
    radius=20;
function collide(alpha) {
  var quadtree = d3.geom.quadtree(graph.nodes);
  return function(d) {
    var rb = 2*radius + padding,
        nx1 = d.x - rb,
        nx2 = d.x + rb,
        ny1 = d.y - rb,
        ny2 = d.y + rb;
    quadtree.visit(function(quad, x1, y1, x2, y2) {
      if (quad.point && (quad.point !== d)) {
        var x = d.x - quad.point.x,
            y = d.y - quad.point.y,
            l = Math.sqrt(x * x + y * y);
          if (l < rb) {
          l = (l - rb) / l * alpha;
          d.x -= x *= l;
          d.y -= y *= l;
          quad.point.x += x;
          quad.point.y += y;
        }
      }
      return x1 > nx2 || x2 < nx1 || y1 > ny2 || y2 < ny1;
    });
  };
}

var toggle = 0;

var linkedByIndex = {};
for (i = 0; i < graph.nodes.length; i++) {
    linkedByIndex[i + "," + i] = 1;
};
graph.links.forEach(function (d) {
    linkedByIndex[d.source.index + "," + d.target.index] = 1;
});
function neighboring(a, b) {
    return linkedByIndex[a.index + "," + b.index];
}
function connectedNodes() {
    if (toggle == 0) {
        d = d3.select(this).node().__data__;
        node.style("opacity", function (o) {
            return neighboring(d, o) | neighboring(o, d) ? 1 : 0.1;
        });
        link.style("opacity", function (o) {
            return d.index==o.source.index | d.index==o.target.index ? 1 : 0.1;
        });
        toggle = 1;
    } else {
        node.style("opacity", 1);
        link.style("opacity", 1);
        toggle = 0;
    }
}
