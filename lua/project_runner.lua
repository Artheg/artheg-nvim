local M = {}

M.commands = {
  javascript = "node index.js",
  go = "go run .",
  c = "gcc main.c -o main && ./main",
  cpp = "g++ main.cpp -o main && ./main",
  odin = "odin run .",
}

function M.run()
  local ft = vim.bo.filetype
  local cmd = M.commands[ft]
  if cmd then
    vim.cmd("FloatermNew " .. cmd)
  else
    print("No run command configured for filetype: " .. ft)
  end
end

vim.api.nvim_create_user_command("RunProject", M.run, {})

return M
