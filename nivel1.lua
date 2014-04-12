-- Elemento necesario
local storyboard = require("storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
-- Elemento necesario


-- Variables para paralax
local TOP_REF = 0
local BOTTOM_REF = 1
local LEFT_REF = 0
local RIGHT_REF = 1
local CENTER_REF = 0.5

local _W = display.contentWidth
local _H = display.contentHeight
local baseline = 300 -- no. base


-- Imagenes fijas
local grass = display.newImage( "grass.png" )
grass.anchorX = LEFT_REF
grass.x = 0
grass.y = baseline - 20
local grass2 = display.newImage( "grass.png" )
grass2.anchorX = LEFT_REF
grass2.x = 480
grass2.y = baseline - 20

-- Imagenes paralax
local tree = {}
tree[1] = display.newImage( "Palm-arecaceae.png" )
tree[1].xScale = 0.7; tree[1].yScale = 0.7
tree[1].anchorY = BOTTOM_REF
tree[1].x = 20; tree[1].y = baseline
tree[1].dx = 0.1
tree[2] = display.newImage( "Greenhouse-Palm-jubaea01.png" )
tree[2].xScale = 0.6; tree[2].yScale = 0.6
tree[2].anchorY = BOTTOM_REF
tree[2].x = 120; tree[2].y = baseline
tree[2].dx = 0.2
tree[3] = display.newImage( "Greenhouse-Palm-cycas01.png" )
tree[3].xScale = 0.8; tree[3].yScale = 0.8
tree[3].anchorY = BOTTOM_REF
tree[3].x = 200; tree[3].y = baseline
tree[3].dx = 0.3
tree[4] = display.newImage( "Ginger.png" )
tree[4].xScale = 0.7; tree[4].yScale = 0.7
tree[4].anchorY = BOTTOM_REF
tree[4].x = baseline; tree[4].y = baseline
tree[4].dx = 0.4
tree[5] = display.newImage( "Greenhouse-Palm-acai01.png" )
tree[5].xScale = 0.8; tree[5].yScale = 0.8
tree[5].anchorY = BOTTOM_REF
tree[5].x = 300; tree[5].y = baseline
tree[5].dx = 0.5
tree[6] = display.newImage( "Dracena.png" )
tree[6].xScale = 0.4; tree[5].yScale = 0.4
tree[6].anchorY = BOTTOM_REF
tree[6].x = 320; tree[6].y = baseline
tree[6].dx = 0.6
tree[7] = display.newImage( "Banana.png" )
tree[7].xScale = 0.4; tree[7].yScale = 0.4
tree[7].anchorY = BOTTOM_REF
tree[7].x = 380; tree[7].y = baseline
tree[7].dx = 0.7
tree[8] = display.newImage( "Bamboo-rgba.png" )
tree[8].xScale = 0.8; tree[8].yScale = 0.8
tree[8].anchorY = BOTTOM_REF
tree[8].x = 420; tree[8].y = baseline
tree[8].dx = 0.8

-- Efecto Paralax
local tPrevious = system.getTimer()
local function move(event)
	local tDelta = event.time - tPrevious
	tPrevious = event.time

	local xOffset = ( 0.2 * tDelta )

	grass.x = grass.x - xOffset
	grass2.x = grass2.x - xOffset
	
	if (grass.x + grass.contentWidth) < 0 then
		grass:translate( 480 * 2, 0)
	end
	if (grass2.x + grass2.contentWidth) < 0 then
		grass2:translate( 480 * 2, 0)
	end
	
	local i
	for i = 1, #tree, 1 do
		tree[i].x = tree[i].x - tree[i].dx * tDelta * 0.2
		if (tree[i].x + tree[i].contentWidth) < 0 then
			tree[i]:translate( 480 + tree[i].contentWidth * 2, 0 )
		end
	end
end


-- Lista Piedras
local iPiedras=0
local lPiedras={}

--una imagen con cortes w,h y el numero de frames  para un sprite ocupo 2 imagenes
local sheetData1 = { width=61, height=100,  numFrames=3 }
local sheet1 = graphics.newImageSheet( "Espera.png", sheetData1 )

local sheetData2 = { width=61, height=100,  numFrames=8 }
local sheet2 = graphics.newImageSheet( "Caminar.png", sheetData2 )

--sprite con en una sola imagen
local sheetW = { width=80, height=60,  numFrames=9 }
local sheetWario = graphics.newImageSheet( "wario.png", sheetW )

local sequenceDataWario =
{
    { name="walking", start=1, count=3,time=700 ,loopCount=0 },
    { name="running", start=4, count=3,time=1000,loopCount=0 },
    { name="jumping", start=8, count=4, time=800 ,loopCount=0 }
}



local sequenceData = {
                { name="seq1", sheet=sheet1, start=1, count=3, time=200, loopCount=0 },
                { name="seq2", sheet=sheet2, start=1, count=8, time=2000, loopCount=1 }
                }

local myAnimation = display.newSprite( sheet2, sequenceData )

local character = display.newSprite( sheetWario, sequenceDataWario )

myAnimation.x = display.contentWidth / 7 --posicion inicial x 
myAnimation.y = baseline - 70 --posicion inicial y
myAnimation.h = 100
myAnimation.w = 61





myAnimation:play()



local function swapSheet()
myAnimation:setSequence( "seq2" )
    myAnimation:play()   

    character:setSequence( "jumping" )
		character:play( )    
end
--timer.performWithDelay( 2000, swapSheet )



local button1Press = function ( event )
	myAnimation.x = myAnimation.x + 3;
	myAnimation:setSequence( "seq1" )
        myAnimation:play()
       

end

local button2Press = function ( event )
	myAnimation.x = myAnimation.x - 3;
end




local button1 = widget.newButton
{
	defaultFile = "boto.png",
	label = ">",
	emboss = false,
	onPress = button1Press,
	onRelease = button1Release
	
}

local button2 = widget.newButton
{
	defaultFile = "boto.png",
	label = "<",
	emboss = true,
	onPress = button2Press,
	onRelease = button2Release,
}



button1.x = 160; button1.y = 160
button2.x = 120; button2.y = 120

function colision(obj1, obj2) --Esta función, verifica si hay colisión entre los objetos, dentro de la función se usan los parámetros que recibe.
	if obj1.x+obj1.w>obj2.x --Borde derecho obj1 > borde izquierdo obj2
	and obj1.x<obj2.x+obj2.w --Borde izquierdo obj1 < borde derecho obj2
	and obj1.y+obj1.h>obj2.y --Borde inferior obj1 > borde superior obj2
	and obj1.y<obj2.y+obj2.h then --Borde superior obj1 < borde inferior obj2
		return true --Retorna verdadero si hay colisión
	end
return false --Si el if no se cumple, viene a esta línea y retorna false, no hay colisión
end



-- Logica del juego

function update(event)

		--Probabilidad de peligro 

		proPeligro = math.random ()
		if(proPeligro<.03) then

			ponerPeligro()
		end
		for key,value in ipairs(lPiedras) do 
				value.x=value.x-1;
				if(colision(myAnimation,value)) then
					table.remove(lPiedras,key)
				end
		end
		
		 --Esta función, verifica si hay colisión entre los objetos, dentro de la función se usan los parámetros que recibe.
		
		--if colision(myAnimation, character) then
			--character:setSequence( "running" )
			--character:play( ) 
	--end
end

function  ponerPeligro()
	-- Esta función pone objetos a las listas de peligros para que hacer la colision con el personaje principal
	
	character.x = math.random(1,display.contentWidth) --posicion inicial x 
	character.y = baseline - 70 --posicion inicial y
	character.h = 60
	character.w = 80
	character:play()
	table.insert(lPiedras, character)
end

Runtime:addEventListener("enterFrame", update )
Runtime:addEventListener("enterFrame", move )
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
