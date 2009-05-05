module Engine
  
  class MenuState < GameState
    
    TextX = Game::ScreenWidth / 2
    TextY = (2 * Game::ScreenHeight) / 3
    TextGap = 50
    
    def initialize
      @img_background = Game::images["background"]
      @img_logo = Game::images["logo"]
      @font = Game::fonts["menu"]
      
      @options = ["New Game", "Credits", "Quit"]
      @selected = 0
    end
    
    def update
      
    end
    
    def draw
      @img_background.draw(0, 0, 0)
      @img_logo.draw_rot(Game::ScreenWidth / 2, 120, ZOrder::Hud, 0)
      
      @options.size.times do |i|
        color = option_selected?(i) ? 0xfff4cc00 : 0xffffffff
        @font.draw_rel(@options[i], TextX, TextY + i * TextGap, ZOrder::Hud, 0.5, 0.5, 1, 1, color)
      end
    end
    
    def button_down(id)
      case id
      when Gosu::KbEscape then Game.quit
      end
    end
    
    def button_up(id)
      case id
      when Gosu::KbDown then next_option!
      when Gosu::KbUp then prev_option!
      when Gosu::KbReturn then select_option
      when Gosu::KbSpace then Game.fade_off(1000)
      end
    end
    
    def option_selected?(i)
      @selected == i
    end
    
    def next_option!
      @selected = (@selected + 1) % @options.size
    end
    
    def prev_option!
      @selected = (@selected - 1) % @options.size
    end
    
    def select_option
      case @options[@selected]
      when "New Game" then Game.game_state = PlayState
      when "Credits" then Game.game_state = CreditsState
      when "Quit" then Game.quit
      end
    end 
  end
  
end