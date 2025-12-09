const { readFileSync } = require("fs");
const input = readFileSync("./4", "utf-8");

const pairs = input.split(`\r\n`);

// x x 1 1 x x
// x 1 1 1 1 x
let r = 0;

pairs.map(pair => {
  const [elve1, elve2] = pair.split(`,`);

  const [start1, end1] = elve1.split(`-`).map(Number);
  const [start2, end2] = elve2.split(`-`).map(Number);

  if ((start2 <= start1 && end2 >= end1) || (start1 <= start2 && end1 >= end2)) {
    r++;
  }
});

console.log(r);

// part 2
let x = 0;

pairs.map(pair => {
  const [elve1, elve2] = pair.split(`,`);

  const [start1, end1] = elve1.split(`-`).map(Number);
  const [start2, end2] = elve2.split(`-`).map(Number);

  const numbers1 = [];
  for (let i = start1; i <= end1; i++) {
    numbers1.push(i);
  }

  const numbers2 = [];
  for (let i = start2; i <= end2; i++) {
    numbers2.push(i);
  }

  const intersection = numbers1.filter(x => numbers2.includes(x));
  if (intersection.length > 0) {
    x++;
  }
});

console.log(x);
