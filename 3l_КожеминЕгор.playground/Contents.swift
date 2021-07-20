import UIKit

// 1. Описать несколько структур
// 2. Структуры должны содержать свойства - номер, состояние покоя, год выпска, тип транспорта и тд
// 3. Описать перечисление с возможными действиями над структурами
// 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
// 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
// 6. Вывести значения свойств экземпляров в консоль.

enum State {
    case stationary // Без движения
    case readyToGo // Готов к движению
    case enRoute // В пути
}

enum PlanType {
    case passenger // Пассажирский
    case cargo // Грузовой
}

print("\n\n======Структура Самолет======\n")

struct Plane {
    var number: String
    var year: Int
    var seats: Int
    var planeLadderState = 1 // Состояние трапа 0 - Закрыт; 1 - Открыт
    private var state: State = .stationary
    var type: PlanType

    var currentStateName: String {
        switch state {
        case .enRoute:
            return "В полете"
        case .readyToGo:
            return "Готов к полету"
        default:
            return "В порту"
        }
    }

    init(number: String, year: Int, type: PlanType) {
        self.number = number
        self.year = year
        self.type = type
        seats = (type == .passenger) ? 100 : 50
    }

    init(type: PlanType) {
        self.type = type
        switch type {
        case .cargo:
            number = "Ан-225 «Мрия»"
            year = 2015
            seats = 50
        default:
            number = "Sukhoi Superjet 100"
            year = 2020
            seats = 108
        }
    }

    // Убрать трап
    mutating func closeLadder() {
        if planeLadderState == 1 {
            planeLadderState = 0
            print("Трап убран.")
        }
    }

    // Подготовить к вылету
    mutating func setReadyToGo() -> Bool {
        if planeLadderState != 0 {
            print("Необходимо убрать трап!")
            return false
        }

        if state != .stationary {
            print("Самолет \(number) уже в движении!")
            return false
        }

        state = .readyToGo
        print("Самолет \(number) готов к вылету.")
        return true
    }

    // Взлет
    mutating func go() -> Bool {
        if state != .readyToGo {
            print("Самолет \(number) не готов к вылету!")
            return false
        }

        state = .enRoute
        return true
    }

    // Посадка
    mutating func setLanding() -> Bool {
        if state == .enRoute {
            state = .stationary
            print("Самолет \(number) совершил успешную посадку!")
            return true
        }

        print("Самолет \(number) на текущий момент не в полете!")
        return false
    }
}

var planePassenger = Plane(type: .passenger)
if !planePassenger.go() {
    planePassenger.closeLadder()
    planePassenger.setReadyToGo()

    if planePassenger.go() {
        print("Взлет успешный")
    }
}

// Совершаем посадку
planePassenger.setLanding()

print("""

Информация:
==========
Марка самолета: \(planePassenger.number)
Тип: \(planePassenger.type)
Всего мест: \(planePassenger.seats)
Год выпуска: \(planePassenger.year)
Текущее состояние: \(planePassenger.currentStateName)
""")

print("\n\n======Структура Корабль======\n")

struct Ship {
    var number = ""
    var neme = ""
    private var state: State = .stationary {
        didSet {
            print("Запись бортового журнала: \(Ship.getStateName(state: oldValue)) -> \(Ship.getStateName(state: state))")
        }
    }

    var type: PlanType = .passenger

    // Управление движением
    mutating func control(state: State) -> Bool {
        switch state {
        case .readyToGo where !checkPassport(), .enRoute where !checkPassport():
            print("Движение кораблю запрещено т.к. нет номера или названия!")
            return false
        default:
            self.state = state
            return true
        }
    }

    mutating func setParam(number: String, name: String) {
        neme = name
        self.number = number
        print("Номер и название кораблю присвоены")
    }

    func checkPassport() -> Bool {
        return (neme != "" && number != "")
    }

    func printInfo() {
        print("""

        Информация:
        ==========
        Корабль: \(neme), \(number)
        Тип Корабля: \(type)
        Текущее состояние: \(Ship.getStateName(state: state))
        """)
    }

    static func getStateName(state: State) -> String {
        switch state {
        case .enRoute:
            return "В движении"
        case .readyToGo:
            return "Готов к отплытию"
        default:
            return "В порту"
        }
    }
}

var ship = Ship()
ship.control(state: .enRoute)
ship.setParam(number: "A-270", name: "Great Eastern")
ship.control(state: .readyToGo)
ship.control(state: .enRoute)
ship.control(state: .stationary)
ship.printInfo()
