local _private = {}
local mt={
    __index = strict_read,
    __newindex = strict_write
}

treasure = {}
setmetatable(treasure, mt)

function strict_read(table, key)
    if _private[key] then
        return _private[key]
    else
        error("Invalid key: " .. key)
    end
end

function strict_write(table, key, value)
    if _private[key] then
        error("Dublicate key: " .. key)
    else
        _private[key] = value
    end
end
