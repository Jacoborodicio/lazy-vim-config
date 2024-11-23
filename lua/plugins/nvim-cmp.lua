return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip", -- LuaSnip ya está integrado
    "saadparwaiz1/cmp_luasnip", -- Fuente para LuaSnip
    "zbirenbaum/copilot.lua",
    "zbirenbaum/copilot-cmp",
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Aseguramos que cmp_luasnip esté incluido en las fuentes
    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
      { name = "luasnip", priority = 1000 }, -- Añade LuaSnip como fuente de snippets
      { name = "copilot", priority = 999 },
    }))

    opts.mapping = cmp.mapping.preset.insert({
      ["<C-Space>"] = cmp.mapping.complete(), -- Mostrar menú de autocompletado manualmente
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirma sugerencias de cmp
      ["<Tab>"] = cmp.mapping(function(fallback)
        local copilot = require("copilot.suggestion")
        if copilot.is_visible() then
          copilot.accept() -- Acepta la sugerencia inline de Copilot
        elseif cmp.visible() then
          cmp.select_next_item() -- Navega al siguiente ítem de cmp
        else
          fallback() -- Comportamiento normal de Tab
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item() -- Navega al ítem anterior de cmp
        else
          fallback() -- Comportamiento normal de Shift+Tab
        end
      end, { "i", "s" }),
    })

    -- Añadimos los atajos específicos para LuaSnip
    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<C-K>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-J>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    return opts
  end,
}
