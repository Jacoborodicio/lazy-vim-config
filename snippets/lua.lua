local ls = require("luasnip")
local s = ls.s
local fmt = require("luasnip.extras.fmt")
local i = ls.insert_node
local rep = require("luasnip.extras").rep
ls.snippets({
  all = {
    s("demo", fmt("local {} = require('{}')", { i(1, "default_value"), rep(1) })),
  },
  lua = {
    s("demo", fmt("local {} = require('{}')", { i(1, "default_value"), rep(1) })),
  },
  javascript = {},
})
