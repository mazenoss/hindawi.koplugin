local MultiInputDialog = require("ui/widget/multiinputdialog")
local UIManager = require("ui/uimanager")
local SafahatAPI = require("safahat/api")
local WidgetContainer = require("ui/widget/container/widgetcontainer")

local SafahatSearch = WidgetContainer:extend{
    -- Inherits core layout framework from KOReader UI templates
}

function SafahatSearch:onSearch(query)
    self.dialog_manager:showProgress("Searching Safahat...")
    
    local results = SafahatAPI:search(query)
    self.dialog_manager:closeProgress()

    if results and #results > 0 then
        -- Passes books smoothly into KOReader's native MultiMenuView
        self:showResultsMenu(results)
    else
        self.dialog_manager:showNotification("No books found matching your query.")
    end
end

return SafahatSearch
