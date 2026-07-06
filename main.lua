local Widget = require("ui/widget/widget")
local Dispatcher = require("dispatcher")
local SafahatSearch = require("safahat/multisearch_dialog")

local SafahatPlugin = Widget:extend{}

function SafahatPlugin:init()
    self:registerMenuEntry()
end

function SafahatPlugin:registerMenuEntry()
    self.ui.menu:registerEntry("safahat_search", {
        category = "search",
        text = "Search Safahat",
        callback = function()
            local search_dialog = SafahatSearch:new{ ui = self.ui }
            search_dialog:open()
        end,
    })
end

return SafahatPlugin
