local ok, ls = pcall(require, "luasnip")
if not ok then
  return
end

return {
  "L3MON4D3/LuaSnip",
  event = "VeryLazy",
  keys = function()
    return {}
  end,
  config = function()
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local fmt = require("luasnip.extras.fmt").fmt

    -- snippets
    local snips = {
      javascript = {
        s({ trig = "cls", name = "demo" }, fmt("console.log('%c{}', 'color:orange');", { i(1, "default_value") })),

        s(
          { trig = "clg", name = "console group" },
          fmt("console.group('{}')\n{}\nconsole.groupEnd();", { i(1, "name"), i(2, "body") })
        ),
      },
      go = {
        s(
          { trig = "err", name = "error check" },
          fmt(
            [[
      		if {} != nil {{
      			{}
      		}}
      		]],
            { i(1, "err"), i(2, "body") }
          )
        ),
      },
      lua = {
        s(
          { trig = "pcall", name = "protected call" },
          fmt(
            [[
      		local ok, {} = pcall(require, '{}')
      		if not ok then return end
      		]],
            { i(1, "name"), i(2, "module") }
          )
        ),
        s({ trig = "req", name = "local require" }, fmt("local {} = require('{}')", { i(1, "name"), i(2, "module") })),
        s(
          { trig = "aucmd", name = "create lua autocommand" },
          fmt(
            [[
      		local {} = vim.api.nvim_create_augroup("{}", {{}})
      		vim.api.nvim_clear_autocmds({{ group = {} }})
      		vim.api.nvim_create_autocmd("{}", {{
      			group = {},
      			callback = function()
      				{}
      			end,
      		}})
      		]],
            {
              i(1, "name"),
              i(2, "augroup_name"),
              f(function(name)
                return name[1]
              end, { 1 }),
              i(3, "vim event"),
              f(function(name)
                return name[1]
              end, { 1 }),
              i(0, "command"),
            }
          )
        ),
        s(
          { trig = "lf", name = "local function" },
          fmt(
            [[
      		local function {}({})
      			{}
      		end
      		]],
            { i(1, "name"), i(2, "args"), i(0) }
          )
        ),
        s(
          { trig = "mod", name = "local module M" },
          fmt(
            [[
      		local M = {{}}

      		{}

      		return M
      		]],
            i(0)
          )
        ),
        s(
          { trig = "plug", name = "new plugin" },
          fmt(
            [[
      		{{
      			"{}",
      			opts = {},
      		}},
      		]],
            { i(1, "plugin"), i(2, "opts") }
          )
        ),
      },
      markdown = {
        s(
          {
            trig = "link",
            name = "Create markdown link [txt](url)",
          },
          fmt("[{}]({})", {
            i(1, "description"),
            f(function(_, snip)
              return snip.env.TM_SELECTED_TEXT[1] or {}
            end, {}),
          })
        ),
        s(
          {
            trig = "lang",
            name = "code block markdown language",
          },
          fmt(
            [[
      		```{}

      		{}
      		```
      		]],
            { i(1, "language"), i(2, "body") }
          )
        ),
      },
    }

    -- add snips to engine
    ls.add_snippets(nil, {
      all = snips.all,
      javascript = snips.javascript,
      go = snips.go,
      lua = snips.lua,
      markdown = snips.markdown,
    })
  end,
}
