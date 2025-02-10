return {
  "hrsh7th/nvim-cmp",
  enabled = true,
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "zbirenbaum/copilot.lua",
    "zbirenbaum/copilot-cmp",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(), -- Mostrar menú de autocompletado
        ["<C-n>"] = cmp.mapping.select_next_item(), -- Seleccionar siguiente ítem
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- Seleccionar ítem anterior
        ["<CR>"] = function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end,
      }),
      sources = cmp.config.sources({
        { name = "luasnip", priority = 1000 }, -- Fuente de snippets
        { name = "copilot", priority = 999 }, -- Fuente de Copilot
      }),
    })
  end,
}
