# frozen_string_literal: true

ROBOT_VIEW = { NORTH: '>', SOUTH: '<', EAST: 'v', WEST: '^' }.freeze
DIRECTIONS = %w[WEST NORTH EAST SOUTH].freeze
STEP_INFO = { NORTH: { x: 0, y: 1 }, SOUTH: { x: 0, y: -1 }, EAST: { x: 1, y: 0 }, WEST: { x: -1, y: 0 } }.freeze

module Robot
  # simulates robot behavior
  class Robot
    attr_accessor :direc, :position, :plased
    attr_reader :table, :direction_show

    def initialize
      @plased = false
    end

    def set_position(table, position_x, position_y, direction)
      @direc = direction.upcase
      @position = { x: position_x, y: position_y }
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

    def left
      @direc = DIRECTIONS[(DIRECTIONS.find_index(@direc) - 1)] if @plased

      print_position
    end

    def right
      @direc = DIRECTIONS[(DIRECTIONS.find_index(@direc) + 1) % 4] if @plased

      print_position
    end

    def move
      do_step(STEP_INFO[@direc.to_sym]) if @plased

      print_position
    end

    def report
      if @plased
        puts 'Pos: ' + @position[:x].to_s +
             ', ' + @position[:y].to_s + ', ' + @direc
      else
        puts 'Robot dont plased '
      end
    end

    private

    def do_step(coordinates)
      if valid_move?(coordinates[:x], coordinates[:y])
        @position[:x] += coordinates[:x]
        @position[:y] += coordinates[:y]
      end
    end

    def print_table
      puts '______________________________________________'
      (0...@table.length_table).each do |x|
        (0...@table.width_table).each do |y|
          print [@position_x, @position_y] == [x, y] ? ROBOT_VIEW[@direc.to_sym] : '-'
        end
        puts ''
      end
    end

    def valid_move?(x, y)
      valid_x_action?(x) && valid_y_action?(y)
    end

    def valid_x_action?(x)
      @position[:x] + x < @table.length_table && (@position[:x] + x).positive?
    end

    def valid_y_action?(y)
      @position[:y] + y < @table.width_table && (@position[:y] + y).positive?
    end

    def print_position
      print_table if @plased
    end
  end
end
