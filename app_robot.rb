# frozen_string_literal: true

require './robot_run'

def run
  scen = ''
  while scen.upcase != 'EXIT'
    puts 'Введите cli для ввода с CLI, '\
         'file для чтения из файла или exit для выхода'
    case scen = gets.chomp.upcase
    when 'CLI'
      RobotRun.cli_r
    when 'FILE' then RobotRun.file_r
    end
  end
end

run
