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
class @RangDrt
  @register: ->
    window.Bp.directive @toDrtName(), =>
      @drt()

  @toDrtName: ->
    # TODO or @toString
    name  = @name.split('Drt')[0]
    start = name[0].toLowerCase()
    start + name.substr(1)

##
#  ONDO Directive with conf and controller
#
class @RangCtrlDrt extends @Rang
  @register: (app, name) ->
    name ?= @name or @toString().match(/function\s*(.*?)\(/)?[1]
    drtName = name.match(/[A-Z]*[^A-Z]+/g)
    drtName = drtName[0...drtName.length-2].join ''
    #console.log drtName

    @conf.app.directive drtName, ->
      restrict:    "ACE"
      remplace:    true
      templateUrl: "/rang_templates/#{drtName}"
      scope:       false
      #controller:  this

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
# 
#  directive spec
#
# 
###

create_ctrl_drt: (conf, ctrl_name, methods) ->
  # 1 ) creer une directive avec les conf par défault
  # 2 ) les conf perso override les conf default
  # 3 ) un controller default name est créé
  # 4 ) l'initialisation est les méthodes lui sont injecté
  # 5 ) la gestion du @s ou scope et prise en compte
  # 6 ) le constructor recoit les ordres sécifique au 5..
  # 7 ) la registration en tant que service s'effectue
  # 1
  conf_default =
    restrict:    "ACE"
    remplace:    true
    templateUrl: "/rang_templates/#{drtName}"
    scope:       false
  # 2
  drt_conf = merge_conf conf_default, conf
  # 3
  drt_ctrl = create_empty_crtl ctrl_name
  # 4 
  populate_ctrl drt_ctrl, methods
  # 5
  type_scope =  witch_scope drt_ctrl, drt_conf
  # 6
  mount_methods drt_ctrl, type_scope
  # 6.5 
  #  3-6 only if no conf ctrl
  #  then add self builded ctrl to conf
  #
  # 7
  register_drt drt_conf



