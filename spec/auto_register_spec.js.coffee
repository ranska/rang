@Bp = angular.module( 'specapp', [])
@Rang.conf.app = @Bp

class @A.TotoCtrl extends @ScopeCtrl

  scopedFunction: (arg) ->
    @s.scopedArg = arg

@Ether.nyx = @A
res = @Ether.find finish_by: 'Ctrl'
# verify has no methods
# has no controller
# add register
# call it
# verify is in controller app
for klass, def of res
  @Ether.run_to_class klass, 'register'

describe "controller:\n", ->
  $scope = null
  $rootScope = null
 
  beforeEach(module('specapp'))

  beforeEach inject (_$rootScope_, $controller) ->
    $scope = _$rootScope_.$new()
    $rootScope = _$rootScope_.$new()

    controller = $controller "A.TotoCtrl",
      {$rootScope
      $scope}

  # TODO how can unit test register

  # TODO split in 2 test
  describe "scope extends and sugar syntax:\n", ->
    it 'should assign role in the $scope', ->
      testedValue = "it's works baby"
      $scope.scopedFunction testedValue
      expect($scope.scopedArg).toBe testedValue
