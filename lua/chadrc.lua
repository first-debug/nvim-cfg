-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
---@type ChadrcConfig
local M = {}

local header = require "core.statusline.header"

M.base46 = {
  theme = "flouromachine",
  transparency = true,
}

M.ui = {
  statusline = {
    theme = "vscode_colored",
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    DiffChange = { bg = "#464414", fg = "none" },
    DiffAdd = { bg = "#103507", fg = "none" },
    DiffRemove = { bg = "#461414", fg = "none" },
  },
}
M.nvdash = {
  load_on_startup = true,
  header = header,
  buttons = {
    { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
    { txt = "󰈚  Recent Files", keys = "Spc f r", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
    { txt = "  Find Projects", keys = "Spc f p", cmd = "Telescope projects" },
    { txt = "  Themes", keys = "Spc f t", cmd = "Telescope themes" },
    { txt = "  Mappings", keys = "Spc n c", cmd = "NvCheatsheet" },
    { txt = "─", no_gap = true, rep = true },
    {
      txt = function()
        local stats = require("lazy").stats()
        local milliseconds = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. milliseconds
      end,
      no_gap = true,
    },
    { txt = "─", no_gap = true, rep = true },
  },
}

return M
