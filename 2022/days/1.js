const { readFileSync } = require("fs");
const input = readFileSync("./1", "utf-8");

const elvesRaw = input.split(`\r\n\r\n`);
const elves = elvesRaw
  .map(elf =>
    elf
      .split("\r\n")
      .map(i => parseInt(i))
      .reduce((a, b) => a + b)
  )
  .sort((x, y) => y - x);

console.log(`Most calories: ${elves[0]}`);
console.log(`Top 3 combined: ${elves[0] + elves[1] + elves[2]}`);
