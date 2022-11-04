local composer = require( "composer" )
local physics = require "physics"
local game = require "modules.game"
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
		--setup physics

		physics.start( )
	  physics.pause( )

		local ground = display.newRect( sceneGroup, display.contentCenterX, display.actualContentHeight-50, 400, 100 )
		ground:setFillColor( 0 )
		physics.addBody(ground, "static",{bounce=.1,friction = 1})


		local finish = display.newImageRect( sceneGroup, "assets/finish.png", 50,50 )
		finish.x, finish.y = 350, 195
		finish.name = "finish"
		finish:setFillColor( .5)
		finish.alpha=.5
		physics.addBody( finish, "static" )
		finish.isSensor = true

		local bubble = display.newCircle( sceneGroup, 90, 120, 15 )
		physics.addBody( bubble, "dynamic", {radius = 15, bounce = .4} )
		bubble.name = "bubble"
		bubble:setFillColor( .3,.6,1 )

		--Game elements
		local elements = {}

		local rightTriangle = display.newPolygon( sceneGroup, display.contentCenterX-90, 40, {0,0, 0,70, 70,70} )
		rightTriangle:setFillColor( 1,1,.5 )
		physics.addBody( rightTriangle, "dynamic",{bounce = 0, friction = 1, shape={-35,-35,-35,35,35,35 }} )
		rightTriangle.isSensor = true

		table.insert( elements, rightTriangle )

		--Load Game Mod
		game.start(sceneGroup, elements, finish, bubble)



end




-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )

-- -----------------------------------------------------------------------------------

return scene
