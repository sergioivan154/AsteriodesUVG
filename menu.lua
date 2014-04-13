local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")

-- local forward references should go here --


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
	local logo = widget.newButton
	{
	width = 150,
    height = 150,
    defaultFile = "logo.png",
	}
	logo.x = centerX 
	logo.y = centerY - (centerY/2)
	--optionsBtn:addEventListener("tap", btnTap)
	group:insert(logo)

	local lunasBtn = widget.newButton
	{
	width = 110,
    height = 110,
    defaultFile = "ladrillo.png",
    overFile = "ladrillo.png",
    --onPress = holi
    --label="Options",
	--labelColor = { default = { 250, 255, 250}, over ={0,0,0  }},fontSize = "46",
	}
	lunasBtn.x = centerX + (centerX/1.5)
	lunasBtn.y = centerY*1.5
	lunasBtn.destination = "options"
	--optionsBtn:addEventListener("tap", btnTap)
	group:insert(lunasBtn)


	local planetasBtn = widget.newButton
	{
	width = 110,
    height = 110,
    defaultFile = "asteroide.png",
    overFile = "asteroide.png",
    --label="Options",
	--labelColor = { default = { 250, 255, 250}, over ={0,0,0  }},fontSize = "46",
	}
	planetasBtn.x = centerX
	planetasBtn.y = centerY*1.5
	planetasBtn.destination = "planetsMenu"
	planetasBtn:addEventListener("tap", btnTap)
	group:insert(planetasBtn) 

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
	introBtn.y = centerY*1.5
	introBtn.destination = "options"
	--optionsBtn:addEventListener("tap", btnTap)
	group:insert(introBtn)

	
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

