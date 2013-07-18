# This is the player's ship. It can shoot bullets and should avoid
# enemy aliens to survive.
class Board < Engine::Sprite
  Speed = 6
  BoomOffset = 10
  
  attr_reader :energy
  
  # Constructor
  def initialize
    super
    
    @x = Engine::Game::ScreenWidth / 2
    @y = Engine::Game::ScreenHeight - 100
    @z = ZOrder::Board
    @image = Engine::Game.images["board_long"]
    
    @radius = 30
  end

  # Moves the ship horizontally
  def move(incx)
    @x += incx
    # make sure it stays inside the screen
    @x = [@x, @image.width / 2].max
    @x = [@x, Engine::Game::ScreenWidth - @image.width / 2].min
  end
  
  # Kills the ship with an explosion
  def destroy!
    (rand(3) + 5).times { Explosion.new(@x + rand(BoomOffset * 2) - BoomOffset, @y + rand(BoomOffset * 2) - BoomOffset) }
    kill!
  end
end
