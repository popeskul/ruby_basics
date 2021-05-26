require_relative 'route'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'modules/validation'

class Interface
  TYPE_CARGO = 'cargo'.freeze
  TYPE_PASS = 'pass'.freeze
  ATTEMPTS_ON_ERROR = 4

  def initialize
    @stations = []
    @trains   = []
    @routes   = []
    @wagons   = []
  end

  def user_interface
    loop do
      menu_messages

      print 'Выберите пункт меню: '
      user_response = gets.chomp.to_i

      case user_response
      when 0 then break
      when 1 then menu_stations
      when 2 then menu_trains
      when 3 then menu_routes
      when 4 then menu_wagons
      else puts 'Не правильный ввод!'
      end
    end
  end

  private

  def menu_messages
    puts '
    1 - Станции
    2 - Поезда
    3 - Маршруты
    4 - Вагоны
    0 - Выход из программы'
  end

  def menu_stations
    puts 'Меню станций'
    puts '
    1 - Создать станцию
    2 - Посмотреть список станций
    0 - Вернуться в меню'

    print 'Выберите пункт меню: '
    user_choice = gets.chomp

    case user_choice.to_i
    when 0 then user_interface
    when 1 then create_station
    when 2 then list_stations
    else puts 'Повторите ввод'
    end
    menu_stations
  end

  def menu_trains
    puts 'Меню поезда:
    1 - Создать поезд
    2 - Посмотреть список поездов
    0 - Вернуться в меню'

    print 'Введите пункт меню: '
    user_choice = gets.chomp

    case user_choice.to_i
    when 1 then create_train
    when 2 then list_trains
    when 0 then user_interface
    else puts 'Повторите ввод'
    end
    menu_trains
  end

  def menu_routes
    puts 'Меню маршрута:
    1 - Создать маршрут
    2 - Посмотреть список маршрутов
    3 - Станций в маршруте
    4 - Добавить станцию в маршрут
    5 - Удалить станцию из маршрута
    6 - Назначать маршрут поезду
    7 - Текущая станция в маршруте
    8 - Переместить поезд вперед на одну станцию
    9 - Переместить поезд назад на одну станцию
    0 - Вернуться в меню'

    puts 'Выберите пункт меню'

    user_choice = gets.chomp.to_i

    case user_choice
    when 1 then create_route
    when 2 then list_routes
    when 3 then station_by_route
    when 4 then add_station
    when 5 then remove_station
    when 6 then set_route
    when 7 then current_station
    when 8 then next_station
    when 9 then prev_station
    when 0 then user_interface
    else puts 'Повторите ввод'
    end

    menu_routes
  end

  def menu_wagons
    puts 'Меню вагона:
    1 - Создать и добавить вагон
    2 - Отцепить вагон
    3 - Информация о вагоне
    4 - Занять место
    0 - Вернуться в меню'
    puts 'Что хотите сделать? Введите цифру'
    user_choice = gets.chomp

    case user_choice.to_i
    when 1 then add_wagon
    when 2 then remove_wagon
    when 3 then wagon_info
    when 4 then add_place
    when 0 then user_interface
    else puts 'Повторите ввод'
    end

    menu_wagons
  end

  def create_station
    print 'Для создания станции введите название: '
    station_title = gets.chomp
    @stations << Station.new(station_title)
    puts 'Станция создана'
  end

  def create_train
    attempt = ATTEMPTS_ON_ERROR
    begin
      print 'Создайте номер поезда: '
      train_num = gets.chomp

      print "Какой тип поезда #{TYPE_PASS} или #{TYPE_CARGO}: "
      train_type = gets.chomp

      train = train_type.include?(TYPE_PASS) ? PassengerTrain.new(train_num) : CargoTrain.new(train_num)
      @trains.push(train)
      puts 'Поезд создан'
    rescue ValidationError => e
      attempt -= 1
      puts e.message
      puts "Осталось попыток - #{attempt}"
      retry if attempt.positive?
    end
  end

  def create_route
    attempt = ATTEMPTS_ON_ERROR
    begin
      print 'Создайте название нового маршрута: '
      route_name = gets.chomp

      puts 'Cписок станций:'
      list_stations

      print 'Выберите из списка название для Первой станция маршрута: '
      first_station_title = gets.chomp

      first_station = find_station(first_station_title)

      puts 'Cписок станций:'
      list_stations

      print 'Выберите из списка название для Второй станция маршрута: '
      second_station_title = gets.chomp

      second_station = find_station(second_station_title)
      @routes << Route.new(route_name, first_station, second_station)
      puts 'Маршрут создан'
    rescue ValidationError => e
      attempt -= 1
      puts e.message
      puts "Осталось попыток - #{attempt}"
      retry if attempt.positive?
    end
  end

  def station_by_route
    list_routes

    puts 'Выберите маршрут для того чтобы узнать сколько там станций: '
    route_name = gets.chomp
    route = find_route(route_name)

    if route.nil?
      puts 'Ошибка ввода названия станции!'

      loop do
        puts 'Повторить создание станции?'

        puts '
        1 - да
        0 - нет, вернуться в предыдущее меню'

        user_choice = gets.chomp.to_i

        case user_choice
        when 1 then station_by_route
        when 0 then menu_routes
        else puts 'Повторите ввод'
        end
      end
    else
      puts "В маршруте '#{route.name}' есть такие станции: "
      route.stations.each { |station| puts station.name }
    end
  end

  def add_station
    puts 'Давайте добавим станцию в маршрут.'

    list_routes

    puts 'В какой маршрут хотите добавить станцию? '
    print 'Введите названия маршрута: '

    user_route = gets.chomp

    route = find_route(user_route)

    list_stations

    puts 'Какую станцию хотите добавить в маршрут?'
    print 'Введите названия новой станции: '
    new_station = gets.chomp

    station = find_station(new_station)

    if station.nil?
      puts 'Ошибка при добавлении станции в маршрут.'

      loop do
        puts 'Повторить добавление станции в маршрут?'

        puts '
        1 - да
        0 - нет, вернуться в предыдущее меню'

        user_choice = gets.chomp

        case user_choice.to_i
        when 1 then add_station
        when 0 then menu_routes
        else puts 'Повторите ввод'
        end
      end
    else
      route.add_station(station)
      puts 'Станция добавлена в маршрут'
    end
  end

  def set_route
    puts 'Cписок маршрутов:'
    list_routes

    puts 'Выберите маршрут для добавления к поезду:'
    user_route = gets.chomp
    route = find_route(user_route)

    if route.nil?
      puts 'Ошибка! Не правильный маршурт.'
      puts 'Повторить добавление маршрут к поезду?'

      puts '
      1 - да
      0 - нет, вернуться в предыдущее меню'

      user_choice = gets.chomp

      case user_choice.to_i
      when 1 then set_route
      when 0 then menu_routes
      else puts 'Повторите ввод'
      end
    else
      list_trains

      puts 'Выберите поезд:'
      user_train = gets.chomp
      train = find_train(user_train)

      train.add_route(route)
      puts 'Маршрут назначен'
    end
  end

  def remove_station
    puts 'Давайте удалим станцию из маршрута.'

    list_routes

    puts 'Какой маршрут хотите выбрать для продолжения?'
    print 'Введите названия маршрута: '

    user_route = gets.chomp

    route = find_route(user_route)

    list_stations

    puts 'Какую станцию в маршруте вы хотите удалить?'
    print 'Названия станции для удаления: '
    user_station = gets.chomp

    station = find_station(user_station)

    if station.nil?
      puts 'Ошибка при удалении станции из маршрута.'

      loop do
        puts 'Повторить удаление станции из маршрута?'

        puts '
        1 - да
        0 - нет, вернуться в предыдущее меню'

        user_choice = gets.chomp

        case user_choice.to_i
        when 1 then remove_station
        when 0 then menu_routes
        else puts 'Повторите ввод'
        end
      end
    else
      route.delete_station(station)
      puts 'Станция удалена из маршрута'
    end
  end

  def current_station
    list_trains

    puts 'Выберите поезд для того чтобы узнать его местоположение'
    user_train = gets.chomp
    train = find_train(user_train)

    if train.nil?
      puts 'Не верный поезд'

      loop do
        puts 'Повторить?'

        puts '
        1 - да
        0 - нет, вернуться в предыдущее меню'

        user_choice = gets.chomp

        case user_choice.to_i
        when 1 then current_station
        when 0 then menu_routes
        else puts 'Повторите ввод'
        end
      end
    else
      train_station = train.current_station
      puts train_station.inspect
    end
  end

  def next_station
    list_trains

    puts 'Выберите поезд для того чтобы узнать следующую станцию: '
    user_train = gets.chomp
    train = find_train(user_train)

    if train.nil?
      puts 'Не верный поезд'

      loop do
        puts 'Повторить?'

        puts '
        1 - да
        0 - нет, вернуться в предыдущее меню'

        user_choice = gets.chomp

        case user_choice.to_i
        when 1 then next_station
        when 0 then menu_routes
        else puts 'Повторите ввод'
        end
      end
    else
      next_station = train.route_shift_forward
      puts next_station.inspect
    end
  end

  def prev_station
    attempt = ATTEMPTS_ON_ERROR
    begin
      list_trains

      puts 'Выберите поезд для того чтобы узнать предыдущую станцию: '
      user_train = gets.chomp
      train = find_train(user_train)

      prev_station = train.route_shift_backward
      puts prev_station
    rescue ValidationError => e
      attempt -= 1
      puts e.message
      puts "Осталось попыток - #{attempt}"
      retry if attempt.positive?
    end
  end

  def create_wagon(type_wagon)
    case type_wagon
    when TYPE_PASS then PassengerWagons.new(type_wagon)
    when TYPE_CARGO then CargoWagons.new(type_wagon)
    else puts 'Неверный ввод, повторите!'
    end
  end

  def add_wagon
    attempt = ATTEMPTS_ON_ERROR
    begin
      list_trains

      puts 'Выберите поезд которому хотите добавить вагон'
      user_train = gets.chomp
      train = find_train(user_train)

      puts "Выберите тип нового вагона: #{TYPE_PASS} или #{TYPE_CARGO}"
      wagon_type = gets.chomp
      wagon = create_wagon(wagon_type)

      train.add_wagon(wagon)

      puts 'Вагон создан и добавлен к поезду'
    rescue ValidationError => e
      attempt -= 1
      puts e.message
      puts "Осталось попыток - #{attempt}"
      retry if attempt.positive?
    end
  end

  def remove_wagon
    attempt = ATTEMPTS_ON_ERROR
    begin
      list_trains

      puts 'Выберите поезд у которго хотите удалить вагон'
      user_train = gets.chomp
      train = find_train(user_train)

      list_wagons(train.wagons)
      puts 'Выберите вагон для удаления'
      wagon_name = gets.chomp.to_i

      train.delete_wagon(wagon_name)

      puts 'Вагон отцеплен от поезда'
    rescue ValidationError => e
      attempt -= 1
      puts e.message
      puts "Осталось попыток - #{attempt}"
      retry if attempt.positive?
    end
  end

  def wagon_info
    attempt = 4
    begin
      list_trains
      puts 'Выберите поезд в котором хотите посмотреть места'
      user_train = gets.chomp
      train = find_train(user_train)
      raise ValidationError, 'Неверно название поезда' if train.nil?

      list_wagons(train.wagons)
      puts 'Выберите из списка вагон'
      user_wagon = gets.chomp.to_i
      wagon = find_wagon(train.wagons, user_wagon)
      raise ValidationError, 'Неверно название вагона' if wagon.nil?

      puts "В этом вагоне #{wagon.all_places} мест"
      puts "Свободно #{wagon.free_places}"
      puts ValidationError, "Занято #{wagon.places_occupied}"
    rescue ValidationError => e
      attempt -= 1
      puts e.message
      puts "Осталось попыток - #{attempt}"
      retry if attempt.positive?
    end
  end

  def add_place
    attempt = 4
    begin
      list_trains
      puts 'Выберите поезд в котором хотите занять место или объем'
      user_train = gets.chomp
      train = find_train(user_train)
      raise ValidationError, 'Неверно название поезд' if train.nil?

      list_wagons(train.wagons)
      puts 'Выберите из списка вагон в котором хотите занять место'
      user_wagon = gets.chomp.to_i

      wagon = find_wagon(train.wagons, user_wagon)
      raise ValidationError, 'Неверно название вагона' if wagon.nil?
    rescue ValidationError => e
      attempt -= 1
      puts e.message
      puts "Осталось попыток - #{attempt}"
      retry if attempt.positive?
    end

    if train.instance_of?(PassengerTrain)
      wagon.take_place
    else
      attempt = 4
      begin
        puts "Сейчас в грузовом отсеке свободно #{wagon.free_places}"
        puts 'Сколько хотите добавить?'
        user_place = gets.chomp.to_i

        raise ValidationError, "Ошибка! Сейчас - свободно #{wagon.free_places}" if user_place > wagon.free_places

        wagon.take_place(user_place)
      rescue ValidationError => e
        attempt -= 1
        puts e.message
        puts "Осталось попыток - #{attempt}"
        retry if attempt.positive?
      end
    end

    puts "Теперь в этомвагоне свободно #{wagon.free_places}"
  end

  def list_stations
    @stations.each { |station| puts station.name }
  end

  def list_trains
    @trains.each { |train| puts train.train_num }
  end

  def list_routes
    @routes.each { |route| puts route.name }
  end

  def list_wagons(wagons)
    wagons.each { |wagon| puts "Номер вагона - #{wagon.object_id}" }
  end

  def find_station(station_title)
    @stations.find { |station| station.name == station_title }
  end

  def find_route(route_title)
    @routes.find { |route| route.name == route_title }
  end

  def find_train(train_title)
    @trains.find { |route| route.train_num == train_title }
  end
end

program = Interface.new
program.user_interface
