-- Elemento necesario
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")

-- local forward references should go here --
local acc = {}
local centerX = display.contentWidth * 0.5
local centerY = display.contentHeight * 0.5

local function btnTap(event)
	storyboard.gotoScene (  event.target.destination, {effect = "fade"} )
	return true
end

local function accelerometero( event )
    character.x = centerX - (centerX * event.xGravity)
    character.y = centerY - (centerY * event.yGravity)
end 


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local background = display.newImageRect( "background.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	group:insert(background)

	local introBtn = widget.newButton
	{
	width = 110,
    height = 110,
    defaultFile = "crate.png",
    overFile = "crate.png",
    --onPress = hola 
    --label="Options",
	--labelColor = { default = { 250, 255, 250}, over ={0,0,0  }},fontSize = "46",
	}
	introBtn.x = centerX - (centerX/1.5)
	introBtn.y = centerY*1.2
	introBtn.destination = "menu"
	introBtn:addEventListener("tap", btnTap)
	group:insert(introBtn)


	--sprite con en una sola imagen
	local sheetW = { width=80, height=60,  numFrames=9 }
	local sheetWario = graphics.newImageSheet( "wario.png", sheetW )

	local sequenceDataWario =
	{
	    { name="walking", start=1, count=3,time=700 ,loopCount=0 },
	    { name="running", start=4, count=3,time=1000,loopCount=0 },
	    { name="jumping", start=8, count=4, time=800 ,loopCount=0 }
	}

	character = display.newSprite( sheetWario, sequenceDataWario )

	character.x = display.contentWidth / 3 --posicion inicial x 
	character.y = 280 --posicion inicial y
	character.h = 60
	character.w = 80


	--group:insert( sheetWario )
	group:insert( character )

	character:play( )
	
--hol
	
end



-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	-- INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view

	-- INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks

end



Runtime:addEventListener("accelerometer", accelerometero)

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )


---------------------------------------------------------------------------------

return scene---------------------------------------------------------

