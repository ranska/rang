@Bp = angular.module( 'specapp', [])
@Rang.conf.app = @Bp

class @DefaultSrv extends @RangSrv
  @register()
  scopedFunction: (arg) ->
    @s.scopedArg = arg

describe "register:\n", ->
  beforeEach ->
    module 'specapp'
 
  describe 'actionService', ->
    beforeEach inject (DefaultSrv) ->
      @DefaultSrv = DefaultSrv

    describe 'actionService', ->

      it 'return something', ->
        expect(@DefaultSrv isnt undefined).toBe true
      
class @RangedSrv extends @RangSrv
  @register window.Bp
  actionService: (arg) ->
    "service #{arg}"
describe "service:\n", ->
  beforeEach ->
    module 'specapp'
 
  describe 'actionService', ->
    beforeEach inject (RangedSrv) ->
      @RangedSrv = RangedSrv

    describe 'actionService', ->

      it 'return something', ->
        expect(@RangedSrv.actionService 'demo' ).toBe 'service demo'

