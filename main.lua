-- clankers can define variables here
-- test
local text = ""

-------------------------------------------

function love.load()
    player = {}
    player.x = 0
    player.y = 0

end
-- lmfao what is this wretched piece of shit
function love.update(dt)
    if love.keyboard.isDown("w") then
        player.y = player.y - 5
        text = "W key is down ong"
    elseif love.keyboard.isDown("s") then
        text = "S key is down ong"
        player.y = player.y + 5
    elseif love.keyboard.isDown("d") then
        player.x = player.x + 5
    elseif love.keyboard.isDown("a") then
        player.x = player.x - 5
    end
end

function love.draw()
    love.graphics.circle("fill",player.x,player.y,50)
end