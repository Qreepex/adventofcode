local function loadInput(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("a")
  f:close()
  return content
end

local linesRaw = loadInput("./input")

local lineNumber = 1
local lines = {}
local totalLines = 0
for line in string.gmatch(linesRaw, "[^\n]+") do
  lines[lineNumber] = line
  lineNumber = lineNumber + 1
  totalLines = totalLines + 1
end

local fiveIndex = 2
local lastProblemIndex = 1

local total = 0

local problemLine = lines[totalLines]
while fiveIndex <= string.len(problemLine) do
  local curr = string.sub(problemLine, fiveIndex, fiveIndex)

  if curr ~= " " then
    local problemLength = fiveIndex - 1 - lastProblemIndex
    local op = string.sub(problemLine, lastProblemIndex, lastProblemIndex)

    local numbersInProblem = {}

    for i = 1, problemLength do
      for l = 1, totalLines-1 do
        local charIndex = lastProblemIndex + i - 1
        local n = string.sub(lines[l], charIndex, charIndex)


        if n ~= " " then
          local pres = numbersInProblem[i]
          if pres == nil then
            numbersInProblem[i] = n
          else
            numbersInProblem[i] = pres .. n
          end
        end
      end
    end

    local calc = 1
    for _, v in ipairs(numbersInProblem) do
      if op == "+" then
        calc = calc + v
      else
        calc = calc * v
      end
    end

    if op == "+" then
      calc = calc - 1
    end

    total = total + calc

    lastProblemIndex = fiveIndex

    print(op, table.unpack(numbersInProblem))
  end

  fiveIndex = fiveIndex + 1
end

print(total)
