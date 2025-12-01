local function loadInput(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("a")
  f:close()
  return content
end

local rotationsString = loadInput("./input")

local start = 50
local max = 100

local totalZero = 0

local function addRotation(offset)
  local passedZero = 0
  local current = start

  -- mit uhrzeigen sinn drehen
  if offset > 0 then
    -- von 1 bis offset hochzählen
    for i = 1, offset do
      current = current + 1
      if current >= max then
        current = 0
      end
      if current == 0 then
        passedZero = passedZero + 1
      end
    end
    -- gegen uhrzeiger sinn drehen
  elseif offset < 0 then
    -- von 1 bis offset hochzählen
    for i = 1, math.abs(offset) do
      current = current - 1
      if current < 0 then
        current = max - 1
      end
      if current == 0 then
        passedZero = passedZero + 1
      end
    end
  end

  if passedZero > 0 then
    print("Adding", offset, "to", start, "=", current, "| Passed zero", passedZero, "times")
  end

  totalZero = totalZero + passedZero
  start = current

  return start
end

local rotations = {}
for line in string.gmatch(rotationsString, "[^\n]+") do
  table.insert(rotations, line)
end

for _, rotation in ipairs(rotations) do
  local prefix = string.sub(rotation, 1, 1)
  local len = string.len(rotation)
  local strOffset = string.sub(rotation, 2, len)
  local offset = tonumber(strOffset)

  if prefix == "L" then
    addRotation(0 - offset)
  elseif prefix == "R" then
    addRotation(offset)
  end
end

print("Total Zero: ", totalZero)
