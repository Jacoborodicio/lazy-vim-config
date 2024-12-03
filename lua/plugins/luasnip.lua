return {
  "L3MON4D3/LuaSnip",
  version = "v2.*", -- Usa la última versión estable
  build = "make install_jsregexp", -- Instalar soporte adicional opcional
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
}
