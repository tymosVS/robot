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

  def self.print_message
    puts 'Выберите действие или введите exit  для выхода'
    print %w[PLACE MOVE LEFT RIGHT REPORT]
    puts ''
  end

  def self.cli_r
    tabl = create_table
    robot = Robot::Robot.new
    loop do
      print_message
      act = gets.chomp.upcase
      case act.split[0]
      when 'EXIT' then break
      else choise_action(act, tabl, robot)
      end
    end
  end

  def self.open_file
    puts 'Введите имя файла(с учётом регистра)'
    file_name = gets.chomp
    fil_rd = File.open(file_name)
    fil_rd
  end

  def self.create_table_file(file_act)
    file_act.slice!('TABLE')
    tab_f = Table::Table.new(file_act.split(',')[0].to_i,
                             file_act.split(',')[1].to_i)
    tab_f
  end

  def self.file_r
    tab_f = Table::Table.new
    robot = Robot::Robot.new
    open_file.each do |line|
      file_act = line.chomp.upcase
      case file_act.split[0]
      when 'TABLE'
        tab_f = create_table_file(file_act)
      else choise_action(file_act, tab_f, robot)
      end
    end
  end
end
