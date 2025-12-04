local function loadInput(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("a")
  f:close()
  return content
end

local raster = loadInput("./input")

local matrix = {}


local function getColl(rowIndex, collIndex)
  if rowIndex < 1 then
    return 0
  end

  local row = matrix[rowIndex]

  if row == nil then
    return 0
  end

  if collIndex < 1 then
    return 0
  end

  local field = row[collIndex]
  if field == nil then
    return 0
  end

  if field == "@" then
    return 1
  end

  return 0
end

local function getRow(row, middleColl, isMiddle)
  local surr = 0
  if isMiddle then
    surr = getColl(row, middleColl - 1) + getColl(row, middleColl + 1)
  else
    surr = getColl(row, middleColl - 1) + getColl(row, middleColl) + getColl(row, middleColl + 1)
  end

  return surr
end


local function getSurrounding(row, col)
  local surr = getRow(row - 1, col, false) + getRow(row, col, true) + getRow(row + 1, col, false)

  return surr
end


local rowIdx = 1
for line in string.gmatch(raster, "[^\n]+") do
  matrix[rowIdx] = {}
  for i = 1, string.len(line) do
    matrix[rowIdx][i] = string.sub(line, i, i)
  end
  rowIdx = rowIdx + 1
end

local total = 0
local i = 1
while i < 1000 do
  local row = matrix[i]
  if row == nil then
    break
  end

  for j, coll in pairs(row) do
    if coll == "@" then
      local surroundedBy = getSurrounding(i, j)
      if surroundedBy < 4 then
        total = total + 1
        matrix[i][j] = "."
        i = math.max(0, i - 3)
        break
      end
    end
  end

  i = i + 1
end

print(total)

local f = assert(io.open("./output", "w+"))
io.output(f)

for i, row in pairs(matrix) do
  for j, coll in pairs(row) do
    io.write(coll)
  end
  io.write("\n")
end
