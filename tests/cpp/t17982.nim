discard """
  targets: "cpp"
  action: "compile"
"""

type
  String* {.importcpp: "std::string", header: "string".} = object

proc initString*(): String
    {.importcpp: "std::string()", header: "string".}

proc append*(this: var String, str: String): String
    # bug seems to trigger when `#`, `@`, or `$1` is used inside `importcpp`
    {.importcpp: "#.append(@)", header: "string", discardable.} # <- changed from `importcpp: "append"`

var
  s1 = initString()
  s2 = initString()

s1.append s2
