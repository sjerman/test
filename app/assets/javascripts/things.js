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