import std/os
import std/strutils

proc zipp(l: seq[string]): seq[string] =
  var result: seq[string] = @[]
  for i in countup(0, l.len() - 1):
    var s = ""
    for ch in l:
      s &= ch[i]
    result.add(s)
    s = ""
  return result

if paramCount() == 0:
  echo "ERROR: Invalid file path"
  quit(1)

let filePath = paramStr(1)

let content = readFile(filePath)

var lines = splitLines(content)

var columns = lines.zipp

for index,col in columns:
  var newCol = ""
  var subIndex = 0
  for i in countup(0, col.len - 1):
    if col[i] == 'O':
      newCol = newCol.substr(0, subIndex - 1) & "O" & newCol.substr(subIndex)
    elif col[i] == '#':
      subIndex = i + 1
      newCol &= col[i]
    else:
      newCol &= col[i]

  columns[index] = newCol

var part1Result = 0
for col in columns:
  for i, ch in col:
    let v = col.len - i
    if ch != 'O': continue
    part1Result += v  

echo "Part 1 -> " & part1Result.intToStr()
