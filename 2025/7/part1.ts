import { readFileSync } from "fs"

const input = readFileSync("./input", "utf-8")

const lines = input.split("\r\n")

const startPosition = lines[0]!.indexOf("S", 0)

const beamIndizes = new Set<number>([startPosition])

let splits = 0
for (const line of lines.slice(1)) {
  let found = line.indexOf("^", 0)
  while (found != -1) {
    if (beamIndizes.has(found)) {
      // add splits
      beamIndizes.add(found - 1)
      beamIndizes.add(found + 1)

      // remove hit
      beamIndizes.delete(found)

      splits++
    }

    found = line.indexOf("^", found + 1)
  }
}

console.log(splits)