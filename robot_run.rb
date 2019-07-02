# frozen_string_literal: true

# choise method run
module RobotRun
  load 'robot.rb'
  load 'table.rb'
  def self.geted_size?(len, widh)
    len.size.positive? && widh.size.positive? && widh.to_i <= 0 && len.to_i <= 0
  end

  def self.create_table
    puts 'Введите длину стола'
    x = gets.chomp.to_i
    puts 'Введите ширину стола'
    y = gets.chomp.to_i

    tabl = geted_size?(x, y) ? Table::Table.new : Table::Table.new(x, y)
    tabl
  end

  def self.choise_action(act, table, robot)
    case act.split[0]
    when 'PLACE'
      act.slice!('PLACE')
      tmp = act.split(',')
      robot.place(table, tmp[0].to_i, tmp[1].to_i, tmp[2])
    when 'MOVE' then robot.move
    when 'LEFT' then robot.left
    when 'RIGHT' then robot.right
    when 'REPORT' then robot.report
    end
  end

  def self.cli_r
    tabl = create_table
    robot = Robot::Robot.new
    loop do
      puts 'Выберите действие или введите exit  для выхода'
      act = gets.chomp.upcase
      case act.split[0]
      when 'EXIT' then break
      else choise_action(act, tabl, robot)
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
          act.slice!('PLACE')
          tmp = act.gsub(/\s+/, '').split(',')
          robot.place(tab_f, tmp[0].to_i, tmp[1].to_i, tmp[2])
        when 'MOVE' then robot.move
        when 'LEFT' then robot.left
        when 'RIGHT' then robot.right
        when 'REPORT' then robot.report
        end
      end
    else
      puts 'No such file'
    end
  end
end
