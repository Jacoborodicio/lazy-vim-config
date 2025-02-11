return {
  -- 🔹 nvim-cmp: Autocompletado inteligente
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP
      "hrsh7th/cmp-buffer", -- Buffer
      "hrsh7th/cmp-path", -- Rutas de archivos
      "L3MON4D3/LuaSnip", -- Snippets
      "saadparwaiz1/cmp_luasnip", -- Integración LuaSnip + nvim-cmp
      "zbirenbaum/copilot-cmp", -- Copilot en cmp
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
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "copilot", priority = 1000 }, -- 🔹 Copilot como la primera opción
          { name = "nvim_lsp", priority = 900 }, -- 🔹 LSP
          { name = "luasnip", priority = 800 }, -- 🔹 Snippets LuaSnip
          { name = "buffer", priority = 700 },
          { name = "path", priority = 600 },
        }),
      })
    end,
  },

  -- 🔹 LuaSnip: Snippets sin que interfieran con cmp
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local rep = require("luasnip.extras").rep
      local fmt = require("luasnip.extras.fmt").fmt

      -- Define un snippet básico para TODOS los archivos
      ls.add_snippets("all", {
        s("cl", fmt("console.log('🚀 {} 🚀', 'color:orange');", { i(1, "here") })),
        s("cls", fmt("console.log('%c 🔰 {} 🔰:', 'color:orange', {});", { rep(1), i(1, "default_value") })),
        s("clg", fmt("console.group('🔻🔻 {} 🔻🔻')\n\t{}\nconsole.groupEnd();", { i(1, "name"), i(0) })),
        s(
          "clt",
          fmt(
            "console.time('🔻🔻 {} 🔻🔻')\n\nconsole.timeEnd('🔻🔻 {} 🔻🔻');",
            { i(1, "functionName"), rep(1) }
          )
        ),
      })

      -- Define el snippet para React Functional Component
      ls.add_snippets("javascript", {
        s("rfc", {
          t({ "import React from 'react';", "import PropTypes from 'prop-types';", "", "const " }),
          i(1, "ComponentName"), -- Prompt interactivo para el nombre del componente
          t({ " = () => {", "return (" }),
          t({ "", "\t<div>", "\t\t" }),
          rep(1),
          t({ " component", "\t</div>", " );", "};", "", "" }),
          t(""),
          rep(1),
          t(".propTypes = {};"),
          t({ "", "", "export default " }),
          rep(1),
          t(";"),
        }),
      })

      -- Atajos básicos para expandir y navegar por los snippets
      vim.keymap.set({ "i", "s" }, "<C-K>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-J>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end,
  },

  -- 🔹 Copilot: Integración sin conflictos con cmp
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false }, -- 🔥 Desactivamos sugerencias inline de Copilot
        panel = { enabled = false },
      })
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" }, -- Asegura que nvim-cmp se cargue primero
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
