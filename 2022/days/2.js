const { readFileSync } = require("fs");
const input = readFileSync("./2", "utf-8");

// A + X => Rock
// B + Y => Paper
// C + Z => Scissors

const matches = input.split("\r\n");

let score = 0;

matches.map(match => {
  const [opponentMove, myMove] = match.split(" ");

  let roundScore = 0;

  if (
    // win
    (opponentMove === "A" && myMove === "Y") ||
    (opponentMove === "B" && myMove === "Z") ||
    (opponentMove === "C" && myMove === "X")
  ) {
    roundScore += 6;
  } else if (
    // draw
    (opponentMove === "A" && myMove === "X") ||
    (opponentMove === "B" && myMove === "Y") ||
    (opponentMove === "C" && myMove === "Z")
  ) {
    roundScore += 3;
  }

  if (myMove === "X") {
    roundScore += 1;
  }

  if (myMove === "Y") {
    roundScore += 2;
  }

  if (myMove === "Z") {
    roundScore += 3;
  }

  score += roundScore;
});

console.log(score);

// part two

// x => Lose
// y => Draw (+3)
// z => Win (+6)

// A => Rock (+1)
// B => Paper (+2)
// C => Scissors (+3)

let score2 = 0;

matches.map(match => {
  const [opponentMove, roundResult] = match.split(" ");

  let roundScore = 0;

  if (opponentMove === "A") {
    if (roundResult === "X") {
      roundScore += 3;
    } else if (roundResult === "Y") {
      roundScore += 4;
    } else if (roundResult === "Z") {
      roundScore += 8;
    }
  } else if (opponentMove === "B") {
    if (roundResult === "X") {
      roundScore += 1;
    } else if (roundResult === "Y") {
      roundScore += 5;
    } else if (roundResult === "Z") {
      roundScore += 9;
    }
  } else if (opponentMove === "C") {
    if (roundResult === "X") {
      roundScore += 2;
    } else if (roundResult === "Y") {
      roundScore += 6;
    } else if (roundResult === "Z") {
      roundScore += 7;
    }
  }

  score2 += roundScore;
});

console.log("Part 2: " + score2);
