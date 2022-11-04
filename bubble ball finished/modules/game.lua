local physics = require "physics"

--Premade functiom
local function hasCollided(obj1, obj2)

if obj1 == nil then  return false end
if obj2 == nil then  return false end

local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

return (left or right) and (up or down)
end
--

local m ={}

m.isGameRunning = false

local function dragElements (event)
  local self = event.target
  if(m.isGameRunning == true)then
    return true
  end
  if(event.phase == "began") then
		display.getCurrentStage():setFocus(self)
		self.oldX = event.x - self.x
		self.oldY = event.y - self.y
	elseif(event.phase == "moved" ) then
    self.x = event.x - self.oldX
    self.y = event.y - self.oldY

	elseif(event.phase == "ended" or event.phase == "cancelled") then
    display.getCurrentStage():setFocus(nil)
	end
end

local function startElements(elements, objectBox)
  for i = 1, #elements do
  	if (hasCollided(elements[i],objectBox)) then
  		elements[i].isSensor = true
  		elements[i].gravityScale = 0
  	else
  		elements[i].isSensor = false
  		elements[i].gravityScale = 1
  	end
    elements[i].bodyType = "dynamic"
  	elements[i].xStore, elements[i].yStore = elements[i].x, elements[i].y
  end
end
local function stopElements(elements)
  for i = 1, #elements do
    elements[i].rotation = 0
    elements[i].bodyType = "static"
    elements[i].x, elements[i].y = elements[i].xStore, elements[i].yStore
  end
end
local function resetElements(elements)
  for i = 1, #elements do
    elements[i].x, elements[i].y = elements[i].orgX, elements[i].orgY
  end
end


m.start = function (sceneGroup, elements, finish, bubble)
  physics.setGravity(0, 9.8)

  --store poitions and add drag

  bubble.orgX, bubble.orgY = bubble.x, bubble.y
  for i = 1, #elements do
    elements[i].orgX, elements[i].orgY = elements[i].x, elements[i].y
    elements[i]:addEventListener("touch", dragElements)
  end

  --regular display elements
  local bg = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
  bg:setFillColor( .9 )

  local objectBox = display.newRect( sceneGroup, display.contentCenterX, 40, display.actualContentWidth,80 )
  objectBox:setFillColor( .5 )

  objectBox:toBack()
  bg:toBack()

  local startStopButtonRect = display.newRect( sceneGroup, display.contentCenterX+150, 40, 100, 70 )
  local startStopButtonText = display.newText( sceneGroup, "Start",  startStopButtonRect.x, startStopButtonRect.y, systemFont, 20)
  startStopButtonRect:setFillColor( 0,1,0 )

  local function start(  )
  	m.isGameRunning = true
    physics.start()
  	bubble:setLinearVelocity( 0, 0 )
    startElements(elements, objectBox)
  end
  local function stop(  )
  	m.isGameRunning = false
  	physics.pause()
  	bubble.x, bubble.y = bubble.orgX, bubble.orgY
    stopElements(elements)
  end
  startStopButtonRect:addEventListener( "tap", function (  )
  	if (m.isGameRunning == true) then
  		stop( )
  		startStopButtonText.text = "Start"
  		startStopButtonRect:setFillColor( 0,1,0 )
  	else
  		start()
  		startStopButtonText.text = "Stop"
  		startStopButtonRect:setFillColor( 1,0,0 )
  	end
  end )

  local function reset(  )
  	bubble.x, bubble.y = bubble.orgX, bubble.orgY
    resetElements(elements)
    physics.pause()
  	startStopButtonText.text = "Start"
    m.isGameRunning = false
  	startStopButtonRect:setFillColor( 0,1,0 )
  end
  local function onLocalCollision( event )
   		if (event.phase == "began" and event.target.name== "finish" and event.other.name == "bubble") then
   			bubble:setLinearVelocity( 0, 0 )
        native.showAlert( "You Beat Game", "Congrats", {"Reset"}, function (  )
          		reset()
        end )
      end
  end
  finish:addEventListener( "collision",onLocalCollision )
  bubble:addEventListener( "collision",onLocalCollision )
end

return m
