local physics = require "physics"


--Premade function
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




return m
