local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets('cpp', {
  -- DP Template Snippet
  s('dynamicProgramingMemo', {
    t {
      'int n;',
      'cin >> n;',
      'vi arr(n);',
      'cin >> arr;',
      'vector<vi>dp(n,vi(m,-1));',
      '',
      'auto go = [&](auto &&go, int i, int ssm) -> int {',
      '    ',
    },
    i(1),
    t { '', '};', '', 'cout << go(go, 0, 0);' },
  }),
})
