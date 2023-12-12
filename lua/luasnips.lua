local ls = require("luasnip")
local text = ls.text_node
local insert = ls.insert_node
local choice = ls.choice_node

ls.add_snippets(nil, {
  php = {
    ls.snippet({
      trig = "fac",
      namr = "Factory2",
    }, {
        text({"factory("}), insert(1, "Class Name"), text({"::class)->create("}),
        choice(2, {
          text({");"}),
          {
            text({"[", "    '"}), insert(1, "p"), text({"' => "}), insert(2, "v"), text({",", "]);"})
          }
        }),
          insert(0)
      }
    )
  }}
)
