# frozen_string_literal: true

module AppRobot
  load 'robot_run.rb'

  def self.run
    scen = ''
    while scen.upcase != 'EXIT'
      puts 'Введите test для отработки тестовых сценариев, ' \
           'cli для ввода с CLI, file для чтения из файла или exit для выхода'
      scen = gets.chomp
      case scen.upcase
      when 'TEST'
        RobotRun.test
      when 'CLI'
        RobotRun.cli_r
        break
      when 'FILE' then RobotRun.file_r
      end
    end
  end
end

AppRobot.run
