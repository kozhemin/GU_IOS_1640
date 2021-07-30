
// 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
// 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
// 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

protocol TaskProtocol {
    var id: Int { get set }
    func taskExecute() -> Bool
}

struct Queue<T: TaskProtocol> {
    private var items: [T]

    init(items: [T]) {
        self.items = items
    }

    subscript(index: Int) -> T? {
        if items.indices.contains(index) {
            return items[index]
        }
        return nil
    }

    mutating func push(item: T) {
        items.insert(contentsOf: [item], at: 0)
    }

    mutating func pull() -> T {
        return items.removeLast()
    }

    mutating func pullAndDefaultExecute() -> Bool {
        let lastTask = pull()
        return lastTask.taskExecute()
    }

    mutating func pullAndCustomExecute(worker: (T) -> Bool) -> Bool {
        let lastTask = pull()
        return worker(lastTask)
    }

    func getItemsByFilter(closure: (T) -> Bool) -> [T] {
        return items.filter(closure)
    }

    func getItemByCondition(closure: ([T]) -> T?) -> T? {
        return closure(items)
    }
}

struct Task: TaskProtocol {
    var id: Int
    var description: String

    func taskExecute() -> Bool {
        print("Стандартное выполнение задачи  №\(id) - \(description)")
        return true
    }
}

var queue = Queue(items: [Task(id: 1, description: "Первая задача")])

// Наполняем очередь
queue.push(item: Task(id: 4, description: "Четвертая задача"))
queue.push(item: Task(id: 2, description: "Вторая задача"))
queue.push(item: Task(id: 3, description: "Третья задача"))
queue.push(item: Task(id: 5, description: "Пятая задача"))
queue.push(item: Task(id: 6, description: "Шестая задача"))

// Разбор очереди

// Выполнение задания из очереди с индивидуальной логикой заложенной в замыкании
let myWorker = { (item: TaskProtocol) -> Bool in
    print("Некоторая индивидуальная логика и выполнение задания №\(item.id)")
    return true
}

queue.pullAndCustomExecute(worker: myWorker)

// Выполнение задания из очереди стандартным обработчиком
queue.pullAndDefaultExecute()

// Получение элемента очереди по индивидуальной логике (например получить задачу из середины очереди)
let myQueue = queue.getItemByCondition(closure: { (items: [TaskProtocol]) -> Task? in
    guard items.count > 0 else { return nil }
    let index = Int(items.count / 2)
    return items[index] as? Task
})
print(myQueue)

// Получить задачи очереди по индивидуальному фильтру (например все задачи с четными идентификаторами)
let evenTaskList = queue.getItemsByFilter(closure: { (item: TaskProtocol) -> Bool in
    item.id % 2 == 0
})
print(evenTaskList)

// Получить задачи очереди по индивидуальному фильтру (например все задачи у которых номер больше 5)
let customTaskList = queue.getItemsByFilter { $0.id > 5 }
print(customTaskList)

// Получить элемент очереди по индексу, который будет возвращать nil в случае обращения к несуществующему индексу.
print(queue[100])
