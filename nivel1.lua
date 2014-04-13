-- Elemento necesario
local storyboard = require("storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
-- Elemento de touch
local x,y= 0,0

local currentLevel = 1 


-- Variables para paralax
local TOP_REF = 0
local BOTTOM_REF = 1
local LEFT_REF = 0
local RIGHT_REF = 1
local CENTER_REF = 0.5

local _W = display.contentWidth
local _H = display.contentHeight
local baseline = 300 -- no. base
physics=require "physics"
physics.start( )
physics.getGravity(1,1)

-- Imagenes fijas 
function scene:createScene( event )
	local group = self.view


estrellas = display.newImageRect( "bg-estrellas.png",display.contentWidth, display.contentHeight  )
	--estrellas.xScale = 4.2; estrellas.yScale = 4.2
	estrellas.anchorX = LEFT_REF
	estrellas.x = 0
	estrellas.y = 130
	group:insert(estrellas)

	estrellas2 = display.newImageRect( "bg-estrellas.png",display.contentWidth, display.contentHeight  )
	--estrellas2.xScale = 4.2; estrellas2.yScale = 4.2
	estrellas2.anchorX = LEFT_REF
	estrellas2.x = 480
	estrellas2.y = 130
	group:insert(estrellas2)


	piso = display.newImageRect( "bg-terreno.png",display.contentWidth, display.contentHeight  )
	--piso.xScale = 4.2; piso.yScale = 4.2
	piso.anchorX = LEFT_REF
	piso.x = 0
	piso.y = 130
	group:insert(piso)

	piso2 = display.newImageRect( "bg-terreno.png",display.contentWidth, display.contentHeight  )
	--piso2.xScale = 4.2; piso2.yScale = 4.2
	piso2.anchorX = LEFT_REF
	piso2.x = 480
	piso2.y = 130
	group:insert(piso2)




	grass = display.newImage( "bg-terreno-base.png" )
	--grass.xScale = 6.2; grass.yScale = 6.2
	grass.anchorX = LEFT_REF
	grass.w=480
	grass.x = 0
	grass.y = baseline-grass.contentHeight*2
	physics.addBody( grass,"static",{friction=.03} )
	group:insert(grass)

	grass2 = display.newImage( "bg-terreno-base.png" )
	--grass2.xScale = 2.2; grass2.yScale = 2.2
	grass2.anchorX = LEFT_REF
	grass2.x = 480
	grass2.y = baseline-grass2.contentHeight*2
	physics.addBody( grass2,"static",{friction=.03} )
	group:insert(grass2)

	

	 
	health = display.newImageRect( "boto.png", 205, 15 )
	health.x, health.y = 210, 6
	group:insert(health)

	sheetData1 = { width=61, height=100,  numFrames=3 }
	sheet1 = graphics.newImageSheet( "Espera.png", sheetData1 )
	

	sheetP = { width=111, height=144,  numFrames=10 }
	sheetPlayer = graphics.newImageSheet( "robot-walk.png", sheetP )
	

       sequenceDataPlayer =
			{
			    { name="walking", start=1, count=7,time=600 ,loopCount=0 },
			    
			}

	player = display.newSprite( sheetPlayer, sequenceDataPlayer )
	player.x = display.contentWidth / 7 --posicion inicial x 
	player.y = baseline - 70 --posicion inicial y
	player.h = 100
	player.w = 61
	player:play()
	physics.addBody( player, {bounce=.03} )
	group:insert(player)

	lPiedras={}
	lbalas={}
	

button1 = widget.newButton
	{
		defaultFile = "boto.png",
		label = ">",
		onPress = button1Press,
		--onRelease = button1Release,
		
	}
	button1.x = 160; button1.y = 160
group:insert(button1)


button2 = widget.newButton
	{
		defaultFile = "boto.png",
		label = "<",
		onPress = button2Press,
		--onRelease = button2Release,
	}
	button2.x = 120; button2.y = 120
	group:insert(button2)

	 
end

-- Efecto Paralax
local tPrevious = system.getTimer()
local function move(event)
	local tDelta = event.time - tPrevious
	tPrevious = event.time

	local xOffset = ( 0.2 * tDelta )

	grass.x = grass.x - xOffset
	grass2.x = grass2.x - xOffset

	piso.x = piso.x - xOffset
	piso2.x = piso2.x - xOffset

	estrellas.x = estrellas.x - (xOffset/5)
	estrellas2.x = estrellas2.x - (xOffset/5)
	
	if (grass.x + grass.contentWidth) < 0 then
		grass:translate( 480 * 2, 0)
	end
	if (grass2.x + grass2.contentWidth) < 0 then
		grass2:translate( 480 * 2, 0)
	end

	if (piso.x + piso.contentWidth) < 0 then
		piso:translate( 480 * 2, 0)
	end
	if (piso2.x + piso2.contentWidth) < 0 then
		piso2:translate( 480 * 2, 0)
	end

	if (estrellas.x + estrellas.contentWidth) < 0 then
		estrellas:translate( 480 * 2, 0)
	end
	if (estrellas2.x + estrellas2.contentWidth) < 0 then
		estrellas2:translate( 480 * 2, 0)
	end
	
	--local i
	--for i = 1, #tree, 1 do
	--	tree[i].x = tree[i].x - tree[i].dx * tDelta * 0.2
	--	if (tree[i].x + tree[i].contentWidth) < 0 then
	--		tree[i]:translate( 480 + tree[i].contentWidth * 2, 0 )
	--	end
	--end
end
-- botones
 
	
button1Press = function ( event )
	-- body
	player.x = player.x +10
end


button2Press = function ( event )
	--holi()
	player.x = player.x -10
	transition.to( trophy, {time=600, alpha=0} )
	storyboard.showOverlay( "gameover" ,{effect = "fade"  ,  params ={curLevel = currentLevel}, isModal = true} )
	
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




local holi = function (event)
  						transition.to( trophy, {time=600, alpha=0} )
  						storyboard.showOverlay( "gameover" ,{effect = "fade"  ,  params ={curLevel = currentLevel}, isModal = true} )
	  				
  				end

 finish = function (event)
  						transition.to( trophy, {time=600, alpha=0} )

  						storyboard.gotoScene( "nivel1_1", {effect = "zoomOutInFadeRotate"} )
  					
  				end

--timer.performWithDelay( 5000, finish )

--timer.performWithDelay( 3000, holi )




local function swapSheet()
player:setSequence( "seq2" )
    player:play()   

    character:setSequence( "jumping" )
		character:play( )    
end
--timer.performWithDelay( 2000, swapSheet )








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
		if(proPeligro<.01) then
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
			character.y = baseline - 60 --posicion inicial y
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
player.y=player.y-50
	scene:ponerBala(event)
 

	to=true
	return true
	end
end
function  scene:ponerBala(event)
	local group = self.view


	sheetB = { width=30, height=30,  numFrames=4 }
	sheetBala = graphics.newImageSheet( "bala.png", sheetB )
	

       sequenceDataBala =
			{
			    { name="disparo", start=1, count=3,time=600 ,loopCount=0 },
			    
			}

	bala = display.newSprite( sheetBala, sequenceDataBala )
	
	 bala.x=player.x+40
	 bala.y=player.y-450
	 bala.w=30
	 bala.h=30
	 bala:play( )

	 group:insert(bala)

	arrayBalas={}

	arrayBalas[0]=bala
	arrayBalas[1]=player.x -- X1
	arrayBalas[2]=player.y -- Y1
	arrayBalas[3]=event.x -- X2
	arrayBalas[4]=event.y-- Y2

 table.insert(lbalas, arrayBalas )
 	

	-- body
end
-- Logica del juego
local  i = 1
function dispara( )
for keyBala,bala in ipairs(lbalas) do 

						bala[0].x=(bala[0].x)+20
						bala[0].y=(rectay(bala[1],bala[3],bala[2], bala[4],bala[0].x))
						

	end	
end
	-- body

function update(event)

	move(event)
	dispara()

		scene:ponerPeligro()
		for keyPiedra,piedra in ipairs(lPiedras) do 
				piedra.x=piedra.x-1;
				

				if(colision(player,piedra)) then
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
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	-- INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks
		Runtime:removeEventListener("touch", ontTouch)
		Runtime:removeEventListener("enterFrame", update)
		--Runtime:removeEventListener("enterFrame", move)
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
