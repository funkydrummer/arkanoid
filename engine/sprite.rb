module Engine
  
  # Sprite objects are the different moving elements of the game. For example, a 
  # space ship, an enemy, a bullet, etc.
  #
  # Custom sprite classes should inherit from this one.
  class Sprite

    attr_reader :x, :y, :z, :image, :blend_mode, :alpha, :angle, :radius, :size

    # Constructor. Note that classes which inherits from this one should
    # call THIS constructor (with super.init) too!
    def initialize(x=0, y=0, type=nil)
      @x = 0
      @y = 0
      @z = 0
      @image = nil
      @blending = :default
      @alpha = 1.0
      @angle = 0
      @index = 0
      @radius = 0
      @size = 1.0
      
      @die = false
            
      # Adds this new sprite to its sprite list
      Game.sprite_collection.add(self)   
    end

    # Updates the sprite logic
    def update
    end
    
    # Draws the sprite in the screen. If the sprite image is a strip, draws the
    # animation.
    def draw
      if @image.class == Array
        img = @image[@index]
      else
        img = @image
      end
      img.draw_rot(@x, @y, @z, @angle, 0.5, 0.5, @size, @size, alpha_to_color(@alpha), @blending)
    end
    
    # Removes the sprite from its sprite list
    def kill!
      @die = true
    end
    
    # Checks whether this sprite should be deleted this frame or not
    def die?
      @die
    end
    
    # Check collision against another sprite (circle-shaped bounding boxes)
    def collision?(other)
      Gosu::distance(@x, @y, other.x, other.y) < @radius * @size + other.radius * other.size
    end
    
    def collision_block?(other)
      Gosu::distance(@x, @y, other.x, other.y) < 25
    end

    def collision_board?(other)
      #Gosu::distance(@x, @y, other.x, other.y) < @radius * @size + other.radius * other.size
      
      @x1 = other.x - other.image.width / 2 
      @x2 = other.x + other.image.width / 2
      @y2 = other.y - other.image.height / 2 - self.image.height / 2 

      collision = (@x > @x1 && @x < @x2) && @y > 485
      collision
=begin

      x1, y2                  x2,y2
      ========================
                x,y
      ========================

=end
    end

    def collision_test?(other)
      if other.bottom? || other.top?
        Gosu::distance(@x, @y, @x, other.y) < 5
      else
        Gosu::distance(@x, @y, other.x, @y) < 5
      end
    end
    
    protected
    
    # Creates a new full white Gosu::Color with the given alpha value
    def alpha_to_color(alpha)
      Gosu::Color.new((alpha * 0xff).to_i, 255, 255, 255)
    end

  end
end
