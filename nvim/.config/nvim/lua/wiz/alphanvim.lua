local alpha_ok, alpha = pcall(require, "alpha")
if not alpha_ok then
  print("error when loading Alpha")
  return
end

local startify = require("alpha.themes.startify")

startify.section.header.val = {
  [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
  [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
  [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
  [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
  [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
  [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
}

-- disable MRU
startify.section.mru.val = { { type = "padding", val = 0 } }
-- disable MRU cwd
startify.section.mru_cwd.val = { { type = "padding", val = 0 } }

startify.section.top_buttons.val = {
  startify.button("vi", "nvim", ":cd ~/Dotfiles/nvim/.config/nvim/<CR>:e init.lua<CR>"),
  startify.button("zs", "zsh", ":cd ~/Dotfiles/zsh/.config/zsh/<CR>:e .zshrc<CR>"),
  startify.button("ze", "zshenv", ":cd ~/Dotfiles/zsh/<CR>:e .zshenv<CR>"),
  startify.button("vw", "wiki", ":cd ~/Documents/Stuff/Notas/Vim_wiki/<CR>:e index.wiki<CR>"),
}

startify.section.bottom_buttons.val = {
  startify.button("q", "quit", ":qa<CR>"),
  startify.button("e", "new file", ":ene <BAR> startinsert <CR>"),
}

alpha.setup(startify.opts)
