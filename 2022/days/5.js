const { readFileSync } = require("fs");
const moves = readFileSync("./5", "utf-8");

const stacks = new Map();

stacks.set(1, "STHFWR".split(""));
stacks.set(2, "SGDQW".split(""));
stacks.set(3, "BTW".split(""));
stacks.set(4, "DRWTNQZJ".split(""));
stacks.set(5, "FBHGLVTZ".split(""));
stacks.set(6, "LPTCVBSG".split(""));
stacks.set(7, "ZBRTWGP".split(""));
stacks.set(8, "NGMTCJR".split(""));
stacks.set(9, "LGBW".split(""));

const steps = moves.split("\r\n");

// part 1
steps.map(step => {
  return;
  const amount = parseInt(step.split(" ")[1]);
  const from = parseInt(step.split(" ")[3]);
  const to = parseInt(step.split(" ")[5]);

  for (let i = 0; i < amount; i++) {
    const fromStack = stacks.get(from);
    const toStack = stacks.get(to);

    const moving = fromStack.pop();
    toStack.push(moving);

    stacks.set(from, fromStack);
    stacks.set(to, toStack);
  }
});

// console.log([...stacks.values()].map(stack => stack[stack.length - 1]).join(""));

// part 2
steps.map(step => {
  const amount = parseInt(step.split(" ")[1]);
  const from = parseInt(step.split(" ")[3]);
  const to = parseInt(step.split(" ")[5]);

  const fromStack = stacks.get(from);
  const toStack = stacks.get(to);

  const moving = fromStack.splice(fromStack.length - amount, amount);

  for (let i = 0; i < moving.length; i++) toStack.push(moving[i]);

  stacks.set(from, fromStack);
  stacks.set(to, toStack);
});

console.log([...stacks.values()].map(stack => stack[stack.length - 1]).join(""));
