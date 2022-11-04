--

local composer = require( "composer" )

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


		local bg = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
		bg:setFillColor( .3,.6,1 )

		local title = display.newText( sceneGroup, "Bubble Ball", display.contentCenterX, display.contentCenterY-120, native.systemFontBold, 50 )

		local play = display.newText( sceneGroup, "Play", display.contentCenterX, display.contentCenterY, native.systemFont, 25 )
		play:addEventListener( "tap", function (  )
			play.alpha = .5

			timer.performWithDelay( 300, function ( )
					play.alpha = 1
					composer.gotoScene( "scenes.level,1" )
				end )

		end )

end



-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
-- -----------------------------------------------------------------------------------

return scene
