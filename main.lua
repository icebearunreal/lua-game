-- clankers can define variables here
-- test
local text = ""

-------------------------------------------

function love.load()
    love.window.setTitle("Game")
    -- so apparently, the default window size is 800x600... idk if 600 is y or x because im autistic
    -- i want the circle guy to be in the lower section so like
    -- perfect it has to be 400..
    -- x should start in the middle so 400?
    -- nevermind love provides functions for that

    -- STORE HEIGHT AND WIDTH (OF WINDOW) IN VARIABLES
    window_X = love.graphics.getWidth()
    print(window_X)
    window_Y = love.graphics.getHeight()
    print(window_Y)

    -- MOVEMENT STUFF
    player = {}
    player.x = window_X/2
    player.y = (window_Y*2)/3 -- epik math
    player.radius = 15 
    player.speed = 5
    player.touching_border = false
end
-- lmfao what is this wretched piece of shit
function love.update(dt)
    -- note to self: DO *NOT* use ELSEIF statements because then the individual movements are not independent.. 

    -- set speed to < 5
    -- idk man what should the speed be?!

    

    -- hopefully boundary collisions

    
    -- how it works: 
    -- idk
    if player.x + player.radius > 800 then
        player.touching_border = true
        player.x = 800 - player.radius
    elseif player.x - player.radius < 0 then
        player.touchingborder = true
        player.x = player.radius
    end

    -- movement
    -- i fucking removed up and down movement BECAUSE i wanna make the player as autistic as me (he can only go sideways)
    if love.keyboard.isDown("lshift") then
        player.speed = 15
    else
        player.speed = 5
    end
    
    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed
    end
    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed
    end
    
end

function love.draw()
    love.graphics.circle("fill",player.x,player.y,player.radius)
end