vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.opt.background = "dark"
vim.g.colors_name = "noble-ink"

-- Dropped so editing a hex in noble/palette.lua shows up on the next
-- :colorscheme noble-ink. Negligible next to the nvim_set_hl calls themselves.
package.loaded["noble"] = nil
package.loaded["noble.palette"] = nil

require("noble").load("ink")
