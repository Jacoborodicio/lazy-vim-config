return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20, -- Tamaño de la terminal
      open_mapping = [[<C-->]], -- Aquí puedes usar <C--> o cualquier combinación
      direction = "float", -- Terminal flotante
      float_opts = {
        border = "curved", -- Bordes agradables
      },
    })
  end,
}
