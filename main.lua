centerX = display.contentWidth / 2
centerY = display.contentHeight / 2
withScrn = display.contentWidth
heightScrn = display.contentHeight
topScrn = display.screenOriginY
leftScrn = display.screenOriginX

display.setStatusBar( display.HiddenStatusBar )

local sky = display.newImage( "fondo.jpg" )

local storyboard = require ("storyboard")
storyboard.purgeOnSceneChange = true

local function menu()

	sky:removeSelf() 
	sky = nil
	storyboard.gotoScene ( "menu", { effect = "fade"} )
end

timer.performWithDelay( 4000, menu )