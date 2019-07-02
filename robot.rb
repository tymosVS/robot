# frozen_string_literal: true

module Robot
  # simulates robot behavior
  class Robot
    attr_accessor :direction, :position_x, :position_y, :plased
    attr_reader :table, :direction_show
    def initialize
      @plased = false
      @direction_show = { NORTH: '>', SOUTH: '<', EAST: 'v', WEST: '^' }
    end

    def set_position
      @direction = direction.upcase
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
        set_position if list_directions.include?(direction)
      end
    end

    def left_turn
      case @direction
      when 'NORTH' then @direction = 'WEST'
      when 'SOUTH' then @direction = 'EAST'
      when 'EAST' then @direction = 'NORTH'
      when 'WEST' then @direction = 'SOUTH'
      end
      print_position
    end

    def left
      left_turn if @plased
    end

    def right_turn
      case @direction
      when 'NORTH' then @direction = 'EAST'
      when 'SOUTH' then @direction = 'WEST'
      when 'EAST' then @direction = 'SOUTH'
      when 'WEST'then @direction = 'NORTH'
      end
      print_position
    end

    def right
      right_turn if @plased
    end

    def step_forward
      case @direction
      when 'NORTH' then @position_y += 1 if @position_y + 1 < @table.width_table
      when 'SOUTH' then @position_y -= 1 if @position_y.positive?
      when 'EAST' then @position_x += 1 if @position_x + 1 < @table.length_table
      when 'WEST' then @position_x -= 1 if @position_x.positive?
      end
      print_position
    end

    def move
      step_forward if @plased
    end

    def report
      if @plased
        puts 'Pos: ' + @position_x.to_s +
             ', ' + @position_y.to_s + ', ' + @direction

      else
        puts 'Robot dont plased '
      end
    end

    def print_position
      if @plased
        puts '______________________________________________'
        (0...@table.length_table).each do |pos_x|
          (0...@table.width_table).each do |pos_y|
            if pos_x == @position_x && pos_y == @position_y
              print @direction_show[@direction.to_sym]
            else
              print '-'
            end
          end
          puts ''
        end
      end
    end
  end
end
