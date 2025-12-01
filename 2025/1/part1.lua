local function loadInput(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("a")
    f:close()
    return content
end

local rotationsString = loadInput("./input")

Start = 50
local max = 100

local leftZero = 0

local function addRotation(offset)
  local new = Start + offset
  Start = new % max
  return Start
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
    addRotation(0-offset)
  elseif prefix == "R" then
    addRotation(offset)
  end

  if Start == 0 then
    leftZero = leftZero + 1
  end
end

print("Left Zero: ", leftZero)