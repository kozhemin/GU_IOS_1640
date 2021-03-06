import UIKit

// 1. Решить квадратное уравнение.

print("Решить квадратное уравнение: x2 + 12x + 36 = 0")
let a = 1
let b = 12
let c = 36

// Дискриминант: D = b2 − 4ac.
let d = b*b - 4 * a * c
if d == 0 {
    let result = -b / 2*1
    print("Ответ: \(result)")
}

// 2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

print("Найти площадь, периметр и гипотенузу треугольника")
let a1: Float = 5.4 // Длина первого катета
let b1: Float = 2.1 // Длина второго катета

print("Площадь: ", (a1 * b1) / 2)
print("Периметр: ", a1 + b1 + sqrt((a1*a1 + b1*b1)))
print("Гипотенуза: ", sqrt(a1*a1 + b1*b1))

// 3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.

var sum: Float = 0
var deposit: Float = 100_000
var pt: Float = 4
 
for _ in 1...5 {
    sum += deposit / 100 * pt
}
 
print("Сумма дохода по вкладу (за 5 лет без учета капитализации): \(sum)")
