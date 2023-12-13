import 'dart:io';
import 'dart:math';

typedef Pic = List<String>;
typedef Position = (int, int);
typedef ExpandedLines = (List<int>, List<int>);

void main(List<String> args) async {
  if (args.length < 1) {
    throw new ArgumentError("Invalid File Path");
  }
  String filePath = args[0];
  File file = new File(filePath);
  List<String> lines = await file.readAsLines();

  ExpandedLines exp = getExpandedIndex(lines);
  List<Position> galaxies = parse(lines);

  print("Result Part 1 -> ${shortestPathWithExpanded(galaxies, exp, 1)}");
  print("Result Part 2 -> ${shortestPathWithExpanded(galaxies, exp, 999999)}");
}

ExpandedLines getExpandedIndex(List<String> lines) {
  List<int> expandedRows = [];
  List<int> expandedColumns = [];
  for (final (index, line) in lines.indexed) {
    if (!line.contains("#")) {
      expandedRows.add(index);
    }
  }
  for (int c = 0; c < lines[0].length; c++) {
    bool insert = true;
    for (int r = 0; r < lines.length; r++) {
      if (lines[r][c] == "#") {
        insert = false;
        break;
      }
    }
    if (insert) {
      expandedColumns.add(c);
    }
  }
  return (expandedRows, expandedColumns);
}

List<Position> parse(Pic pic) {
  List<Position> galaxies = [];
  for (final (row, line) in pic.indexed) {
    for (int col = 0; col < line.length; col++) {
      if (line[col] == "#") {
        galaxies.add((row, col));
      }
    }
  }
  return galaxies;
}

int shortestPathWithExpanded(
    List<Position> galaxies, ExpandedLines exp, int time) {
  int total = 0;
  for (int i = 0; i < galaxies.length; i++) {
    for (int j = i + 1; j < galaxies.length; j++) {
      int shortPath = (galaxies[i].$1 - galaxies[j].$1).abs() +
          (galaxies[i].$2 - galaxies[j].$2).abs();
      for (int num in exp.$1) {
        if (num > min(galaxies[i].$1, galaxies[j].$1) &&
            num < max(galaxies[i].$1, galaxies[j].$1)) {
          shortPath += time;
        }
      }
      for (int num in exp.$2) {
        if (num > min(galaxies[i].$2, galaxies[j].$2) &&
            num < max(galaxies[i].$2, galaxies[j].$2)) {
          shortPath += time;
        }
      }
      total += shortPath;
    }
  }
  return total;
}
