@Bp = angular.module( 'specapp', [])
@Rang.conf.app = @Bp

class @RangedCtrl extends @ScopeCtrl
  @register window.Bp
  scopedFunction: (arg) ->
    @s.scopedArg = arg

##
# helper provide @$scope @$rootScope and @controller
# module app is set
#
#
# TODO HELP ME !!! i don't know how to test it
#
xdescribe "controller spec helper:\n", ->

  it '@$scope', ->
    @helper = controller_describe @RangedCtrl, null 
    expect(@helper).toBe true
    console.log @helper
    #expect(@helper.$scope).toBe true

