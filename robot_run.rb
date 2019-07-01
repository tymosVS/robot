# frozen_string_literal: true

module RobotRun
  load 'robot.rb'
  load 'table.rb'

  def self.test
    tab = Table::Table.new(10,10)
    rob1 = Robot::Robot.new
    puts 'проверка на не выход на юг'
    rob1.PLACE(tab, 2, 2, 'SOUTH')
    10.times do
      rob1.MOVE
      rob1.REPORT
    end
    puts 'проверка на не выход на запад'
    rob2 = Robot::Robot.new
    rob2.PLACE(tab, 9, 2, 'WEST')
    10.times do
      rob2.MOVE
      rob2.REPORT
    end
    puts 'проверка на не размещение при невеных кооординатах'
    rob3 = Robot::Robot.new
    rob3.PLACE(tab, 10, 2, 'WEST')
    rob3.REPORT
    rob3.PLACE(tab, 2, 10, 'WEST')
    rob3.MOVE
    rob3.REPORT
    rob3.PLACE(tab, -1, 10, 'WEST')
    rob3.REPORT
    rob3.PLACE(tab, 2, -1, 'WEST')
    rob3.REPORT
    rob3.PLACE(tab, 0, 0, 'WEST')
    rob3.REPORT
    puts 'проверка на не выход на восток'
    rob4 = Robot::Robot.new
    rob4.PLACE(tab, 8, 2, 'EAST')
    10.times do
      rob4.MOVE
      rob4.REPORT
    end
    puts 'проверка на не выход на север'
    rob5 = Robot::Robot.new
    rob5.PLACE(tab, 8, 8, 'NORTH')
    4.times do
      rob5.MOVE
      rob5.REPORT
    end
  end

  def self.cli_r
    puts 'Введите длину стола'
    x = gets.chomp
    puts 'Введите ширину стола'
    y = gets.chomp

    if x.length > 0 && y.length > 0 && y.to_i > 0 && x.to_i > 0
      tabl = Table::Table.new(x.to_i,y.to_i)

    else
      tabl = Table::Table.new
    end
    robot = Robot::Robot.new

    while true
      puts 'Выберите действие или введите exit  для выхода'
      print  ['PLACE ', 'MOVE', 'LEFT', 'RIGHT', 'REPORT']
      puts ''
      act = gets.chomp.upcase
      case act.split[0]
      when 'PLACE'
        act.slice!('PLACE')
        tmp = act.gsub(/\s+/, "").split(',')
        # print tmp
        robot.PLACE(tabl, tmp[0].to_i, tmp[1].to_i,tmp[2])
      when 'MOVE'
        robot.MOVE
      when 'LEFT'
        robot.LEFT
      when 'RIGHT'
        robot.RIGHT
      when 'REPORT'
        robot.REPORT
      when 'EXIT'
        break
      end
    end
  end

  def self.file_r
    puts 'Введите имя файла(с учётом регистра)'
    file_name = gets.chomp

    tab_f = Table::Table.new

    robot = Robot::Robot.new
    if FileTest::exist?(file_name)
    fil_rd = File.open(file_name, "r+")
      fil_rd.each do |line|

        act = line.chomp.upcase
        case act.split[0]
        when 'TABLE'
          act.slice!('TABLE')
          tmp = act.gsub(/\s+/, "").split(',')
          print tmp
          tab_f = Table::Table.new( tmp[0].to_i, tmp[1].to_i)
        when 'PLACE'
          print line
          act.slice!('PLACE')
          tmp = act.gsub(/\s+/, "").split(',')
          print tab_f.x
          print tmp
          robot.PLACE(tab_f, tmp[0].to_i, tmp[1].to_i,tmp[2])
        when 'MOVE'
          robot.MOVE
        when 'LEFT'
          robot.LEFT
        when 'RIGHT'
          robot.RIGHT
        when 'REPORT'
          robot.REPORT
        when 'EXIT'
        end
      end
    else
      puts 'No such file'
    end
  end

end
