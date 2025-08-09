-- cl@nkers can define variables here
-- test
local text = ""

-------------------------------------------

function love.load()
    game = {}
    game.gameState = "splash"
    game.score = 0
    game.hearts = 3 -- Added hearts
    game.isGameOver = false

    -- window title lmfao this is a comment type shi
    love.window.setTitle("Catch em balls bruh")
    -- so apparently, the default window size is 800x600... idk if 600 is y or x because im autistic
    -- i want the circle guy to be in the lower section so like
    -- perfect it has to be 400..
    -- x should start in the middle so 400?
    -- nevermind love provides functions for that
    
    math.randomseed(os.time())

    -- STORE HEIGHT AND WIDTH (OF WINDOW) IN VARIABLES
    window_X = love.graphics.getWidth()
    window_Y = love.graphics.getHeight()

    -- MOVEMENT STUFF
    player = {}
    player.x = window_X / 2
    player.y = (window_Y * 2) / 3
    player.radius = 15
    player.speed = 10
    player.touching_border = false

    -- FALLING BALLS PROPERTIES
    ball = {}
    ball.radius = 15
    ball.max_x = window_X - ball.radius
    ball.min_x = 0 + ball.radius
    ball.max_speed = 10
    ball.min_speed = 5
    
    -- multiple ball prelogic
    balls = {}
    spawnTimer = 0
    spawnDelay = 1.5
    
    -- 😑😑😑
    local firstBall = {
        radius = ball.radius,
        x = math.random(ball.min_x, ball.max_x),
        y = -ball.radius, -- Start off-screen
        speed = math.random(ball.min_speed, ball.max_speed),
    }
    table.insert(balls, firstBall)
    
    -- Splash screen variables
    splashScreenTimer = 0
    splashScreenDuration = 3

    -- Ghost variables
    ghosts = {}
end

-- lmfao what is this wretched piece of shit
function love.update(dt)
    if game.gameState == "splash" then
        splashScreenTimer = splashScreenTimer + dt
        if splashScreenTimer >= splashScreenDuration then
            game.gameState = "running"
        end
        return 
    end

    if game.isGameOver then
        return
    end
    
    -- fix the timing
    spawnTimer = spawnTimer + dt 
    if spawnTimer >= spawnDelay then
        local newBall = {
            radius = ball.radius,
            x = math.random(ball.min_x, ball.max_x),
            y = -ball.radius,
            speed = math.random(ball.min_speed, ball.max_speed)
        }
        table.insert(balls, newBall)
        spawnTimer = 0
    end
    
    -- hopefully boundary collisions
    if player.x + player.radius > window_X then
        player.x = window_X - player.radius
    elseif player.x - player.radius < 0 then
        player.x = player.radius
    end

    -- note to self: DO *NOT* use ELSEIF statements because then the individual movements are not independent.. 

    -- Player movement
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
    
    -- how do i do ts :broken_heart:
    -- Update balls and check for collisions
    for i = #balls, 1, -1 do
        local currentBall = balls[i]
        
        -- Update ball position
        currentBall.y = currentBall.y + currentBall.speed
        
        -- Check for collision with the player (Catching)
        local distance = math.sqrt((player.x - currentBall.x)^2 + (player.y - currentBall.y)^2)
        local combined_radius = player.radius + currentBall.radius
        if distance < combined_radius then
            -- punni am i autistic
            -- wanna help me make ts on github or sum shi
            table.remove(balls, i)
            game.score = game.score + 1
            
            -- Spawn a ghost when a ball is caught
            local newGhost = {
                x = player.x,
                y = player.y,
                radius = player.radius,
                speed = 12,
                timer = 5,
                directionX = math.random() > 0.5 and 1 or -1
            }
            table.insert(ghosts, newGhost)
        end

        -- Check if ball is off screen (lose a heart)
        if currentBall.y > window_Y + currentBall.radius then
            table.remove(balls, i)
            game.hearts = game.hearts - 1
            if game.hearts <= 0 then
                game.isGameOver = true
            end
        end
    end
    
    -- Update and handle ghosts
    for i = #ghosts, 1, -1 do
        local currentGhost = ghosts[i]
        currentGhost.timer = currentGhost.timer - dt
        
        if currentGhost.timer <= 0 then
            table.remove(ghosts, i)
        else
            -- Move ghost
            currentGhost.x = currentGhost.x + currentGhost.speed * currentGhost.directionX
            
            -- Bounce off walls
            if currentGhost.x + currentGhost.radius > window_X or currentGhost.x - currentGhost.radius < 0 then
                currentGhost.directionX = currentGhost.directionX * -1
            end
            
            -- Check for collisions with balls
            for j = #balls, 1, -1 do
                local currentBall = balls[j]
                local distance = math.sqrt((currentGhost.x - currentBall.x)^2 + (currentGhost.y - currentBall.y)^2)
                local combined_radius = currentGhost.radius + currentBall.radius
                if distance < combined_radius then
                    table.remove(balls, j)
                    game.score = game.score + 1
                end
            end
        end
    end
end

function love.draw()
    if game.gameState == "splash" then
        love.graphics.printf("Catch em balls bruh\n\nStarting in " .. tostring(math.ceil(splashScreenDuration - splashScreenTimer)) .. " seconds...", 0, window_Y / 2, window_X, "center")
    elseif game.isGameOver then
        love.graphics.printf("GGs chat you died! Final score: " .. tostring(game.score), 0, window_Y / 2, window_X, "center")
    elseif game.gameState == "running" then
        love.graphics.circle("fill", player.x, player.y, player.radius)
        
        -- Draw hearts
        love.graphics.printf("hearts: " .. tostring(game.hearts), 10, 30, window_X, "left")

        -- boi wtf why is this not working
        -- its owrking
        -- the thang was im autistic
        -- ok i think we gotta draw balls in a loop
        for i, currentBall in ipairs(balls) do
            love.graphics.circle("line", currentBall.x, currentBall.y, currentBall.radius)
        end
        
        -- Draw ghosts
        love.graphics.setColor(1, 1, 1, 0.5) -- Semi-transparent white
        for _, currentGhost in ipairs(ghosts) do
            love.graphics.circle("fill", currentGhost.x, currentGhost.y, currentGhost.radius)
        end
        love.graphics.setColor(1, 1, 1, 1) -- Reset color
        
        love.graphics.printf("your score: " .. tostring(game.score), 10, 10, window_X, "left")
    end
end
