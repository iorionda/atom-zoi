AtomZoiView = require './atom-zoi-view'

module.exports =
  atomZoiView: null

  activate: (state) ->
    @atomZoiView = new AtomZoiView(state.atomZoiViewState)

  deactivate: ->
    @atomZoiView.destroy()

  serialize: ->
    atomZoiViewState: @atomZoiView.serialize()
