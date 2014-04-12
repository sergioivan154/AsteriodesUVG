

local widget = require( "widget" )

local sky = display.newImage("wario.png") --fondo

local baseline = 300 -- no. base

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




--local r2 = graphics.newImageSheet("Caminar.png", { width=61, height=100,  numFrames=8 })

-- play  frames every 500 ms
--local instance1 = display.newSprite( r1, { name="Stand", start=1, count=3, time=700 } )

--local instance2 = display.newSprite( r2, { name="Caminar", start=1, count=8, time=900 } )


-- 1st image sheet
--local sheetData1 = { width=64, height=64, numFrames=6, sheetContentWidth=384, sheetContentHeight=64 }
--local sheet1 = graphics.newImageSheet( "mySheet1.png", sheetData1 )

-- 2nd image sheet
--local sheetData2 = { width=64, height=64, numFrames=6, sheetContentWidth=384, sheetContentHeight=64 }
--local sheet2 = graphics.newImageSheet( "mySheet2.png", sheetData2 )


local sequenceData = {
                { name="seq1", sheet=sheet1, start=1, count=3, time=700, loopCount=0 },
                { name="seq2", sheet=sheet2, start=1, count=8, time=2000, loopCount=1 }
                }

local myAnimation = display.newSprite( sheet1, sequenceData )

local character = display.newSprite( sheetWario, sequenceDataWario )

myAnimation.x = display.contentWidth / 7 --posicion inicial x 
myAnimation.y = baseline - 70 --posicion inicial y
myAnimation.h = 100
myAnimation.w = 61



character.x = display.contentWidth / 3 --posicion inicial x 
character.y = baseline - 10 --posicion inicial y
character.h = 60
character.w = 80

myAnimation:play()
character:play()


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

local button3 = widget.newButton
{
	defaultFile = "boto.png",
	label = "<",
	emboss = true,
	onPress = button2Press,
	onRelease = button2Release,
}


button1.x = 160; button1.y = 160
button2.x = 120; button2.y = 120
button3.x = 190; button3.y = 80

function Colision(obj1, obj2) --Esta función, verifica si hay colisión entre los objetos, dentro de la función se usan los parámetros que recibe.
	if obj1.x+obj1.w>obj2.x --Borde derecho obj1 > borde izquierdo obj2
	and obj1.x<obj2.x+obj2.w --Borde izquierdo obj1 < borde derecho obj2
	and obj1.y+obj1.h>obj2.y --Borde inferior obj1 > borde superior obj2
	and obj1.y<obj2.y+obj2.h then --Borde superior obj1 < borde inferior obj2
		return true --Retorna verdadero si hay colisión
	end
return false --Si el if no se cumple, viene a esta línea y retorna false, no hay colisión
end

function update(event) --Esta función, verifica si hay colisión entre los objetos, dentro de la función se usan los parámetros que recibe.
		if Colision(myAnimation, character) then
		character:setSequence( "running" )
			character:play( )   
		else 

		character:setSequence( "jumping" )
		character:play( )   
	end
end

Runtime:addEventListener("enterFrame", update )
