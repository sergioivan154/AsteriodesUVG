centerX = display.contentWidth / 2
centerY = display.contentHeight / 2
withScrn = display.contentWidth
heightScrn = display.contentHeight
topScrn = display.screenOriginY
leftScrn = display.screenOriginX

display.setStatusBar( display.HiddenStatusBar )

local background = display.newImageRect( "fondo.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0

local storyboard = require ("storyboard")
storyboard.purgeOnSceneChange = true

local function menu()

	background:removeSelf() 
	background = nil
	storyboard.gotoScene ( "menu", { effect = "fade"} )
end

timer.performWithDelay( 4000, menu )