# frozen_string_literal: true

module Table
  class Table
    attr_accessor :length_table, :width_table

    def initialize(length_table = 5, width_table = 6)
      @length_table = length_table
      @width_table = width_table
    end
  end
end
