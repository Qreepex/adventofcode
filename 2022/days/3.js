const { readFileSync } = require("fs");
const input = readFileSync("./3", "utf-8");

const rucksacks = input.split("\r\n");

// part 1
const commons = [];

rucksacks.map(rucksack => {
  const items = rucksack.split("");
  const compartment1 = items.slice(0, Math.ceil(items.length / 2));
  const compartment2 = items.slice(Math.ceil(items.length / 2));

  const common = compartment1.filter(item => compartment2.includes(item))[0];

  commons.push(codeForChar(common));
});

console.log("All commons combined: " + commons.reduce((a, b) => a + b));

// part 2
const groups = groupsBy3(rucksacks);
const badges = [];

groups.map(group => {
  const groupBadge = group[0].split("").filter(item => group[1].includes(item) && group[2].includes(item))[0];
  badges.push(groupBadge);
});

console.log("All badges combined: " + badges.map(x => codeForChar(x)).reduce((a, b) => a + b));

// helpers
function codeForChar(char) {
  return char === char.toUpperCase() ? char.codePointAt(0) - 38 : char.codePointAt(0) - 96;
}

function groupsBy3(data) {
  let _groups = [];
  for (let i = 0; i < data.length; i += 3) _groups.push(data.slice(i, i + 3));
  return _groups;
}
