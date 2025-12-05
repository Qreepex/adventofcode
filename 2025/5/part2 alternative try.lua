local function loadInput(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("a")
  f:close()
  return content
end

local rangesRaw = loadInput("./input-ranges")

local ranges = {}
local amountRanges = 0

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
  amountRanges = amountRanges + 1
end

-- Algorithm
-- 1. sort ranges by their distance
-- 2. starting at largest, iterate overall ranges and if they overlap, adjust or completely remove them

local sorted = ranges
local function sortByDistance()
  table.sort(sorted, function(a, b)
    return a["end"] - a["start"] > b["end"] - b["start"]
  end)

  for k, v in ipairs(ranges) do
    sorted[k] = v
  end
end

sortByDistance()

local k = 1
while k <= amountRanges do
  local curr = sorted[k]
  local currStart = curr["start"]
  local currEnd = curr["end"]

  local i = k + 1

  while i <= amountRanges do
    local comp = sorted[i]

    local compStart = comp["start"]
    local compEnd = comp["end"]

    print(currStart, currEnd, "---", compStart, compEnd)

    --     x x x x x
    -- |A  |B ... B| A|
    if compStart >= currStart and compEnd <= currEnd then
      -- remove comp range

      print(compStart, compEnd, "is fully included in", currStart, currEnd)

      table.remove(sorted, i)
      amountRanges = amountRanges - 1
      i = i - 2
      sortByDistance()
      break

      --            |B
      -- |A |B ... A|  B|
    elseif compStart >= currStart and compStart <= currEnd then
      -- set compStart to currEnd+1
      compStart = currEnd + 1
      comp["start"] = compStart

      print("start", currStart, currEnd, compStart, compEnd)

      sorted[i] = comp

      --    B|
      -- |B  |A ... B| A|
    elseif compEnd <= currEnd and compEnd >= currStart then
      -- set compEnd to currStart-1

      print("end", currStart, currEnd, compStart, compEnd, currStart - 1)


      compEnd = currStart - 1
      comp["end"] = compEnd


      sorted[i] = comp

      --     x x x x x
      -- |B  |A ... A|  B|
    elseif compEnd >= currEnd and compStart <= currStart then
      table.remove(sorted, k)
      amountRanges = amountRanges - 1
      k = 1
      sortByDistance()

      print(compStart, compEnd, "is bigger than curr", currStart, currEnd)

      break
      -- when remove, decrease amountRanges and i?
    end

    i = i + 1
  end

  k = k + 1
end

local f = assert(io.open("./output", "w+"))
io.output(f)

local total = 0
for i, range in ipairs(sorted) do
  total = total + 1 + (range["end"] - range["start"])

  for j, coll in pairs(range) do
    io.write(coll, " ")
  end
  io.write("\n")
end

print(total)
