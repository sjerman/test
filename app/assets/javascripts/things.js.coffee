# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
require ["dojo/router", "dojo/dom", "dojo/fx", "dojo/domReady!"], (router, dom, fx) ->
  router.register "/articles/:id", (evt) ->
    alert "The article has the id " + evt[id]

  router.startup()

  greeting = dom.byId("greeting")
  greeting.innerHTML += " from Dojo!"

  fx.slideTo({
    top: 100,
    left: 200,
    node: greeting
  }).play()