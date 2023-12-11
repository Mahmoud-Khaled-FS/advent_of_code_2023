import java.io.*
import kotlin.collections.mutableListOf
import kotlin.collections.mutableMapOf

typealias Dir = Pair<Int, Int>

val pipes = mapOf(
  "|" to Pair(1 ,0),
  "-" to Pair(0, 1),
  "F" to Pair(1, 1),
  "7" to Pair(1, 1),
  "J" to Pair(1, 1),
  "L" to Pair(1, 1),
)

fun main(args: Array<String>) {
  if (args.size < 1) {
    error("ERROR: Invalid file path")
  }
  val lines = File(args[0]).readLines()
  var start = Dir(0,0)
  for ((i, line) in lines.withIndex()) {
    val index = line.indexOf('S')
    if (index != -1) {
      start = Dir(i, index)
      break;
    }
  }
  val result = stepsToFarthest(start, lines)
  println("Result Part 1 -> $result")
}

fun stepsToFarthest(start: Dir, lines: List<String>): Int {
  var queue = mutableListOf(start)
  var seen = mutableListOf(start)
  while (queue.size > 0) {
    val curr = queue.removeAt(queue.size - 1)
    val pipe = lines[curr.first][curr.second]
    val maxRows = lines.size - 1
    val maxColumns = lines[0].length - 1
    val r = curr.first
    val c = curr.second
    if (r > 0 && pipe in "S|JL" && lines[r -1][c] in "|7F" && !(Dir(r - 1, c) in seen)) {
      seen.add(Dir(r - 1, c))
      queue.add(Dir(r - 1, c))
    }
    if(r < maxRows && pipe in "S|7F" && lines[r + 1][c] in "|JL" && !(Dir(r + 1, c) in seen)) {
      seen.add(Dir(r + 1, c))
      queue.add(Dir(r + 1, c))
    }
    if (c > 0 &&  pipe in "S-J7" && lines[r][c - 1] in "-LF" && !(Dir(r, c - 1) in seen)){
      seen.add(Dir(r, c - 1))
      queue.add(Dir(r, c - 1))
    }
    if (c < maxColumns && pipe in "S-LF" && lines[r][c + 1] in "-J7" && !(Dir(r, c + 1) in seen)){
      seen.add(Dir(r, c + 1))
      queue.add(Dir(r, c + 1))
    }
  }
  return seen.size / 2
}