class Day16 {
  static List<(int,int)> Points = [];
  static void Main(string[] args){
    if (args.Length == 0) {
      Console.Error.WriteLine("ERROR: Invalid file path");
      Environment.Exit(1);
    }
    var filePath = args[0];
    Console.WriteLine(filePath);
    var lines = File.ReadAllLines(filePath);
    SolveFile(lines);
    Console.WriteLine($"Part 1 -> {Points.Count}");
  }
  static void SolveFile(string[] arr) {
    var dir = "r";
    var pos = (0,0);
    LightPath(arr, pos, dir);
  }
  static void LightPath(string[] arr, (int, int) pos, string dir) {
    var newPos = pos;
    while (true){
      if(pos.Item2 >= arr[0].Length || pos.Item2 < 0 || pos.Item1 >= arr.Length || pos.Item1 < 0){
        break;
      }
      switch(arr[pos.Item1][pos.Item2]) {
        case '|':
          if (Points.Contains(pos)){
            return ;
          }
          if (dir == "r" || dir == "l"){
            Points.Add(pos);
            dir = "b";
            LightPath(arr, (pos.Item1 - 1, pos.Item2), "t");
          }
          break;
        case '-':
          if (Points.Contains(pos)){
            return;
          }
          if (dir == "t" || dir == "b"){
            Points.Add(pos);
            dir = "r";
              LightPath(arr, (pos.Item1, pos.Item2 - 1), "l");
          }
          break;
        case '\\':
          if(dir == "r") {
            dir = "b";
          }else if(dir == "l") {
            dir = "t";
          }else if(dir == "t") {
            dir = "l";
          }else if(dir == "b") {
            dir = "r";
          }
          break;
        case '/':
          if(dir == "r") {
            dir = "t";
          }else if(dir == "l") {
            dir = "b";
          }else if(dir == "t") {
            dir = "r";
          }else if(dir == "b") {
            dir = "l";
          }
          break;
      }
      if (dir == "r"){
        newPos = (pos.Item1, pos.Item2 + 1);
      }else if(dir == "l"){
        newPos = (pos.Item1, pos.Item2 - 1);
      }else if(dir == "t"){
        newPos = (pos.Item1 - 1, pos.Item2);
      }else if(dir == "b"){
        newPos = (pos.Item1 + 1, pos.Item2);
      }
      if(!Points.Contains(pos)){
        Points.Add(pos);
      }
      pos = newPos;
    }
    
    return;
  }
}