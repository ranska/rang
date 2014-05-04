@Bp = angular.module( 'app', [])
@Rang.conf.app = @Bp

class @RangedCtrlDrt extends @RangCtrlDrt
  @register()


class @Mimo extends @RangDrt
  @drt: ->
    (scope, element) ->
      element.addClass "plain"
  @register()

###
describe "Directive:\n", ->
  beforeEach ->
    module 'specapp'
  describe 'actionService', ->
    beforeEach inject (RangedCtrlDrt) ->
      @RangedCtrlDrt = RangedCtrlDrt

    describe 'actionService', ->

      it 'return something', ->
        #expect(@RangedSrv.actionService 'demo' ).toBe 'service demo'
###
describe "Hello world", ->
  element = undefined
  $scope = undefined
  beforeEach module("app")
  beforeEach inject(($compile, $rootScope) ->
    $scope = $rootScope
    element = angular
      .element("<div eh-simple>{{2 + 2}}</div>")
    $compile(element) $rootScope
  )
  it "should equal 4", ->
    $scope.$digest()
    expect(element.html()).toBe "4"

  describe "ehSimple", ->
    it "should add a class of plain", ->
      expect(element.hasClass("plain")).toBe true
