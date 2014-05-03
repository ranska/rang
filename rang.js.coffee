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

  @conf:
    app: null
 
  constructor: (args...) ->
    if @constructor.$inject?
      for key, index in @constructor.$inject
        @[key] = args[index]

##
#  Base is now used as mixin for shearing
#  register between ctrl srv 
#  but not drt (directive aren't register)
#  TODO find a way to factorize the 2 first line
#
class RangBase
  @register: (app, name) ->
    app = @conf.app unless app?
    name ?= @name || @toString().match(/function\s*(.*?)\(/)?[1]
    switch name.match(/[A-Z]*[^A-Z]+/g)[-1..][0]
      when 'Ctrl'
        app.controller name, @
      when 'Srv'
        app.service name, @

class @RangCtrl extends @Rang
  @register: RangBase.register
 
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

##
#  Service
#
#
class @RangSrv extends @Rang
  @register: RangBase.register

  constructor: (args...) ->
    super args...
    @initialize?()
 
class @RestSrv extends @RangSrv
  @inject 'Restangular'

  constructor: (args...) ->
    super args...
    @api = @Restangular.one 'api/v1'

##
# Directive
#
class @RangCtrlDrt extends @Rang
  @register: (app, name) ->
    name ?= @name || @toString().match(/function\s*(.*?)\(/)?[1]
    drtName = name.match(/[A-Z]*[^A-Z]+/g)
    drtName = drtName[0...drtName.length-2].join ''
    console.log drtName
    @conf.app.directive drtName, ->
      restrict:    "ACE"
      remplace:    true
      templateUrl: "/rang_templates/#{drtName}"
      scope:       false
      controller:  this

  constructor: (args...) ->
    super args...
    @s = @$scope
    for key, fn of @constructor.prototype
      continue unless typeof fn is 'function'
      continue if key in ['constructor', 'initialize'] or key[0] is '_'
      @s[key] = fn.bind?(@) || _.bind(fn, @)
 
    @initialize?()

class @ScopeCtrlDrt extends @RangCtrlDrt
  @inject '$scope'
###
###
