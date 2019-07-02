# frozen_string_literal: true

# choise method run
module RobotRun
  load 'robot.rb'
  load 'table.rb'
  def self.cli_r
    puts 'Введите длину стола'
    x = gets.chomp
    puts 'Введите ширину стола'
    y = gets.chomp

    tabl = if x.size.positive? && y.size.positive? && y.to_i <= 0 && x.to_i <= 0
             Table::Table.new
           else
             Table::Table.new(x.to_i, y.to_i)
           end
    robot = Robot::Robot.new

    loop do
      puts 'Выберите действие или введите exit  для выхода'
      print ['PLACE ', 'MOVE', 'LEFT', 'RIGHT', 'REPORT']
      puts ''
      act = gets.chomp.upcase
      case act.split[0]
      when 'PLACE'
        act.slice!('PLACE')
        tmp = act.gsub(/\s+/, '').split(',')
        robot.place(tabl, tmp[0].to_i, tmp[1].to_i, tmp[2])
      when 'MOVE' then robot.move
      when 'LEFT' then robot.left
      when 'RIGHT' then robot.right
      when 'REPORT' then robot.report
      when 'EXIT' then break
      end
    end
  end

  def self.file_r
    puts 'Введите имя файла(с учётом регистра)'
    file_name = gets.chomp
    tab_f = Table::Table.new
    robot = Robot::Robot.new
    if FileTest.exist?(file_name)
      fil_rd = File.open(file_name)
      fil_rd.each do |line|
        act = line.chomp.upcase
        case act.split[0]
        when 'TABLE'
          act.slice!('TABLE')
          tmp = act.gsub(/\s+/, '').split(',')
          tab_f = Table::Table.new(tmp[0].to_i, tmp[1].to_i)
        when 'PLACE'
          print line
          act.slice!('PLACE')
          tmp = act.gsub(/\s+/, '').split(',')
          robot.place(tab_f, tmp[0].to_i, tmp[1].to_i, tmp[2])
        when 'MOVE' then robot.move
        when 'LEFT' then robot.left
        when 'RIGHT' then robot.right
        when 'REPORT' then robot.report
        when 'EXIT' then break
        end
      end
    else
      puts 'No such file'
    end
  end
end
