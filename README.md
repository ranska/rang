# Rang

[![Travis CI   ](http://img.shields.io/travis/ranska/rang/master.svg)](https://travis-ci.org/ranska/rang)

Rang is a set of coffeescript class who help you to make your angular code
more clean and dry and ready for mimification.

## Installation

Rails users see rang rails gem


## What is it ?


As allways a good example is better than a long text.

Here a classic example extract from the official website

```javascript
// without mimification ready
angular.controller('ListCtrl', function($scope, Projects) {
  $scope.projects = Projects;
})
 
angular.controller('CreateCtrl', function($scope, $location, $timeout, Projects) {
  $scope.save = function() {
    Projects.$add($scope.project, function() {
      $timeout(function() { $location.path('/'); });
    });
  };
})
 
angular.controller('EditCtrl',
  function($scope, $location, $routeParams, $firebase, fbURL) {
    var projectUrl = fbURL + $routeParams.projectId;
    $scope.project = $firebase(new Firebase(projectUrl));
 
    $scope.destroy = function() {
      $scope.project.$remove();
      $location.path('/');
    };
 
    $scope.save = function() {
      $scope.project.$save();
      $location.path('/');
    };
});
````

And then the same with rang flavour.

```coffeescript
@Myapp = angular.module("myapp", []) 
  # every class can be write in separated file

class Projects extends ScopeCtrl 
  #rang provide ScopeCtrl with $scope injection 
  #there is also RangCtrl without any injection
  @inject 'Projects' 
  #inject class methode write string for injection

class List extends Projects
  @register window.Myapp # add your controller to your app
  # Note you don't need register parent controller
 
  hello: ->
    'hello'
  # every class methode are authomaticaly added to $scope

  # initialize is call on Ctrl start after injection
  initialize: ->
    @s.projects = @Projects
  # @Projects is an injection used as an attribute

class CreateCtrl extends Projects
  @register window.Myapp
  @inject '$location $timeout'
  # you can add many injection in one string # or a string array if you like

  save: ->
    @Projects.$add @s.project, ->
      @$timeout ->
        @$location.path "/"
  # @s is an alias of the long @$scope

class EditCtrl extends ScopeCtrl 
  @register window.Myapp
  @inject '$location $routeParams $firebase fbURL'

  initialize: ->
    @projectUrl = @fbURL + @$routeParams.projectId

  project: 
    @$firebase new Firebase(projectUrl)

  destroy: ->
    @s.project.$remove()
    @_root_redirect()

  save: ->
    @s.project.$save()
    @_root_redirect()

  _root_redirect: ->
    @$location.path "/"
  # _(method_name) are like private methode aka never add to $scope i.e: @s 


````
## Usage

key feature are 
injection
as string or string array (ready to mimified)
Injection are @(InjectionName) attribute 

extends injection
RangCtrl > ScopeCtrl > YourCtrl

Cool $scope alias @s

in service or controller allways use same syntaxe
every attribute are attach to $@scope

register to app

initialise are locate in allways the same methode name

With rang
You have a more object oriended style and a better convension over config
approche, what is good when you work in team

### Register
The basic way is to pass the app as a parameter

```coffeescript
@App = angular.module( 'app', [])

class @CoolCtrl extends @ScopeCtrl
  @register window.App
````
  
  You can register without parameter if you configure rang before

```coffeescript
@App = angular.module( 'app', [])

@Rang.conf.app = @App

class @CoolCtrl extends @ScopeCtrl
  @register() 
````
  
Register type aka: app.service, app.controller is found by class name
so you must name your class ended by Ctrl, Srv (Todo Fac)  

  next version @rang() will register and inject on the same call

### Service

the class @RangSrv act same as a controller. ie: there regsiter and injection
but no @s for scope.
There class @RestSrv extends @RangSrv who inject restangular 
(TODO DOC look the code please) default url for rest api.

### Directive

(TODO 0.2.0 ) default template url base on class name

### Jasmine

TODO 0.3.0) I love the idea that rang should give some class like 
RangSrvSpec or RangCtrlSpec with all the setup done for you.

### RND
for the next steps I want to implement callback 
like rails before_call

Fell free to ask question submit new idea or just express your feeling in issus
TODO create google groupe.




 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
