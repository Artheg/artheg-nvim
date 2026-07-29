-- lualine theme built from the shared palette, so statusline colors cannot
-- drift from the colorscheme. Mode is the one place the jewel accents are used
-- decoratively rather than to signal a diagnostic.

local M = {}

function M.build(name)
  local p = require("noble.palette")[name]
  if not p then
    error("noble.lualine: unknown palette '" .. tostring(name) .. "'")
  end

  local b = { fg = p.base, bg = p.bg_light }
  local c = { fg = p.dim, bg = p.sl_bg }

  local function mode(accent)
    return { a = { fg = p.bg, bg = accent, gui = "bold" }, b = b, c = c }
  end

  return {
    normal   = mode(p.bright),
    insert   = mode(p.sage),
    visual   = mode(p.amber),
    replace  = mode(p.garnet),
    command  = mode(p.verdigris),
    terminal = mode(p.brass),
    inactive = {
      a = { fg = p.dim, bg = p.sl_bg },
      b = { fg = p.dim, bg = p.sl_bg },
      c = { fg = p.faint, bg = p.sl_bg },
    },
  }
end

return M
