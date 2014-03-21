
@Bp = angular.module( 'specapp', [])
class @RangedCtrl extends @ScopeCtrl
  @register window.Bp
  scopedFunction: (arg) ->
    @s.scopedArg = arg

describe "controller:\n", ->
  $scope = null
  $rootScope = null
 
  beforeEach(module('specapp'))

  beforeEach inject (_$rootScope_, $controller) ->
    $scope = _$rootScope_.$new()
    $rootScope = _$rootScope_.$new()

    controller = $controller "RangedCtrl",
      {$rootScope
      $scope}

  # TODO how can unit test register

  # TODO split in 2 test
  describe "scope extends and sugar syntax:\n", ->
    it 'should assign role in the $scope', ->
      testedValue = "it's works baby"
      $scope.scopedFunction testedValue
      expect($scope.scopedArg).toBe testedValue

class @RangedSrvc extends @RangSrvc
  @register window.Bp
  actionService: (arg) ->
    "service #{arg}"

describe "service:\n", ->
  beforeEach ->
    module 'specapp'
 

  describe 'actionService', ->
    beforeEach inject (RangedSrvc) ->
      @RangedSrvc = RangedSrvc

    describe 'actionService', ->

      it 'return something', ->
        expect(@RangedSrvc.actionService 'demo' ).toBe 'service demo'
