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
###
#
#
#


#
# work in progress from real word app
#
#

directive_describe = (directive_controller, yeild) ->
  # TODO controller name build with consise on formal form
  describe "Franco controller:\n", ->
    @$scope     = null
    @$rootScope = null
   
    beforeEach module 'candy'
    #load all modules, including the html template, needed to support the test
    # TODO dynamic path build base on name
    beforeEach module "spec/views/ng/first.html"
      #assign the template to the expected url called by the directive and put it in the cache
    beforeEach inject ($templateCache, _$compile_, _$rootScope_, $controller, $q) ->
      @$scope     = _$rootScope_.$new()
      @$rootScope = _$rootScope_.$new()
      @template   = $templateCache.get "spec/views/ng/first.html"
      @controller = $controller directive_controller,
        {@$rootScope, @$scope}

    yeild()

###
directive_describe 'FrancoDrtCtrl', ->
  describe "show button", ->
    it 'is_complete', ->
      expect(@$scope.is_complete()).toBe true
      console.log @template

###


###
  xdescribe "init:\n", ->
    it 'should assign role in the $scope', ->
      $scope.init('webdesigner', 'Benoit')
      expect($scope.role).toBe('webdesigner')

  xdescribe "search_product_by_name", ->
    it "show no result when no pattern", ->
      $scope.search_product_name = ''
      
      expect($scope.products.length).toBe 0
  #  $compile = _$compile_
  #  @$rootScope = _$rootScope_
  #  return
  
it "should display 3 text input fields, populated with ssn data", ->
  console.log 'first try'
    #ssn1 = "123"
    #ssn2 = "45"
    #ssn3 = "6789"
    #@$rootScope.ssn = ssn1 + ssn2 + ssn3
    
    #create the element angularjs will replace with the directive template
    #formElement = angular.element("<div ssn ng-model=\"ssn\"></div>")
    #element = $compile(formElement)($rootScope)
    #$rootScope.$digest()
    #expect(element.find("input").length).toEqual 3

###
