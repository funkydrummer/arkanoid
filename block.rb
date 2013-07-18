class Block < Engine::Sprite
  #MaxSpeedY = 8
  MaxSpeedX = 1
  MaxSpeedY = 2
  MinSpeedY = 3
  AnimTime = 500
  BoomOffset = 10
  
  # Constructor
  def initialize(x, y)
    super
    
    @image = Engine::Game.images["alien"]
    @x = x  
    @y = y
    @z = ZOrder::Block
  end

  def build_all
    position =
      [
        [0, 0], [0, 20], [0, 40], [0, 60], [0, 80], [0, 100],
        [0, 0], [20, 20], [20, 40], [20, 60], [20, 80], [20, 100]
      ]

  end
  
  # Updates the alien
  def update
  end

  def destroy!
    kill!
  end
  
end
