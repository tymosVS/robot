# frozen_string_literal: true

module Robot
  # simulates robot behavior
  class Robot
    attr_accessor :direction, :position_x, :position_y, :plased
    attr_reader :table
    def initialize
      @plased = false
    end

    def PLACE(table, position_x, position_y, direction)
      if position_x < table.length_table &&
         position_y < table.width_table &&
         position_x >= 0 &&
         position_y >= 0
        if direction == 'WEST' ||
           direction == 'EAST' ||
           direction == 'NORTH' ||
           direction == 'SOUTH'
          @direction = direction.upcase
          @position_x = position_x
          @position_y = position_y
          @plased = true
          @table = table
          print_position
        end
      end
    end

    def LEFT
      if @plased
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
    end

    def RIGHT
      if @plased
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
    end

    def MOVE
      if @plased
        case @direction
        when 'NORTH'
            @position_y += 1 if @position_y + 1< @table.width_table
        when 'SOUTH'
          @position_y -= 1 if @position_y  > 0
        when 'EAST'
            @position_x += 1 if @position_x +1 < @table.length_table
        when 'WEST'
            @position_x -= 1 if @position_x  > 0
        end
        print_position
      end
    end

    def REPORT
      if @plased
        puts 'Output:  ' + @position_x.to_s + ', ' + @position_y.to_s + ', ' + @direction

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
