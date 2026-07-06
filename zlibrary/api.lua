local Dispatcher = require("dispatcher")
local JSON = require("json")
local logger = require("logger")

local SafahatAPI = {}

local BASE_URL = "https://www.safahat.org"

-- Basic Search Function
function SafahatAPI:search(query, page)
    page = page or 1
    -- Adjust parameters depending on Safahat's exact endpoints (e.g., /api/books or /search)
    local url = string.format("%s/api/search?q=%s&page=%d", BASE_URL, Dispatcher:urlEncode(query), page)
    
    local response = Dispatcher:get(url, {
        ["User-Agent"] = "KOReader/SafahatPlugin",
        ["Accept"] = "application/json"
    })

    if not response or response.code ~= 200 then
        logger.err("Safahat API: Search request failed with code", response and response.code)
        return nil
    )

    local data = JSON.decode(response.body)
    return self:parseResults(data)
end

-- Adapt Safahat's specific JSON structure to match KOReader's item expected fields
function SafahatAPI:parseResults(data)
    if not data or not data.results then return {} end
    
    local books = {}
    for _, item in ipairs(data.results) do
        table.insert(books, {
            id = item.id,
            title = item.title,
            author = item.author or "Unknown Author",
            extension = item.file_extension or "pdf",
            size = item.file_size or "Unknown Size",
            download_url = BASE_URL .. item.download_path
        })
    end
    return books
end

return SafahatAPI
