local function loadInput(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("a")
  f:close()
  return content
end

local rangesRaw = loadInput("./input-ranges")

local ranges = {}

local function addRange(start, rangeEnd)
  if rangeEnd < start then
    return
  end

  local add = true
  for k, comp in ipairs(ranges) do
    local compStart = comp["start"]
    local compEnd = comp["end"]

    -- comp start früher
    if compStart <= start then
      -- comp endet in/nach range
      if compEnd >= start then
        -- comp endet später, range ist komplett in comp
        if compEnd >= rangeEnd then
          add = false
          break

          -- comp endet früher
        else
          start = compEnd + 1
          addRange(start, rangeEnd)
          add = false
          break
        end
      end

      -- comp start später, compStart > start
    else
      -- comp started in range
      if compStart <= rangeEnd then
        -- comp endet früher, ist komplett in range
        if compEnd < rangeEnd then
          -- try adding left and right of existing range
          addRange(start, compStart - 1)
          addRange(compEnd + 1, rangeEnd)
          add = false
          break

          -- comp endet später
        else
          rangeEnd = compStart - 1
          addRange(start, rangeEnd)
          add = false
          break
        end
      end
    end
  end

  if add then
    local range = {}
    range["start"] = start
    range["end"] = rangeEnd
    table.insert(ranges, range)
  end
end

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

  addRange(start, rangeEnd)
end


local f = assert(io.open("./output", "w+"))
io.output(f)

local total = 0
for i, range in ipairs(ranges) do
  total = total + 1 + (range["end"] - range["start"])

  for j, coll in pairs(range) do
    io.write(coll, " ")
  end
  io.write("\n")
end

print(total)
