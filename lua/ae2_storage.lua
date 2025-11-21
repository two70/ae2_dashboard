local me = peripheral.find("meBridge")

-- Helper: recursively serialize a Lua table into JSON
local function toJSON(value)
    local t = type(value)
    if t == "table" then
        local parts = {}
        local isArray = (#value > 0)
        if isArray then
            table.insert(parts, "[")
            for i, v in ipairs(value) do
                table.insert(parts, toJSON(v))
                if i < #value then table.insert(parts, ",") end
            end
            table.insert(parts, "]")
        else
            table.insert(parts, "{")
            local first = true
            for k, v in pairs(value) do
                if not first then table.insert(parts, ",") end
                first = false
                table.insert(parts, string.format("\"%s\":%s", k, toJSON(v)))
            end
            table.insert(parts, "}")
        end
        return table.concat(parts)
    elseif t == "string" then
        return string.format("\"%s\"", value:gsub("\"","\\\""))
    elseif t == "number" or t == "boolean" then
        return tostring(value)
    else
        return "\"\""
    end
end

-- Fetch items
local items = me.listItems()

-- Build JSON array
local jsonParts = {}
table.insert(jsonParts, "[")

for i, item in ipairs(items) do
    local entry = "{"
    entry = entry .. string.format("\"name\":\"%s\",", item.name)
    entry = entry .. string.format("\"displayName\":\"%s\",", item.displayName)
    entry = entry .. string.format("\"amount\":%d", item.amount)

    -- Add fingerprint if present
    if item.fingerprint then
        entry = entry .. string.format(",\"fingerprint\":\"%s\"", item.fingerprint)
    end

    -- Add NBT if present
    if item.nbt then
        entry = entry .. ",\"nbt\":" .. toJSON(item.nbt)
    end

    entry = entry .. "}"
    table.insert(jsonParts, entry)

    if i < #items then
        table.insert(jsonParts, ",")
    end
end

table.insert(jsonParts, "]")
local jsonData = table.concat(jsonParts)

-- Save to file
local file = fs.open("ae2_storage.json", "w")
file.write(jsonData)
file.close()

-- Target URL
local url = "https://localhost:3000/items"
-- Perform HTTP POST
local response = http.post(url, jsonData, {["Content-Type"] = "application/json"})
if response then
    print("Data posted successfully!")
    print("Server response: " .. response.readAll())
    response.close()
else
    print("Failed to post data. Check HTTP API settings or URL.")
end