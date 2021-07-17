import UIKit

// 1. Написать функцию, которая определяет, четное число или нет.

func isEvenNumber(number n: Int) -> Bool{
    return n % 2 == 0
}

// 2. Написать функцию, которая определяет, делится ли число без остатка на 3

func isDivisibleByThreeWithoutRemainder(number n: Int) -> Bool{
    return n % 3 == 0
}

// 3. Создать возрастающий массив из 100 чисел.

var increasingArray = Array(0...99)

// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

for index in increasingArray{
    if isEvenNumber(number: index) || isDivisibleByThreeWithoutRemainder(number: index){
        if let key = increasingArray.firstIndex(where: { $0 == index }){
            increasingArray.remove(at: key)
        }
    }
}

increasingArray // 1, 5, 7, 11, 13, 17, 19...

// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.

// Fn=Fn-1 + Fn-2
func Fibo(number: Int) -> Int{
    var a = 1
    var b = 1
    var i = 3
    
    while i <= number {
        let tmp = a + b
        a = b
        b = tmp
        i += 1
    }
    
    return b
}

func addFibToArray(arr: inout [Int], count: Int){
    if count > 0{
        for i in 1...count {
            arr.append(Fibo(number: i))
        }
    }
}

var fiboArray = [Int]()
addFibToArray(arr: &fiboArray, count: 50)
fiboArray // 1, 1, 2, 3, 5, 8, 13, 21...

/*
 6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
 
 a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
 b. Пусть переменная p изначально равна двум — первому простому числу.
 c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
 d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
 e. Повторять шаги c и d, пока возможно.
 
 */

var n = 545
var p = 2
var resultArray = [Int]()
var temporaryArray = [Int]()

for i in 0...n {
    temporaryArray.append(i)
}

temporaryArray[1] = 0 // Единица не натуральное

while p <= n {
    if temporaryArray[p] != 0{
        var j = p + p
        while j <= n {
            temporaryArray[j] = 0
            j += p
        }
    }
    p += 1
}

// Теперь просто удалим вычеркнутые
resultArray =  temporaryArray.filter(){ item in
    return item != 0
}

resultArray // 2, 3, 5, 7, 11, 13, 17, 19..
print("Всего элементов \(resultArray.count)")
