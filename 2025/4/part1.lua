local function loadInput(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("a")
    f:close()
    return content
end

local raster = loadInput("./input")

local matrix = {}
local row = 1
for line in string.gmatch(raster, "[^\n]+") do
  matrix[row] = {}
  for i = 1, string.len(line) do
    matrix[row][i] = string.sub(line, i, i)
  end
  row = row + 1
end

local function getSurounding(row, col)
  local sur = {}
  if not row == 1 then
  end
end

local function functionGetRow(row, start)