# frozen_string_literal: true

module Robot
  # simulates robot behavior
  class Robot
    attr_accessor :direction, :position_x, :position_y, :plased
    attr_reader :table
    def initialize
      @plased = false
    end

    def place(table, position_x, position_y, direction)
      list_directions = %w[WEST EAST NORTH SOUTH]
      if position_x < table.length_table &&
         position_y < table.width_table &&
         position_x >= 0 &&
         position_y >= 0
        if list_directions.include?(direction)
          @direction = direction.upcase
          @position_x = position_x
          @position_y = position_y
          @plased = true
          @table = table
          print_position
        end
      end
    end

    def left_turn
      case @direction
      when 'NORTH'
        @direction = 'WEST'
      when 'SOUTH'
        @direction = 'EAST'
      when 'EAST'
        @direction = 'NORTH'
      when 'WEST'
        @direction = 'SOUTH'
      end
      self.print_position
    end

    def left
      left_turn if @plased
    end

    def right_turn
      case @direction
      when 'NORTH'
        @direction = 'EAST'
      when 'SOUTH'
        @direction = 'WEST'
      when 'EAST'
        @direction = 'SOUTH'
      when 'WEST'
        @direction = 'NORTH'
      end
      print_position
    end

    def right
      right_turn if @plased
    end

    def step_forward
      case @direction
      when 'NORTH' then @position_y += 1 if @position_y + 1< @table.width_table
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
              case @direction
              when 'NORTH' then print '>'
              when 'SOUTH' then print '<'
              when 'EAST'  then print 'v'
              when 'WEST'  then print '^'
              end
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
