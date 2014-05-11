@Bp = angular.module( 'app', [])
@Rang.conf.app = @Bp

class @RangedCtrlDrt extends @RangCtrlDrt
  @register()


class @JusteLeblancDrt extends @RangDrt
  @drt: ->
    (scope, element) ->
      element.addClass "plain"
  @register()

describe "Directive\n", ->
  element = undefined
  $scope = undefined
  beforeEach module("app")
  beforeEach inject ($compile, $rootScope) ->
    $scope = $rootScope
    element = angular
      .element "<div juste-leblanc>{{2 + 2}}</div>"
    $compile(element) $rootScope

  it "should equal 4", ->
    $scope.$digest()
    expect(element.html()).toBe "4"

  describe "function directive by autoname", ->

    it "should add a class of plain", ->
      expect(element.hasClass("plain")).toBe true
