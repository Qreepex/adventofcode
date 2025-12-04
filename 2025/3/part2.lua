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

local function removeIndex(str, index)
  local len = string.len(str)

  if index == 1 then
    return string.sub(str, 2, len)
  elseif index == len then
    return string.sub(str, 1, len - 1)
  end

  local left = string.sub(str, 1, index - 1)
  local right = string.sub(str, index + 1, len)

  return left .. right
end


local function removeLowestNumber(str)
  local lowest = getNumberAtIndex(str, 1)
  local lowestIndex = 1
  local len = string.len(str)
  for i = 2, len do
    local comp = getNumberAtIndex(str, i)
    if comp < lowest then
      lowest = comp
      lowestIndex = i
    end
  end

  print(str, lowest)

  return removeIndex(str, lowestIndex)
end


-- Algorithm 1: not working
-- 1. find the 88 smallest numbers in a bank
-- 2. from small to bigger, start ruling out the numbers from start to end

-- local totalJoltage = 0
-- for bank in string.gmatch(banks, "[^\n]+") do
--   while string.len(bank) > 12 do
--     bank = removeLowestNumber(bank)
--   end

--   print(bank)

--   totalJoltage = totalJoltage + tonumber(bank)
-- end

-- Algorithm 2:
-- from left to right, if next number is larger than current, remove current number until str has length 2
-- if that wasnt successfull, start at the end and remove the last number where the number before is greater
-- if all numbers are equal, just remove one

local totalJoltage2 = 0
local totalIterations = 0
for bank in string.gmatch(banks, "[^\n]+") do
  print(bank)

  totalIterations = totalIterations + 1

  while string.len(bank) > 12 do
    totalIterations = totalIterations + 1

    local con = true
    local con2 = true

    for i = 2, string.len(bank), 1 do
      totalIterations = totalIterations + 1

      local curr = getNumberAtIndex(bank, i - 1)
      local next = getNumberAtIndex(bank, i)

      print(bank, string.len(bank), "i", i, "curr", curr, "next", next)

      if curr < next then
        totalIterations = totalIterations + 1

        bank = removeIndex(bank, i - 1)
        con = false
        con2 = false
        break
      end
    end

    if con then
      for i = string.len(bank), 2, -1 do
        totalIterations = totalIterations + 1

        local curr = getNumberAtIndex(bank, i)
        local prev = getNumberAtIndex(bank, i - 1)

        print(bank, string.len(bank), i, "curr", curr, "prev", prev)

        if prev > curr then
          bank = removeIndex(bank, i)
          con2 = false
          break
        end
      end
    end

    if con2 then
      bank = removeIndex(bank, 1)
    end
  end

  print("done", bank)

  totalJoltage2 = totalJoltage2 + tonumber(bank)
end

print(totalJoltage2)
print(totalIterations)