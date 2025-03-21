-- CodeCompanion Fidget Integration
local M = {}
local progress = require("fidget.progress")
local handle = nil

function M:init()
    local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})
    
    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionRequest*",
        group = group,
        callback = function(request)
            if request.match == "CodeCompanionRequestStarted" then
                -- Get the chat buffer to access adapter info
                local chat = require("codecompanion").buf_get_chat(request.data.bufnr)
                local adapter_name = "Unknown"
                local model_name = "Unknown"

                if chat and chat.adapter then
                    adapter_name = chat.adapter.formatted_name or chat.adapter.name
                    model_name = chat.adapter.model or ""
                end

                handle = progress.handle.create({
                    title = " Requesting assistance",
                    lsp_client = {
                        name = string.format("CodeCompanion (%s - %s)", adapter_name, model_name),
                    },
                })
            elseif request.match == "CodeCompanionRequestFinished" then
                if handle then
                    handle:finish()
                end
            end
        end,
    })
end

return M 