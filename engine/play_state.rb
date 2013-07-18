module Engine
  class PlayState < GameState
    attr_reader :energy, :score
    
    MaxEnergy = 5
    
    # Constructor
    def initialize
      @game_over = false # flag
      @game_win = false
      
      # init sprite lists
      [EnergyBar, Explosion, Hud, Board, Ball, Block].each {|x| Game.sprite_collection.init_list(x)}
      
      @board = Board.new
      @img_background = Game.images["background"]
      @font_score = Game.fonts["score"]
      
      Hud.new
      EnergyBar.new
      
      Edge.new(250, 500, :bottom)
      Edge.new(250, 0, :top)
      Edge.new(0, 250, :left)
      Edge.new(550, 250, :right)

      arr_x = [25, 75, 125, 175, 225, 275, 325, 375, 425, 475, 525]
      arr_y = [20, 50]

      produce_blocks = arr_x.product(arr_y)

      produce_blocks.each do |arr|
        Block.new(arr[0], arr[1])
      end

      @ball = Ball.new
      @ball.warp(250, 150)
      
      @score = 0
      @energy = MaxEnergy       
    end
    
    # Draws game entities on the screen
    def draw
      # draw the background
      @img_background.draw(0, 0, 0)
      @img_game_over.draw_rot(Game::ScreenWidth/2, Game::ScreenHeight/3, ZOrder::Hud, 0) if game_over?
      
      # draw the score
      @font_score.draw_rel(@score.to_s, Game::ScreenWidth - 20, Game::ScreenHeight - 5, ZOrder::Hud + 1, 1.0, 1.0)
      
      # draw all sprites
      Game.sprite_collection.draw
    end
    
    # Updates game entities
    def update
      process_input

      # update all sprites
      Game.sprite_collection.update
    end
    
    # Gets called when the player releases a button
    def button_up(id)
      case id
      when Gosu::KbSpace then @captain.shoot if not game_over?# shoot a bullet
      when Gosu::KbEscape then Game.game_state = MenuState
      when Gosu::KbReturn then Game.game_state = MenuState if game_over?
      end
    end

    def button_down(id)
      if id == Gosu::KbEscape
        close
      end
    end

    # Check the status of some buttons and performs the appropiate actions
    def process_input
      @board.move(-Board::Speed) if Game.instance.button_down?(Gosu::KbLeft) and not game_over?
      @board.move(Board::Speed) if Game.instance.button_down?(Gosu::KbRight) and not game_over?
    end
    
    # Shows the game over message
    def start_game_over
      @img_game_over = Game.images["gameover"]
      @game_over = true
    end
    
    def start_game_win
      @game_over = true
      raise "YOU WIN !!!"
    end
    
    # Returns whether the game is over or not
    def game_over?
      @game_over
    end

    def game_win?
      @game_win
    end

    # Adds the given value to the player's score
    def increase_score!(x)
      @score += x
    end

    def block_exists?
      if Game.sprites[Block].count.eql? 0 
        Game.game_state.start_game_win
      end
    end
  end
end
