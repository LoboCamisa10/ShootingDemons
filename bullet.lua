local Bullet = Class:extend()

function Bullet:new(x, y, imageBullet, sizeBullet, bulletRadians,y_dir_enum)
    self.image = love.graphics.newImage(imageBullet)
    self.x = x
    self.y = y
    self.y_direction = self.direction_enum(y_dir_enum)
    if self.y_direction == nil then
        error("Invalid y_dir_enum: " .. tostring(y_dir_enum))
    end
    self.sizeBullet = sizeBullet
    self.bulletRadians = bulletRadians
    self.speed = 600

    --Duas formas diferentes mas iguais de chamar a função de getHeight()
    self.width = self.image:getWidth()
    self.height = self.image.getHeight(self.image)
end

function Bullet.direction_enum(direction)
    local  redirect = {
        ['up'] = -1,
        ['down'] = 1
    }
    return redirect[string.lower(direction)]
end

function Bullet:update(dt)
    self.y = self.y + (self.speed * self.y_direction) * dt

    --Se a bala estiver fora da tela, reinicia o game.
    if self.y > love.graphics.getHeight() then
        Cont = 0
        love.load()
    end
end

function Bullet:draw()
    --Cria uma borda colorida ao redor da imagem do personagem para enxergar o "HITBOX"
    -- local old_c = {}
    -- old_c.r, old_c.g, old_c.b, old_c.a = love.graphics.getColor()

    -- love.graphics.setColor(0, 255, 0)
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- love.graphics.setColor(old_c.r, old_c.g, old_c.b, old_c.a)

    love.graphics.draw(self.image, self.x, self.y , self.bulletRadians, self.sizeBullet)
end

--Funcão com um parâmetro que recebe a variável "enemey" de main.lua, onde essa variável possui a classe inteira "Enemy" dentro dela para checkar a colisão da bala no inimigo
function Bullet:checkCollision(obj)
    local self_left = self.x
    local self_right = self.x + self.width
    local self_top = self.y
    local self_bottom = self.y + self.height

    local obj_left = obj.x
    local obj_right = obj.x + obj.width
    local obj_top = obj.y
    local obj_bottom = obj.y + obj.height

    if  self_right > obj_left
    and self_left < obj_right
    and self_bottom > obj_top
    and self_top < obj_bottom then

        self.dead = true
        --Increase enemy speed
        if obj.speed > 0 then
            obj.speed = obj.speed + 50
        else
            obj.speed = obj.speed - 50
        end
    end
end

return Bullet