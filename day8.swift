import Darwin
import FileProvider


func getFilePath() -> String {
  if (CommandLine.argc < 2) {
    print("ERROR: Invalid file path")
    exit(1)
  }
  return CommandLine.arguments[1]
}

struct Point {
  let left: String
  let right: String
}

func parseInput(lines:[String.SubSequence]) -> [String:Point] {
  var map:[String:Point] = [:]
  for line in lines {
    let input = line.split(separator: "=")
    let mapName = String(input[0]).trimmingCharacters(in: .whitespacesAndNewlines)
    let dirs = String(input[1]).split(separator: ",")
    let leftDir = dirs[0].trimmingCharacters(in: .whitespacesAndNewlines)
    let rightDir = dirs[1].trimmingCharacters(in: .whitespacesAndNewlines)
    let point = Point(left: String(leftDir.dropFirst()), right: String(rightDir.dropLast()))
    map[mapName] = point
  }
  return map
}

func part1() -> Int {

  let filePath = getFilePath()
  let content: String = try! String(contentsOfFile: filePath)
  let lines = content.split(separator: "\n")
  let maps = Array(lines[1..<lines.count])
  let dir = lines[0]
  let map = parseInput(lines: maps)
  
  var result = 0
  var dirIndex = 0
  var currentPoint = "AAA"
  while currentPoint != "ZZZ" {
    result+=1
    if dir[dir.index(dir.startIndex, offsetBy: dirIndex)] == "R" { 
      currentPoint = map[currentPoint]!.right
    } else {
      currentPoint = map[currentPoint]!.left
    }

    dirIndex += 1
    if (dirIndex == dir.count) {
      dirIndex = 0
    }
  }
  return result
}

func part2() -> Int {

  let filePath = getFilePath()
  let content: String = try! String(contentsOfFile: filePath)
  let lines = content.split(separator: "\n")
  let maps = Array(lines[1..<lines.count])
  let dir = lines[0]
  let map = parseInput(lines: maps)
  
  var currentPoints:[String] = []
  for (key,_) in map {
    if (key.last == "A") {
      currentPoints.append(key)
    }
  }

  var dirIndex = 0
  var results:[Int] = []
  for currentPoint in currentPoints {
    var curr = currentPoint
    var result = 0
    while curr.last != "Z" {
      result+=1
      if dir[dir.index(dir.startIndex, offsetBy: dirIndex)] == "R" { 
        curr = map[curr]!.right
      } else {
        curr = map[curr]!.left
      }

      dirIndex += 1
      if (dirIndex == dir.count) {
        dirIndex = 0
      }
    } 
    results.append(result)
  }

  return results.reduce(1) { findLCM(n1:$0, n2:$1) }
}

func findGCD(_ num1: Int, _ num2: Int) -> Int {
   var x = 0
   var y: Int = max(num1, num2)
   var z: Int = min(num1, num2)
   while z != 0 {
      x = y
      y = z
      z = x % y
   }
   return y
}

func findLCM(n1: Int, n2: Int)-> Int {
   return (n1 * n2/findGCD(n1, n2))
}

print("Part 1 -> \(part1())")
print("Part 2 -> \(part2())")
