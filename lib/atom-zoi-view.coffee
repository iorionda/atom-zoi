{$, BufferedProcess, EditorView, View} = require 'atom'

request = require 'request'
uri     = 'http://zoi.herokuapp.com/js/services.js'

module.exports =
class AtomZoiView extends View
  @content: ->
    @div class: 'atom-zoi', ->

  initialize: (serializeState) ->
    atom.workspaceView.command "atom-zoi:insert", => @insert()

  serialize: ->

  destroy: ->
    @detach()

  insert: ->
    editor = atom.workspace.getActiveEditor()

    getZoi
      onZoi: (zoi) ->
        editor.insertText("![zoi](#{zoi})")
      onError: (err) ->
        editor.insertText("![zoi](https://pbs.twimg.com/media/BspWc7LCAAAPzhS.jpg:large): #{err}")

  getZoi = (cb) ->
    request(uri, (error, response, body) ->
      if !error && response.statusCode == 200
        zois = body.match(/image: 'https:\/\/pbs.twimg.com\/media\/.+.jpg:large'/mg)
                   .map((l) -> l.match("'(https.+\.jpg):large'")[1])
        zoi = zois[Math.floor(Math.random() * zois.length)]
        (cb.onZoi || cb.onSuccess)(zoi)
      else
        cb.onError(error)
      )
