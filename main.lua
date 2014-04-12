centerX = display.contentWidth / 2
centerY = display.contentHeight / 2
withScrn = display.contentWidth
heightScrn = display.contentHeight
topScrn = display.screenOriginY
leftScrn = display.screenOriginX


backgroundfill = display.newRect(leftScrn, topScrn, withScrn, heightScrn)

local storyboard = require ("storyboard")
storyboard.purgeOnSceneChange = true

storyboard.gotoScene ( "menu", { effect = "fade"} )
