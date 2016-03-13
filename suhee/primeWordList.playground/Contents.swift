//: Playground - noun: a place where people can play

import UIKit



import Foundation

let primeWords:Array<String> = ["Fruit","Jacket","School"]

let targetWords:Array<String> = ["Lemon", "Shirts", "Book"]

let masks:Array<String> = ["asdsdcxpv","skfjdjalk","fkgajkpmo"]


// arrange data for 4 trials

let wordListSet1:Array<String> = ["+", primeWords[0],"",targetWords[0],""]

let wordListSet2:Array<String> = ["+", primeWords[0],"",targetWords[1],""]

let wordListSet3:Array<String> = ["+", primeWords[1],"",targetWords[1],""]

let wordListSet4:Array<String> = ["+", primeWords[1],"",targetWords[2],""]

// Sum all the wordListSets

let summedList:[Array<String>] = [wordListSet1, wordListSet2, wordListSet3, wordListSet4]
