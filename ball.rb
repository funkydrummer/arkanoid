class Ball < Engine::Sprite
  def initialize
    super 

    @image = Engine::Game.images["ball"]
    @x = @y = @vel_x = @vel_y = 0.0
    @angle = rand(90) + 135

    @z = ZOrder::Ball
    @collided = false
  end

  def update
    puts self.inspect
    self.accelerate
    self.move

    if ((@x > 10 && @x < 500) && (@y > 10 && @y < 490))
      @collided = false
    end

    Engine::Game.sprites[Block].each do |block|
      if collision?(block)
        block.destroy!
      end
    end

    unless @collided
      Engine::Game.sprites[Edge].each do |edge|
        if collision_test?(edge)
          rebound!(edge)
          @collided = true
        end
      end
    end

    Engine::Game.sprites[Board].each do |board|
      if collision_board?(board)
        @y = @y - 3

        direction = @vel_x > 0 ? :left : :right
        from_center = board.x - @x

        @angle = (180 - @angle) - 1.1 * from_center.abs.to_i
      end
    end
    
    Engine::Game.sprites[Block].each do |block|
      if collision_block?(block)
        block.destroy! # kills the alien
      end
    end
        
    Engine::Game.game_state.block_exists?
  end

  def rebound!(edge)
    if collision_with_bottom_line?(edge)
      raise "game over"
      #Game.game_state.start_game_over
    elsif collision_with_top_line?(edge)
      puts "colision top"
      licze = 180 - @angle
      @angle = licze
    elsif collision_with_left_line?(edge)
      puts "colision left"
      @angle = 360 - @angle 
    elsif collision_with_right_line?(edge)
      puts "colision right"
      licze = 360 - @angle
      @angle = licze
    end
  end

  def collision_with_top_line?(edge)
    return true if edge.top?
  end

  def collision_with_bottom_line?(edge)
    return true if edge.bottom?
  end
  
  def collision_with_left_line?(edge)
    return true if edge.left?
  end
  
  def collision_with_right_line?(edge)
    return true if edge.right?
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end
  
  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 550
    @y %= 600
    
    @vel_x *= 0.8
    @vel_y *= 0.8
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

end
