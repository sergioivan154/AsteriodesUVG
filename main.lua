centerX = display.contentWidth / 2
centerY = display.contentHeight / 2
withScrn = display.contentWidth
heightScrn = display.contentHeight
topScrn = display.screenOriginY
leftScrn = display.screenOriginX

display.setStatusBar( display.HiddenStatusBar )

<<<<<<< HEAD
backgroundfill = display.newRect(leftScrn, topScrn, withScrn, heightScrn)
=======
local sky = display.newImage( "fondo.jpg" )
>>>>>>> FETCH_HEAD

local storyboard = require ("storyboard")
storyboard.purgeOnSceneChange = true

<<<<<<< HEAD
storyboard.gotoScene ( "menu", { effect = "fade"} )
=======
local function menu()

	sky:removeSelf() 
	sky = nil
	storyboard.gotoScene ( "menu", { effect = "fade"} )
end

timer.performWithDelay( 4000, menu ) 
>>>>>>> FETCH_HEAD
