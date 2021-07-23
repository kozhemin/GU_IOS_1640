import UIKit

// 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.

enum Action {
    case parking // Парковка
    case race // Гонка
    case carriageOfGoods // Грузоперевозка
}

class Car {
    var number: String
    var engineVolume: Double
    var clearance: Double
    var passengerSeats: Int
    var state: Action = .parking

    init(number: String, engineVolume: Double, clearance: Double, passengerSeats: Int) {
        self.number = number
        self.engineVolume = engineVolume
        self.clearance = clearance
        self.passengerSeats = passengerSeats
    }

    // Переопределяемый метод в наследниках
    func control(action: Action) {
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

// 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.

// 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.

// 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.

class TrunkCar: Car {
    var trunkSize: Double // Размер кузова
    private var hasTrailer = false // Наличие прицепа
    private var minEngineVolumeForTrailer = 10.0 // Минимальный объем двигателя для допуска к прицепу

    init(number: String, engineVolume: Double, clearance: Double, trunkSize: Double) {
        self.trunkSize = trunkSize
        let passengerSeats = 2 // по умолчанию для грузовых
        super.init(number: number, engineVolume: engineVolume, clearance: clearance, passengerSeats: passengerSeats)
    }

    override func control(action: Action) {
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

    // метод загрузки грузовика
    func shipment() -> Bool {
        if state == .parking {
            var message = "Загрузка кузова объемом \(trunkSize)"
            if hasTrailer {
                message += " и дополнительного прицепа"
            }
            message += " успешно завершена!"
            print(message)
            return true
        }
        return false
    }

    func getHasTrailer() -> Bool {
        return hasTrailer
    }
}

enum Category: String {
    case cityRace = "Для городских гонок"
    case supercar = "Суперкары"
    case exotic = "Экзотические"
    case hypercar = "Гиперкары"
}

class SportСar: Car {
    var spoilerSize: Double
    private var numberOfWins = 0
    private var category: Category = .cityRace

    init(spoilerSize: Double, number: String, engineVolume: Double, clearance: Double, passengerSeats: Int) {
        self.spoilerSize = spoilerSize
        super.init(number: number, engineVolume: engineVolume, clearance: clearance, passengerSeats: passengerSeats)
    }

    override func control(action: Action) {
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
        return category.rawValue
    }
}

// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.

let trunkCar = TrunkCar(number: "с 065 мк", engineVolume: 16, clearance: 210.0, trunkSize: 6.0)
trunkCar.setTrailer()
trunkCar.shipment()
trunkCar.control(action: .carriageOfGoods)

let sportСar = SportСar(spoilerSize: 22.5, number: "с 069 мк", engineVolume: 4, clearance: 30.5, passengerSeats: 4)
sportСar.setCategory(category: .cityRace)
sportСar.addWin()
sportСar.addWin()
sportСar.addWin()
sportСar.control(action: .race)

// 6. Вывести значения свойств экземпляров в консоль.

print("""
\n\nГрузовая машина
===============\n
Номер: '\(trunkCar.number)'
Объем двигателя: \(trunkCar.engineVolume) л.
Дорожный просвет: \(trunkCar.clearance) см.
К-во пассажирских мест: \(trunkCar.passengerSeats)
Объем кузова: \(trunkCar.trunkSize) л.
Наличие прицепа: \(trunkCar.getHasTrailer() ? "Да" : "Нет")
Текущее состояние: \(trunkCar.getActionName())
""")

print("""
\n\nСпортивная машина
=================\n
Номер: '\(trunkCar.number)'
Объем двигателя: \(sportСar.engineVolume) л.
Дорожный просвет: \(sportСar.clearance) см.
К-во пассажирских мест: \(sportСar.passengerSeats)
Размер спойлера: \(sportСar.spoilerSize) см.
Категория машины: \(sportСar.getCagegory())
Текущее состояние: \(sportСar.getActionName())
Число побед в гонках: \(sportСar.getWin())
""")
