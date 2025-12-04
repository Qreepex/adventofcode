local function loadInput(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("a")
    f:close()
    return content
end

local banks = loadInput("./input")

local function getNumberAtIndex(str, index)
  local iStr = string.sub(str, index, index)

  return tonumber(iStr)
end

local function findGreatestIndex(str)
  local greatest = getNumberAtIndex(str, 1)
  local indexOfGreatest = 1
  local len = string.len(str)
  for i = 2, len do
    local comp = getNumberAtIndex(str, i)
    if comp > greatest then
      greatest = comp
      indexOfGreatest = i
    end
  end

  return indexOfGreatest
end

local maxJoltage = 0
for bank in string.gmatch(banks, "[^\n]+") do
  local withoutLast = string.sub(bank, 1, string.len(bank)-1)

  local greatest = findGreatestIndex(withoutLast)

  local right = string.sub(bank, greatest+1, string.len(bank))
  local secondGreatest = findGreatestIndex(right)

  local first = getNumberAtIndex(bank, greatest)
  local second = getNumberAtIndex(right, secondGreatest)

  local total = first * 10 + second
  maxJoltage = maxJoltage + total
end

print(maxJoltage)