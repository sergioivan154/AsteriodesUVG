local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")

-- metodo para cambiar de pantalla
local function btnTap(event)
	storyboard.gotoScene (  event.target.destination, {effect = "fade"} )
	return true
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local background = display.newImageRect( "background.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	group:insert(background)

	-- create custom buttom
	local planets1 = widget.newButton
	{
	width = 80,
    height = 80,
    defaultFile = "asteroide.png",
    overFile = "asteroide.png",
    --onPress = holi
    --label="Options",
	--labelColor = { default = { 250, 255, 250}, over ={0,0,0  }},fontSize = "46",
	}
	planets1.x = centerX - (centerX/1.5)
	planets1.y = centerY*.7
	planets1.destination = "nivel1"
	planets1:addEventListener("tap", btnTap)
	group:insert(planets1)


	local planets2 = widget.newButton
	{
	width = 80,
    height = 80,
    defaultFile = "asteroide.png",
    overFile = "asteroide.png",
    --label="Options",
	--labelColor = { default = { 250, 255, 250}, over ={0,0,0  }},fontSize = "46",
	}
	planets2.x = centerX
	planets2.y = centerY*.7
	--planets2.destination = "nivel1"
	--planets2:addEventListener("tap", btnTap)
	group:insert(planets2) 

	local planets3 = widget.newButton
	{
	width = 80,
    height = 80,
    defaultFile = "asteroide.png",
    overFile = "asteroide.png",
    --onPress = hola 
    --label="Options",
	--labelColor = { default = { 250, 255, 250}, over ={0,0,0  }},fontSize = "46",
	}
	planets3.x = centerX + (centerX/1.5)
	planets3.y = centerY*.7
	--planets3.destination = "options"
	--planets3:addEventListener("tap", btnTap)
	group:insert(planets3)


	local planets4 = widget.newButton
	{
	width = 80,
    height = 80,
    defaultFile = "asteroide.png",
    overFile = "asteroide.png",
    --onPress = holi
    --label="Options",
	--labelColor = { default = { 250, 255, 250}, over ={0,0,0  }},fontSize = "46",
	}
	planets4.x = centerX - (centerX/1.5)
	planets4.y = centerY*1.5
	--planets4.destination = "nivel1"
	--planets4:addEventListener("tap", btnTap)
	group:insert(planets4)

	local planets5 = widget.newButton
	{
	width = 80,
    height = 80,
    defaultFile = "asteroide.png",
    overFile = "asteroide.png",
    --onPress = holi
    --label="Options",
	--labelColor = { default = { 250, 255, 250}, over ={0,0,0  }},fontSize = "46",
	}
	planets5.x = centerX 
	planets5.y = centerY*1.5
	--planets5.destination = "nivel1"
	--planets5:addEventListener("tap", btnTap)
	group:insert(planets5)

	local planets6 = widget.newButton
	{
	width = 80,
    height = 80,
    defaultFile = "asteroide.png",
    overFile = "asteroide.png",
    --onPress = holi
    --label="Options",
	--labelColor = { default = { 250, 255, 250}, over ={0,0,0  }},fontSize = "46",
	}
	planets6.x = centerX + (centerX/1.5)
	planets6.y = centerY*1.5
	--planets6.destination = "nivel1"
	--planets6:addEventListener("tap", btnTap)
	group:insert(planets6)
	
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
