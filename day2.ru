def get_file()
  if ARGV.count < 1 
    print("ERROR: No input file provide\n")
    exit(1)
  end
  file_path = ARGV[0]  
  f = File.open(file_path)
  return f
end

def part1()
  max_cubes = {"red"=> 12, "green" => 13, "blue" => 14}
  f = get_file()
  result = 0
  f.readlines().each do |line|
    tokens = line.split(" ")
    game_id = tokens[1][0..tokens[1].length - 2].to_i
    index = 2 
    is_valid = true
    while index < tokens.count
      number = tokens[index].to_i
      name = tokens[index + 1]
      if index + 1 != tokens.count - 1 
        name = name[0..tokens[index + 1].length - 2]
      end
      if max_cubes[name] < number
        is_valid = false
        break
      end
      index += 2
    end
    if is_valid 
      result += game_id
    end
  end
  
  f.close
  puts "Result Part1: ", result 
end

def part2()
  f = get_file()
  result = 0
  f.readlines().each do |line|
    tokens = line.split(" ")
    index = 2 
    maxRed = 0
    maxBlue = 0
    maxGreen = 0
    while index < tokens.count
      number = tokens[index].to_i
      name = tokens[index + 1]
      if index + 1 != tokens.count - 1 
        name = name[0..tokens[index + 1].length - 2]
      end
      if name == "red"
        maxRed = [number, maxRed].max
      elsif name == "blue"
        maxBlue = [number, maxBlue].max
      elsif name == "green"
      maxGreen = [number, maxGreen].max
      end
      index += 2
    end
    result += maxRed * maxBlue * maxGreen
  end
  
  f.close
  puts "Result Part2: ", result 
end

part2()
