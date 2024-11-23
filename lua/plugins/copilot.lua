return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true, -- Esto activa las sugerencias inline
          auto_trigger = true, -- Activa las sugerencias automáticamente
          keymap = {
            accept = "<Enter>", -- Acepta sugerencias inline con Enter
            next = "<C-]>",
            prev = "<C-[>",
            dismiss = "<C-\\>",
          },
        },
        panel = { enabled = false }, -- Puedes habilitar el panel flotante si lo deseas
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
