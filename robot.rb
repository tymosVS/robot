# frozen_string_literal: true

module Robot
  # simulates robot behavior
  class Robot
    attr_accessor :direc, :position_x, :position_y, :plased
    attr_reader :table, :direction_show
    def initialize
      @plased = false
      @lay = { NORTH: '>', SOUTH: '<', EAST: 'v', WEST: '^' }
    end

    def set_position(table, position_x, position_y, direction)
      @direc = direction.upcase
      @position_x = position_x
      @position_y = position_y
      @plased = true
      @table = table
      print_position
    end

    def place(table, position_x, position_y, direction)
      list_directions = %w[WEST EAST NORTH SOUTH]
      if position_x < table.length_table &&
         position_y < table.width_table &&
         position_x >= 0 && position_y >= 0
        if list_directions.include?(direction)
          set_position(table, position_x, position_y, direction)
        end
      end
    end

    def left_turn
      case @direc
      when 'NORTH' then @direc = 'WEST'
      when 'SOUTH' then @direc = 'EAST'
      when 'EAST' then @direc = 'NORTH'
      when 'WEST' then @direc = 'SOUTH'
      end
      print_position
    end

    def left
      left_turn if @plased
    end

    def right_turn
      case @direc
      when 'NORTH' then @direc = 'EAST'
      when 'SOUTH' then @direc = 'WEST'
      when 'EAST' then @direc = 'SOUTH'
      when 'WEST'then @direc = 'NORTH'
      end
      print_position
    end

    def right
      right_turn if @plased
    end

    def north_motion
      @position_y += 1 if @position_y + 1 < @table.width_table
    end

    def south_motion
      @position_y -= 1 if @position_y.positive?
    end

    def east_motion
      @position_x += 1 if @position_x + 1 < @table.length_table
    end

    def west_motion
      @position_x -= 1 if @position_x.positive?
    end

    def step_forward
      case @direc
      when 'NORTH' then north_motion
      when 'SOUTH' then south_motion
      when 'EAST' then east_motion
      when 'WEST' then west_motion
      end
      print_position
    end

    def move
      step_forward if @plased
    end

    def report
      if @plased
        puts 'Pos: ' + @position_x.to_s +
             ', ' + @position_y.to_s + ', ' + @direc
      else
        puts 'Robot dont plased '
      end
    end

    def print_table
      puts '______________________________________________'
      (0...@table.length_table).each do |x|
        (0...@table.width_table).each do |y|
          print [@position_x, @position_y] == [x, y] ? @lay[@direc.to_sym] : '-'
        end
        puts ''
      end
    end

    def print_position
      print_table if @plased
    end
  end
end
