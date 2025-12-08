import { readFileSync, writeFileSync } from "fs"

const input = readFileSync("./input", "utf-8")

const lines = input.split("\r\n")

const grid = lines.map(line => line.split(""))

const rows = grid.length;
const cols = grid[0]!.length;

const startPosition = lines[0]!.indexOf("S", 0)


const memo = new Map<string, number>();

function calcDown(rowIndex: number, colIndex: number): number {
  if (rowIndex >= rows || colIndex >= cols)  {
    console.log("a")
    return 0
  }

  const key = `${rowIndex},${colIndex}`;
  if (memo.has(key)) return memo.get(key)!;

  let count = 0;

  const cell = grid[rowIndex]![colIndex];
  if (cell === ".") {
    count += calcDown(rowIndex + 1, colIndex);
  } else if (cell === "^") {
    count += calcDown(rowIndex+1, colIndex-1)
    count += calcDown(rowIndex+1, colIndex+1)
  }

  memo.set(key, count)

  return count
}


const total = calcDown(1, startPosition)

console.log(total)

// for (let line of lines.slice(1)) {
//   let found = line.indexOf("^", 0)
//   let localOptions = 0
//   while (found != -1) {
//     if (beamIndizes.has(found)) {
//       // add splits
//       beamIndizes.add(found - 1)
//       beamIndizes.add(found + 1)

//       // remove hit
//       beamIndizes.delete(found)

//       splits++
//       localOptions++
//     }

//     found = line.indexOf("^", found + 1)
//   }

//   beamIndizes.values().forEach(x => {
//     line = line.substring(0, x) + "|" + line.substring(x+1)
//   })

//   options = localOptions + options


//   out += line + " " + localOptions  + " " + options + "\n"

// }

// console.log(splits)
// console.log(options)

// writeFileSync("./output", out)

