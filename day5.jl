function main()
  if length(ARGS) < 1 
    error("Invalid file path")
  end
  
  file = open(ARGS[1], "r")

  seeds = get_seeds_range(file)

  source_to_dist_range(file,seeds)

  res = source_to_dist(seeds, file)
  res = source_to_dist(res, file)
  res = source_to_dist(res, file)
  res = source_to_dist(res, file)
  res = source_to_dist(res, file)
  res = source_to_dist(res, file)
  res = source_to_dist(res, file)

  min_loc = minimum(res)
  println("Min Location = $min_loc")
  
  close(file)
end 

function get_seeds(file)
  seedsLine = readline(file)
  seeds = split(seedsLine, " ")
  readline(file)
  return map(x-> parse(Int,x) , seeds[2:end])
end

function get_seeds_range(file)
  seedsLine = readline(file)
  seeds = split(seedsLine, " ")[2:end]
  readline(file)
  seeds_result = []
  for i in range(1, stop=length(seeds), step=2)
    start = parse(Int, seeds[i])
    finish = start + parse(Int, seeds[i+1]) - 1
    push!(seeds_result, [start, finish])
  end
  return seeds_result
end


function source_to_dist(source, file)
  readline(file)

  line = readline(file)
  result = copy(source)
  while true
    cord = split(line, " ")
    if length(cord) != 3
      break
    end
    for (index, seed) in enumerate(source) 
      new_value = update_dist(seed, parse(Int,cord[1]), parse(Int,cord[2]), parse(Int,cord[3]))
      if new_value != source[index]
        result[index] = new_value
      end
    end
    line = readline(file)
  end
  return result
end

function update_dist(source, destination_start, source_start, length)
  de = destination_start + length - 1
  se = source_start + length - 1
  new_source = source
  if source in range(source_start, source_start + length - 1) 
    steps = source - source_start
    new_source = destination_start + steps
  end
  return new_source
end

function source_to_dist_range(file, source)
  readline(file)
  line = readline(file)
  result = []

  while true
    cord = split(line, " ")
    if length(cord) != 3
      break
    end
    for (index, seed) in enumerate(source) 
      start = parse(Int, cord[1])
      end_c = start + parse(Int, cord[3])
      if (start < seed[1] && end_c < seed[1]) || start > seed[2]
        push!(result, seed)
      else
        s = max(start, seed[1])
        e = min(end_c, seed[2])
        new_range = [s,e]
      end 
    end
    line = readline(file)
  end
  return result
end

main()
