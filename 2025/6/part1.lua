local function loadInput(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("a")
  f:close()
  return content
end


local lines = loadInput("./input")

local problems = {}

local lineNumber = 1
for line in string.gmatch(lines, "[^\n]+") do
  local problemIndex = 1
  for number in string.gmatch(line, "[^%s]+") do
    if lineNumber == 1 then
      problems[problemIndex] = {}
    end

    if lineNumber == 5 then
      problems[problemIndex][5] = number
    else
      problems[problemIndex][lineNumber] = tonumber(number)
    end

    problemIndex = problemIndex + 1
  end
  lineNumber = lineNumber + 1
end

local total = 0

for _, problem in ipairs(problems) do
  local op = problem[5]
  if op == "+" then
    total = total + problem[1] + problem[2] + problem[3] + problem[4]
  else
    total = total + (problem[1] * problem[2] * problem[3] * problem[4])
  end
end

print(total)