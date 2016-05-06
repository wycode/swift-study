//: Playground - noun: a place where people can play

import UIKit
import CoreLocation
var str = "Hello, playground"

var welcomeMessage:String = "asd"
var wo = ["asd","med","sk"]
wo.append("sf")
wo[1...3] = ["fs","st","sdde","sde","de"]
//wo[6] = "da"
print(wo)
for (index, value) in wo.enumerate() {
    print("item \(index + 1):\(value)")
}
var letters = Set<Character>()
letters.count
letters.insert("3")

var favorites: Set<String> = ["3","2","5","6","1","4"]

favorites.contains("what")
favorites.sort { (s1, s2) -> Bool in

    return s1<s2
}

var oneArray = ["3","4","7","2","1"]
oneArray.sortInPlace { (s1, s2) -> Bool in
    
     s1>s2
}
var dictionary = [Int: String]()
dictionary[2] = "desde"
if let oldValue =  dictionary.updateValue("shit", forKey: 2){

    print(oldValue)
}
let yetAnotherPoint = (1,-1)
switch yetAnotherPoint{
case let (x,y) where x == y:
    print("s")
case let (x,y) where x == -y:
    print("d")
case let (x,y):
    print("no")

}

func greet (person: [String: String]){

    guard false  else{
    
        return
    }
}
func sayHello(personName: String)->String{

    return "Hello "+personName+" !"
}
sayHello("myFriend")

CATextLayer.init()



func minMax(array: [Int]) ->(min: Int , max: Int){
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count]{
        
        if value < currentMin
        {
            currentMin = value
        }
        else if value > currentMax
        {
            currentMax = value
        }
    }
    return (currentMin,currentMax)
}


let bounds = minMax([3,-1,6,4,5,7,2,8,5])

var just = Selector.init("sda")


let date = NSDate.init()
let time = date.timeIntervalSince1970

var st: String

func someFunction(firstParameterName: Int,secondParameterName: Int){

    
}

someFunction(1, secondParameterName: 2)

 func someFuncetion(externalParameterName localParameterName:Int){

}

print(date)

let location = CLLocation.init(latitude: 20, longitude: 50)

mach_absolute_time()

func sayHello(to person: String, and anotherPerson: String) -> String {

    return "Hello\(person) and \(anotherPerson)!"
}
print(sayHello(to: "Bill", and: "Ted"))

func someFunction(firstParameterName: Int, _secondParameterName: Int) {

    
}

func someFunction1(parameterWithDefault: Int = 12) {

}

print( someFunction1())




let a = NSDateFormatter.init()
a.dateFormat = "YYYY-MM-dd hh:mm:ss "

print(a.stringFromDate(date))

let btn = UIButton.init(type: .InfoDark)
btn.addTarget(sayHello("sda"), action: Selector.init("greet"), forControlEvents: UIControlEvents.TouchUpInside)
func arithmeticMean(numbers: Double...) ->Double {
    var total: Double = 0
    for number in numbers {
    total += number
    }
    return total / Double(numbers.count)
}

print(dictionary)


let names = ["sda","sdef","Alex","eWs","Barry"]
func backwards(s1: String, _ s2: String) -> Bool {
    
    return s1 > s2

}
var reversed = names.sort(backwards)

reversed = names.sort({ (s1: String, s2: String) -> Bool in
    return s1 > s2
})

reversed = names.sort({ (s1: String, s2: String) -> Bool in return s1 > s2
})

reversed = names.sort({ s1, s2 in return s1 > s2
})

reversed = names.sort({s1, s2 in s1 > s2 })

reversed = names.sort({$0 > $1 })
reversed = names.sort(){$0 > $1}

reversed = names.sort(>)

let digitNames = [
    0: "zero", 1: "one", 2:"two", 3:"three",
    4: "four", 5: "five", 6: "sdasd", 7:"df",
    8: "eight", 9: "nine",10: "ten"
]
let numbers = [16,54,24];
let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    while number > 0 {
    output = digitNames[number % 10]! +
        output
    number /= 10
    }
    return output
}

func makeIncrementer(forIncrement amount: Int) -> () -> Int{
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
incrementBySeven()
let alsoincrementByTen = incrementByTen
alsoincrementByTen()

func someFunctionWithNonesecapeClosure(@noescape closure: () -> Void){
  closure()
}

var completionHandlers:[() -> Void] = []

func someFunctionWithEscapeClosure(completionHandler: () -> Void ){

  completionHandlers.append(completionHandler)
    
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapeClosure { self.x = 100 }

        someFunctionWithNonesecapeClosure { x = 200
        }
    }
    
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
instance.doSomething()
completionHandlers.first?()
print(instance.x)
//escape 只在外面调用?

var customInline = ["Ewa","Barry","Daniella"];

func serveCustomer(@autoclosure customProvider: () -> String) {
    print("wwwo\(customProvider())!")
}
serveCustomer(customInline.removeAtIndex(2))

enum CompassPoint: String {
    
    case North, South, East, West
}

let sunsetDirection = CompassPoint.West.rawValue

enum Planet: Int {
    
    case mercury = 1, Venus, Earth, Mars, Neptune
}

let possiblePlanet = Planet(rawValue: 3)

enum ArithmeticExpression {

    case Number(Int)
    
}

class oneClass {
    
}

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
class DataImport {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImport()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")


struct Point {
    
    var x = 0.0, y = 0.0

}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
    
        get {
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.height/2)
            return Point (x: centerX, y: centerY)
        }
        
        set(newCenter) {
            origin.x = newCenter.x - (size.width/2)
            origin.y = newCenter.y - (size.height/2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))

let initialSquareCenter = square.center

square.center = Point(x: 15.0, y: 15.0)

print("square.origin is now at (\(square.origin.x),\(square.origin.y))")

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.height/2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width/2)
            origin.y = newValue.y - (size.height/2)
        }
    }
}

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)

