return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = function(term)
        -- Si la dirección es "horizontal", usa el 100% del alto
        if term.direction == "horizontal" then
          return vim.o.lines
        elseif term.direction == "vertical" then
          return vim.o.columns
        end
      end,
      open_mapping = [[<C-->]], -- Ajusta la combinación de teclas según tu preferencia
      direction = "float", -- Terminal en modo flotante
      float_opts = {
        border = "single", -- Opciones: 'single', 'double', 'shadow', 'curved', 'none'
        width = function()
          return vim.o.columns - 5
        end, -- Ancho: toda la pantalla
        height = function()
          return vim.o.lines - 5
        end, -- Alto: toda la pantalla
      },
      -- Opcional: Ajustar sombreado del fondo
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 1, -- Ajusta el nivel de sombreado del fondo (0-3)
      persist_size = true,
      close_on_exit = true, -- Cierra la terminal al salir
      shell = vim.o.shell, -- Usa la shell predeterminada del sistema
    })
  end,
}
