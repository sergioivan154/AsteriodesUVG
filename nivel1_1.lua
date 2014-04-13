-- Elemento necesario
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")

-- local forward references should go here --

local baseline = 300
local acc = {}
local centerX = display.contentWidth * 0.5
local centerY = display.contentHeight * 0.5

local function btnTap(event)
	storyboard.gotoScene (  event.target.destination, {effect = "fade"} )
	return true
end

local function accelerometero( event )
    nave.y = centerX - (centerX * event.xGravity)
    nave.x = centerY - (centerY * event.yGravity)
end 


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local background = display.newImageRect( "background.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	group:insert(background)

	health = display.newImageRect( "boto.png", 205, 15 )
	health.x, health.y = 210, 6
	group:insert(health)

	local introBtn = widget.newButton
	{
	width = 40,
    height = 40,
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
	local sheetN = { width=132, height=72,  numFrames=2 }
	local sheetNave = graphics.newImageSheet( "nave.png", sheetN )

	local sequenceDataNave =
	{
	    { name="viajando", start=1, count=2,time=300 ,loopCount=0 }
	}

	nave = display.newSprite( sheetNave, sequenceDataNave )

	nave.x = display.contentWidth / 3 --posicion inicial x 
	nave.y = 280 --posicion inicial y
	nave.h = 60
	nave.w = 80


	--group:insert( sheetWario )
	group:insert( nave)

	nave:play( )

	lPiedras={}
	lbalas={}
	
--hol
	
end

-- Imagenes paralax
	local herir = function ( event )
		--os.exit( )
		health.width = health.width - 10
	end
function rectay(x1,x2,y1,y2,posx)

	 imposy=(((y2-y1)/(x2-x1))*(posx-x1)) +y1
	
	return imposy
	
	end

function colision(obj1, obj2) --Esta función, verifica si hay colisión entre los objetos, dentro de la función se usan los parámetros que recibe.
	
	if obj1.x+obj1.w>obj2.x --Borde derecho obj1 > borde izquierdo obj2
	and obj1.x<obj2.x+obj2.w --Borde izquierdo obj1 < borde derecho obj2
	and obj1.y+obj1.h>obj2.y --Borde inferior obj1 > borde superior obj2
	and obj1.y<obj2.y+obj2.h then --Borde superior obj1 < borde inferior obj2
		return true --Retorna verdadero si hay colisión
	end
return false --Si el if no se cumple, viene a esta línea y retorna false, no hay colisión
end

function  scene:ponerPeligro()
	local group = self.view

	proPeligro = math.random ()
		if(proPeligro<.04) then
			 sheetW = { width=80, height=60,  numFrames=9 }
			 sheetWario = graphics.newImageSheet( "wario.png", sheetW )

			 sequenceDataWario =
			{
			    { name="walking", start=1, count=3,time=700 ,loopCount=0 },
			    { name="running", start=4, count=3,time=1000,loopCount=0 },
			    { name="jumping", start=8, count=4, time=800 ,loopCount=0 }
			}
			-- Esta función pone objetos a las listas de peligros para que hacer la colision con el personaje principal
			character = display.newSprite( sheetWario, sequenceDataWario )

			character.x = display.contentWidth --posicion inicial x 
			valorAleatorio=math.random(1,display.contentHeight)
			character.y = valorAleatorio --posicion inicial y
			character.h = 60
			character.w = 80

			character:play()

			group:insert(character)

			table.insert(lPiedras, character)
		end

end

--Evento Touch
local  ontTouch = function (event )
	
	if (event.phase=="began") then
--	bala[bala.lenght+1]=display.newImage( "ladrillo.png" )
   -- nave.y=nave.y-50
	scene:ponerBala(event)
 

	to=true
	return true
	end
end
function  scene:ponerBala(event)
	local group = self.view


	sheetB = { width=30, height=30,  numFrames=4 }
	sheetBala = graphics.newImageSheet( "bala-de-nave.png", sheetB )
	

       sequenceDataBala =
			{
			    { name="disparo", start=1, count=3,time=600 ,loopCount=0 },
			    
			}

	bala = display.newSprite( sheetBala, sequenceDataBala )
	
	 bala.x=nave.x+50
	 bala.y=nave.y-450
	 bala.w=30
	 bala.h=30
	 bala:play( )

	 group:insert(bala)

	arrayBalas={}

	arrayBalas[0]=bala
	arrayBalas[1]=nave.x -- X1
	arrayBalas[2]=nave.y -- Y1
	arrayBalas[3]=event.x -- X2
	arrayBalas[4]=event.y-- Y2

 table.insert(lbalas, arrayBalas )
 	

	-- body
end

local  i = 1
function dispara( )
for keyBala,bala in ipairs(lbalas) do 

						bala[0].x=(bala[0].x)+20
						bala[0].y= nave.y--(rectay(bala[1],bala[3],bala[2], bala[4],bala[0].x))
						

	end	
end
	-- body

function update(event)

	--move(event)
	dispara()

		scene:ponerPeligro()
		for keyPiedra,piedra in ipairs(lPiedras) do 
				piedra.x=piedra.x-1;
				

				if(colision(nave,piedra)) then
					table.remove(lPiedras,keyPiedra)
					piedra:removeSelf( )
					piedra=nil
					herir() 
				end
					
		end
		for keyBala,bala in ipairs(lbalas) do 
			for keyPiedra,piedra in ipairs(lPiedras) do 
				if(not(bala[0]==nil))then
		
					if(colision(bala[0],piedra))then
						table.remove(lPiedras,keyPiedra)
						piedra:removeSelf()
						piedra=nil
						table.remove(lbalas,keyBala)
						bala[0]:removeSelf()
						bala[0]=nil
					
					elseif(bala[0].x>display.contentWidth or bala[0].y>display.contentHeight or bala[0].y<0 or bala[0].x<0)then
						table.remove(lbalas,keyBala)
						bala[0]:removeSelf()
						bala[0]=nil
					end
				end
			end
		end
 			
							--Probabilidad de peligro 
		 --Esta función, verifica si hay colisión entre los objetos, dentro de la función se usan los parámetros que recibe.
		
		--if colision(player, character) then
			--character:setSequence( "running" )
			--character:play( ) 
	--end
end



-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

	Runtime:addEventListener( "touch", ontTouch )
	Runtime:addEventListener("enterFrame", update )
	Runtime:addEventListener("accelerometer", accelerometero)
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	-- INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks

	Runtime:removeEventListener("touch", ontTouch)
	Runtime:removeEventListener("enterFrame", update)
 	Runtime:removeEventListener("accelerometer", accelerometero)
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

