import UIKit

enum Action {
    case parking // Парковка
    case race // Гонка
    case carriageOfGoods // Грузоперевозка
}

// 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.

protocol CarProtocol {
    var number: String { get set }
    var engineVolume: Double { get set }
    var passengerSeats: Int { get set }
    var state: Action { get set }

    func control(action: Action)
    func getActionName() -> String
}

// 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).

extension CarProtocol {
    func openWindow() {
        print("\(number) - Окна открыты.")
    }

    func closeWindow() {
        print("\(number) - Окна закрыты.")
    }

    func startEngine() {
        print("\(number) - Двигатель запущен.")
    }

    func turnOff() {
        print("\(number) - Двигатель заглушен.")
    }

    mutating func control(action: Action) {
        state = action
    }

    func getActionName() -> String {
        switch state {
        case .carriageOfGoods:
            return "На грузоперевозка"
        case .parking:
            return "На парковке"
        case .race:
            return "На гонках"
        }
    }
}

// 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

class TrunkCar: CarProtocol {
    var number: String
    var engineVolume: Double
    var passengerSeats: Int = 2 // по умолчанию для грузовых
    var state: Action = .parking
    var trunkSize: Double // Размер кузова
    private var hasTrailer = false // Наличие прицепа
    private var minEngineVolumeForTrailer = 10.0 // Минимальный объем двигателя для допуска к прицепу

    init(number: String, engineVolume: Double, trunkSize: Double) {
        self.number = number
        self.engineVolume = engineVolume
        self.trunkSize = trunkSize
    }

    func control(action: Action) {
        if action == .race {
            print("Грузовые машины не участвуют в гонках!")
        } else {
            state = action
        }
    }

    func setTrailer() -> Bool {
        if engineVolume > minEngineVolumeForTrailer {
            hasTrailer = true
        }
        return false
    }

    func getHasTrailer() -> Bool {
        return hasTrailer
    }
}

protocol CategoryProtocol {
    func getCategoryName() -> String
}

enum Category: String, CategoryProtocol {
    case cityRace = "Для городских гонок"
    case supercar = "Суперкары"
    case exotic = "Экзотические"
    case hypercar = "Гиперкары"

    func getCategoryName() -> String {
        return rawValue
    }
}

class SportСar: CarProtocol {
    var number: String
    var engineVolume: Double
    var passengerSeats: Int
    var state: Action = .parking
    private var numberOfWins = 0
    private var category: Category = .cityRace

    init(number: String, engineVolume: Double, passengerSeats: Int) {
        self.number = number
        self.engineVolume = engineVolume
        self.passengerSeats = passengerSeats
    }

    func control(action: Action) {
        if action == .carriageOfGoods {
            print("Спортивные машины не перевозят грузы!")
        } else {
            state = action
        }
    }

    func addWin() -> Int {
        numberOfWins += 1
        return numberOfWins
    }

    func getWin() -> Int {
        return numberOfWins
    }

    func setCategory(category: Category) {
        self.category = category
    }

    func getCagegory() -> String {
        return category.getCategoryName()
    }
}

// 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return """
        \n\nГрузовая машина
        ===============\n
        Номер: '\(number)'
        Объем двигателя: \(engineVolume) л.
        К-во пассажирских мест: \(passengerSeats)
        Объем кузова: \(trunkSize) л.
        Наличие прицепа: \(getHasTrailer() ? "Да" : "Нет")
        Текущее состояние: \(getActionName())
        """
    }
}

extension SportСar: CustomStringConvertible {
    var description: String {
        return """
        \n\nСпортивная машина
        =================\n
        Номер: '\(number)'
        Объем двигателя: \(engineVolume) л.
        К-во пассажирских мест: \(passengerSeats)
        Категория машины: \(getCagegory())
        Текущее состояние: \(getActionName())
        Число побед в гонках: \(getWin())
        """
    }
}

// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.

let trunkCar = TrunkCar(number: "с 065 мк", engineVolume: 16, trunkSize: 6.0)
trunkCar.passengerSeats = 3
trunkCar.setTrailer()
trunkCar.control(action: .carriageOfGoods)
trunkCar.openWindow()
trunkCar.turnOff()

print("\n")

let sportСar = SportСar(number: "с 069 мк", engineVolume: 4, passengerSeats: 4)
sportСar.setCategory(category: .cityRace)
sportСar.addWin()
sportСar.addWin()
sportСar.control(action: .race)
trunkCar.closeWindow()
trunkCar.startEngine()

// 6. Вывести сами объекты в консоль.

print(trunkCar)
print(sportСar)
