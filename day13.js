const fs = require('fs');

if (process.argv.length > 3) {
  console.error('ERROR: Invalid file path');
  process.exit(1);
}

const filePath = process.argv[2];

const content = fs.readFileSync(filePath).toString().split('\r\n');

const patterns = parsePatterns(content);
let resultPart1 = 0;
let resultPart2 = 0;
for (const pattern of patterns) {
  let p = solvePattern(pattern) * 100;
  if (p === 0) {
    p = solvePattern(flipPattern(pattern));
  }
  resultPart1 += p;

  let p2 = part2FixOne(pattern) * 100;
  if (p2 === 0) {
    p2 = part2FixOne(flipPattern(pattern));
  }
  resultPart2 += p2;
}
console.log(`Part 1 -> ${resultPart1}`);
console.log(`Part 2 -> ${resultPart2}`);

function parsePatterns(content) {
  const result = [];
  let index = 0;
  for (const line of content) {
    if (line == '') {
      index++;
      continue;
    }
    if (!result[index]) {
      result.push([]);
    }
    result[index].push(line);
  }
  return result;
}

function solvePattern(pattern) {
  for (let i = 0; i < pattern.length - 1; i++) {
    if (pattern[i] === pattern[i + 1]) {
      if (startPattern(pattern, i)) {
        return i + 1;
      }
    }
  }
  return 0;
}

function startPattern(pattern, index) {
  for (let i = index; i >= 0; i--) {
    const opsIndex = index + (index - i) + 1;
    if (opsIndex >= pattern.length) {
      return true;
    }
    if (pattern[i] !== pattern[opsIndex]) {
      return false;
    }
  }
  return true;
}

function flipPattern(pattern) {
  const newPattern = new Array(pattern[0].length);
  for (index in pattern) {
    for (let newIndex = 0; newIndex < newPattern.length; newIndex++) {
      if (!newPattern[newIndex]) newPattern[newIndex] = '';
      newPattern[newIndex] += pattern[index][newIndex];
    }
  }
  return newPattern;
}

function part2FixOne(pattern) {
  for (const pI in pattern) {
    for (const cI in pattern[pI]) {
      const newPattern = [...pattern];
      if (pattern[pI][cI] === '.') {
        newPattern[pI] = pattern[pI].slice(0, pI) + '#' + pattern[pI].slice(pI + 1);
      } else {
        newPattern[pI] = pattern[pI].slice(0, pI) + '.' + pattern[pI].slice(pI + 1);
      }
      const result = solvePattern(newPattern);
      if (result !== 0) {
        return result;
      }
    }
  }
  return 0;
}
