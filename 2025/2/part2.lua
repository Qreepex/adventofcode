local function loadInput(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("a")
    f:close()
    return content
end

local rawRanges = loadInput("./input")

local invalidSum = 0

local function isInvalidID(number)
  local len = string.len(number)

  for i = 2, len do
    if len % i == 0 then
      -- check for i pairs
      local pairLength = len/i
      local prevPair = string.sub(number, 1, pairLength)
      local matches = 1
      for j = 1, i do
        local startNextPair = pairLength*j+1
        local endNextPair = pairLength*j+pairLength

        local nextPair = string.sub(number, startNextPair, endNextPair)

        if prevPair == nextPair then
          matches = matches + 1
        end
      end

      if matches == i then
        return true
      end
    end
  end

  return false
end

isInvalidID(12121)

for line in string.gmatch(rawRanges, "[^,]+") do
  local sepIndex = string.find(line, "-")
  local startRaw = string.sub(line, 1, sepIndex-1)
  local rangeEndRaw = string.sub(line, sepIndex + 1, string.len(line))

  local rangeStart = tonumber(startRaw)
  local rangeEnd = tonumber(rangeEndRaw)

  for i = rangeStart, rangeEnd do
    if isInvalidID(i) then
      invalidSum = invalidSum + i
    end
  end
end

print(invalidSum)