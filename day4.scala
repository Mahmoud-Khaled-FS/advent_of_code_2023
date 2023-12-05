import scala.compiletime.ops.string
import scala.util.boundary.Break
import scala.util.control.Breaks._
object Main {
  private var result = 0 
  private var cards:List[Int] = List()
  private var index = 0

  private val Points = false

  def main(args: Array[String]): Unit = {
    if args.length < 1 then
      println("Invalid file path")
      sys.exit(1)
    end if
    val filePath = args(0)
    println(filePath)
    val bufferSource = io.Source.fromFile(filePath)
    var lines = bufferSource.getLines()

    if (Points) {
      lines.foreach(part1_points)
    }else {
      val linesList = lines.toList
      cards = List.fill(linesList.length)(1)
      linesList.foreach(part2_scratchcard)
      println(cards)
      result = cards.reduce(_+_)
    }
    
    println(s"Result: $result")
  }

  private def part1_points(line: String) = {
    val game = line.split(":")(1).split('|')
    val winingNumbers = game(0).trim().split(" ").filter(_ != "")
    val elfNumbers = game(1).trim().split(" ").filter(_ != "")
    // println(winingNumbers.toList)
    // println(elfNumbers.toList)
    var gameResult = 0
    for num <- elfNumbers yield {
      if (winingNumbers.indexOf(num) != -1) {
        if (gameResult >= 1) {
          gameResult *= 2
        }else {
          gameResult = 1
        }
      }
    }
    // println((result, gameResult))
    result += gameResult
  }

  private def part2_scratchcard(line:String) = {
    val game = line.split(":")(1).split('|')
    val winingNumbers = game(0).trim().split(" ").filter(_ != "")
    val elfNumbers = game(1).trim().split(" ").filter(_ != "")
    var gameResult = 0
    for num <- elfNumbers yield {
      if (winingNumbers.indexOf(num) != -1) {
          gameResult += 1
      }
    }
    if (gameResult >= 1) {
      breakable{
        for (nextIndex <- (index + 1) to (index + gameResult)) {
          if (nextIndex >= cards.length) {
            break
          }
          cards = cards.updated(nextIndex, cards(nextIndex) + cards(index))
        }
      }
    }
    println(s"Index $index, result: $gameResult")
    index+=1
  }
}