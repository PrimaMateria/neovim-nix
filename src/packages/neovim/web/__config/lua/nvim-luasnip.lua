local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local function copy(args)
	return args[1]
end

ls.add_snippets("javascript", {
	-- simple doc string
	s("doc", {
		t({ "/**", " * " }),
		i(1),
		t({ "", " */" }),
	}),

	-- console log
	s("cl", {
		t({ 'console.log("' }),
		i(1),
		t({ '");' }),
	}),
}, { key = "javascript" })

ls.add_snippets("typescriptreact", {
	-- React component
	s("component", {
		t({
			"export function ",
		}),
		i(1),
		t({
			"() {",
			"",
			"  return (",
			"    <>",
		}),
		f(copy, 1),
		t({
			"</>",
			"  );",
			"}",
		}),
	}),

	-- React component with props
	s("componentprops", {
		t({ "type " }),
		f(copy, 1),
		t({
			"Props = {};",
			"",
			"export function ",
		}),
		i(1),
		t({
			"(props: ",
		}),
		f(copy, 1),
		t({
			"Props) {",
			"  const {} = props;",
			"",
			"  return (",
			"    <>",
		}),
		f(copy, 1),
		t({
			"</>",
			"  );",
			"}",
		}),
	}),

	-- React hook
	s("hook", {
		t({ "type Use" }),
		f(copy, 1),
		t({
			"Props = {};",
			"",
			"export function use",
		}),
		i(1),
		t({
			"(props: Use",
		}),
		f(copy, 1),
		t({
			"Props) {",
			"  const {} = props;",
			"",
			"  return;",
			"",
			"}",
		}),
	}),

	-- React useMemo
	s("memo", {
		t({ "const " }),
		i(1),
		t({
			" = useMemo(() => {",
			"",
		}),
		i(2),
		t({
			"",
			"}, []);",
		}),
	}),

	-- React useCallback
	s("callback", {
		t({ "const " }),
		i(1),
		t({
			" = useCallback(() => {",
			"",
		}),
		i(2),
		t({
			"",
			"}, []);",
		}),
	}),

	-- React useEffect
	s("effect", {
		t({ "// " }),
		i(1),
		t({
			"",
			"useEffect(() => {",
			"",
		}),
		i(2),
		t({
			"",
			"}, []);",
		}),
	}),

	-- Jest test
	s("it", {
		t({
			'it("',
		}),
		i(1),
		t({
			'", () => {',
			"  // given",
			"  // when",
			"  // then",
			" });",
		}),
	}),
}, { key = "typescriptreact" })

ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascript", "javascript", "typescript" })
ls.filetype_extend("javascriptreact", { "javascript" })
