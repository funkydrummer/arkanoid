class Edge < Engine::Sprite
  MaxSpeedX = 4
  MaxSpeedY = 8
  MinSpeedY = 3
  AnimTime = 500
  BoomOffset = 10
  
  # Constructor
  def initialize(x, y, type)
    super(x, y, type)

    @image = Engine::Game.images["alien"]
    @x = x  #130 #rand(Engine::Game::ScreenWidth)
    @y = y  #550    #-@image[0].height / 2
    @z = ZOrder::Block
    @radius = 20
    
    @place = type 
    # assign random speeds to the alien
  end
  
  def bottom? 
    @place == :bottom
  end

  def top?
    @place == :top
  end
  
  def left?
    @place == :left
  end

  def right? 
    @place == :right
  end

  # Updates the alien
  def update

  end

  def destroy!

  end

end
