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


##
#
#
###
class @ItemDrtCtrl extends @ScopeDrtCtrl
  @inject 'ItemService'

  edit: (ol) ->
    @s.$emit "EDIT_ITEM", {ol}

  destroy_ol: (ol) ->
    @ItemService.destroy(ol).then =>
      @s.$emit "RELOAD_ITEMS"

  change_status:  (ol, status) ->
    ItemService.change_status(ol, status)
      .then =>
        @s.$emit "RELOAD_ITEMS"

  cancel_ol: ->
    # TODO Reset change instade of reload all
    @s.$emit "RELOAD_ITEMS"

@Candy.directive "item", ->
  restrict:    "CE"
  remplace:    true
  templateUrl: "/templates/item_tds"
  scope:       false
  controller:  @ItemDrtCtrl
###
#

class @A.ItemCtrlDrt extends RangCtrlDrt
  #@inject 'SomeService'

  # TODO conf is optional  and there is default conf
  conf:
    restrict:    "CE"
    remplace:    true
    # TODO scope on true is not same constructor..
    scope:       false
    # TODO default templateUrl: "/templates/item_tds"
    # TODO created on the fly
    #   controller:  @ItemDrtCtrl

  initialize: ->
    @s.foo = 'bar'

  bar: (param) ->
    somthing_doing_on_the_scope
