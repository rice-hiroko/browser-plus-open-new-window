{CompositeDisposable} = require 'atom'

module.exports = BrowserPlusOpenNewWindow =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

  consumeAddPlugin: (@bp)->
    requires =
      menus:[
        {
         name: "Open in new tab"
         selector: "a,img"
         selectorFilter: (evt,data)->
           if jQuery(@).is('a')
             return false unless @href
             return false if @href.startsWith('javascript')
           else
             return false if(@src.startsWith("data"))
             return false unless @src
           return true

         fn: (evt,data)->
           if jQuery(@).is('a')
             return true unless @href
             return true if @href.startsWith('javascript')
             window.open(@href)
           else
             return true if(@src.startsWith("data"))
             return true unless @src
             window.open(@src)
        }
      ]
    @bp.addPlugin requires

  deactivate: ->
    @subscriptions.dispose()
