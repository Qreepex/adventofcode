local function loadInput(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("a")
  f:close()
  return content
end


local rangesRaw = loadInput("./input-ranges")
local idsRaw = loadInput("./input-ids")

local ranges = {}

for rangeRaw in string.gmatch(rangesRaw, "[^\n]+") do
  local start = nil
  local rangeEnd = nil
  for part in string.gmatch(rangeRaw, "[^-]+") do
    if start == nil then
      start = tonumber(part)
    else
      rangeEnd = tonumber(part)
    end
  end
  local range = {}
  range["start"] = start
  range["end"] = rangeEnd
  table.insert(ranges, range)
end

local total = 0
for idRaw in string.gmatch(idsRaw, "[^\n]+") do
  local id = tonumber(idRaw)

  local found = false
  for _, range in pairs(ranges) do
    if id >= range["start"] and id <= range["end"] then
      found = true
      break
    end
  end

  if found then
    print(idRaw)
    total = total + 1
  end
end


print(total)