#
# work in progress from real word app
#
#

controller_describe = (controller, yeild) ->
  # TODO controller name build with consise on formal form
  describe "controller:\n", ->
    @$scope     = null
    @$rootScope = null
    @controller = null
   
    beforeEach module window.Rang.conf.app
    #load all modules, including the html template, needed to support the test
    # TODO dynamic path build base on name
    #beforeEach module "spec/views/ng/first.html"
      #assign the template to the expected url called by the directive and put it in the cache
    beforeEach inject ($templateCache, _$compile_, _$rootScope_, $controller, $q) ->
      @$scope     = _$rootScope_.$new()
      @$rootScope = _$rootScope_.$new()
      #@template   = $templateCache.get "spec/views/ng/first.html"
      @controller = $controller controller,
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
