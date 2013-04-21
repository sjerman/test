require(["dojo/fx", "dojo/dom", "dojo/dom-geometry", "dojo/on", "dojo/domReady!"],
function(coreFx, dom, domGeom, on){

  function slideIt(amt){
    coreFx.slideTo({
      node: "basicNode",
      top: domGeom.getMarginBox("basicNode").t.toString(),
      left: (domGeom.getMarginBox("basicNode").l + amt).toString(),
      unit: "px"
    }).play();
  }

  on(dom.byId("slideRightButton"), "click", function(){
    slideIt(200);
  });
  on(dom.byId("slideLeftButton"), "click", function(){
    slideIt(-200);
  });
});

require(["dgrid/Grid", "dojo/domReady!"], function(Grid){
    var data = [
        { first: "Bob", last: "Barker", age: 89 },
        { first: "Vanna", last: "White", age: 55 },
        { first: "Pat", last: "Sajak", age: 65 }
    ];
 
    var grid = new Grid({
        columns: {
            first: "First Name",
            last: "Last Name",
            age: "Age"
        }
    }, "grid");
    grid.renderArray(data);
});