print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue)steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200

stepCounter.totalSteps = 300

struct someStructure {
    static var storedTypeProperty = "Some Value."
    
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProterty: Int  {
        return 4
    }
}

class someoneClass {
    static var storedTypeProterty = "Some Value."
    static var computedTyperoterty: Int {
        set {
            return
        }
        get {
            return 27
        }
       
    }
    class var overrideableComputedTypeproterty: Int {
        return 107
    }
    
}
// SomeEnumeration.computedTypeProterty = 3
var k = someoneClass()

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
  //          if currentLevel > AudioChannel.maxInputLevelForAllChannels {
   //             AudioChannel.maxInputLevelForAllChannels = currentLevel
       //     }
        }
    }
}
func awayFromMe() {
    
}

 AudioChannel.maxInputLevelForAllChannels = 30

var ss = AudioChannel.maxInputLevelForAllChannels


class Counter {
    var count = 0
    func increment(){
        count += 1
    }
    func incrementBy(amm amount: Int, _: Int) {
        count += amount
        self.count += 1
    }
    func reset() {
        
        count = 0
    }
    
}


let counter = Counter()

counter.increment()

counter.incrementBy(amm: 2, 2)

counter.reset()

struct Pointe {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        
        return self.x > x
    }
}


struct Pointee {
    var x = 0.0, y = 0.0
    
     mutating func moveByX(deltaX: Double, y deltaY: Double) {
    
        x += deltaX
        y += deltaY
    }
}

var somrP = Pointee(x: 1.0, y: 1.0)

somrP.moveByX(2, y: 2)


struct PPPP {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = PPPP(x: x + deltaX, y: y + deltaY)
    }
}

var sd = PPPP(x: 3, y: 4)
sd.moveByX(2, y: 1)

enum TriStateSwitch {
    
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = Low
        case .Low:
            self = High
        case .High:
            self = Off
        }
    }
}

var ovenLight = TriStateSwitch.Low

ovenLight.next()

ovenLight.next()

class sasClasss {
    class func someTypeMethod() {
        
    }
}
let cscl = sasClasss()

struct LevelTracker {
    static var highestUnlockedLevel = 1
    
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLelvel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLelvel = level
            return true
        } else {
            return false
        }
        
    }
    
}

class Player {
    var tracker = LevelTracker()
    
    let playerName: String
    
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")

player.completedLevel(1)

print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)

print("six times three is \(threeTimesTable[6])")

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsVaildForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsVaildForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsVaildForRow(row, column: column), "index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

class Vehicle {
    
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise(){
    
    }
}

let someVehicle = Vehicle()

print("\(someVehicle.description)")

class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()

bicycle.hasBasket = true

bicycle.currentSpeed = 15.0

print("Bicycle:\(bicycle.description)")

class Tandem: Bicycle {
    
    var currentNumberOfPassengers = 0

}

let tandem = Tandem()

tandem.hasBasket = true

tandem.currentNumberOfPassengers = 2

tandem.currentSpeed = 22.0

print("Tandem:\(tandem.description)")

class Train: Vehicle {
    final override func makeNoise() {
        print("choo choo")
    }
}

let train = Train()
train.makeNoise()

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()

automatic.currentSpeed = 35.0

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
    
}

var f = Fahrenheit()

print("The default temperature is \(f.temperature)")

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double){
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)

struct sdada {
    var width = 0.0, height = 0.0
}
let adse = sdada(width: 3.0, height: 5.0)

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String,quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name.lowercaseString)"
        output += purchased ? "yes" : "no"
        return output
        
    }
}

var breakfastList = [ShoppingListItem(name: "Beacon")]
breakfastList[0].description

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {return nil}
        self.species = species
    }
}

let someCreature = Animal(species: "")
if let giraffe = someCreature {
    print("an animal was initialized with a species of \(giraffe.species)")
    
}

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "k":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

class Product {
    let name : String!
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
if let bowTie = Product(name: "") {
    print("name is \(bowTie.name)")
}

class CarItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        super.init(name: name)
        if quantity < 1 { return nil }
        self.quantity = quantity
    }
}

class aaClass {
    required init() {
    
    }
}
