//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var str2 = "Hello 2"

str2 = "bye"

var myTotals:(Int,Int) = (100, 200)

myTotals.0

myTotals

for idx in 1...3 {
    
    print("index is \(idx)")
}


let initialBits: UInt8 = b00001111

let invertedBits = ~initialBits