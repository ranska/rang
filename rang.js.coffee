# dependency - Function.prototype.bind or underscore/lodash
 
class @Rang
  @inject: (args...) ->
    if args.length is 1
      args = args[0].split ' '
    if @$inject?.length > 0
      for arg in args
        @$inject.push arg
    else
      @$inject = args
 
  constructor: (args...) ->
    for key, index in @constructor.$inject
      @[key] = args[index]
 
class @RangCtrl extends @Rang
  @register: (app, name) ->
    name ?= @name || @toString().match(/function\s*(.*?)\(/)?[1]
    app.controller name, @
 
  constructor: (args...) ->
    super args...
    @s = @$scope
    for key, fn of @constructor.prototype
      continue unless typeof fn is 'function'
      continue if key in ['constructor', 'initialize'] or key[0] is '_'
      @s[key] = fn.bind?(@) || _.bind(fn, @)
 
    @initialize?()

class @ScopeCtrl extends @RangCtrl
  @inject '$scope'
