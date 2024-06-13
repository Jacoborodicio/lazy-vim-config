-- lua/utils.lua
local M = {}

function M.pick(action)
  if action == "oldfiles" then
    return ":Telescope oldfiles<CR>"
  elseif action == "live_grep" then
    return ":Telescope live_grep<CR>"
  elseif action == "config_files" then
    return ":e $MYVIMRC<CR>"
  else
    return ":Telescope find_files<CR>"
  end
end

function M.config_files()
  return ":e $MYVIMRC<CR>"
end

return M
