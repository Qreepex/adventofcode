local function loadInput(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("a")
    f:close()
    return content
end

local rawRanges = loadInput("./input")

print(rawRanges)

local invalidSum = 0

local function isInvalidID(number)
  local len = string.len(number)

  if len % 2 == 1 then
    return false
  end

  local first = string.sub(number, 1, len/2)
  local second = string.sub(number, len/2+1, len)

  local match = first == second

  if match then
    print("MATCH", number, first, second)
  end

  return match
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
