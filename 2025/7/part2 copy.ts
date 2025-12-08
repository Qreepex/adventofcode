import { readFileSync } from "fs"

const input = readFileSync("./input", "utf-8")

const grid = input.split("\r\n")

const rows = grid.length;
const cols = grid[0]!.length;
const paths: number[][] = Array.from({ length: rows }, () => Array(cols).fill(0));

const startCol = grid[0]!.indexOf("S");
paths[0]![startCol] = 1;

for (let row = 1; row < rows; row++) {
  for (let col = 0; col < cols; col++) {

    // wie oft das feld ein drüber getroffen wird, wenn gar nicht, dann einfach nächstes feld checken
    const ways = paths[row - 1]![col];
    if (!ways) continue;

    // wenn zeile ein ^ ist, li/re weiter
    if (grid[row]![col] === "^") {
      // die wege die bis hierhin geführt haben auf das feld links addieren
      paths[row]![col - 1]! += ways;

      // die wege die bis hierhin geführt haben auf das feld rechts addieren
      paths[row]![col + 1]! += ways;
    } else {
      // einfach weiter gehen für die anzahl der wege
      paths[row]![col]! += ways;
    }
  }
}

const total = paths[rows - 1]!.reduce((a, b) => a + b, 0);

console.log(total)

