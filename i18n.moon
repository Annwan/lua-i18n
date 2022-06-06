-- i18n.moon
-- minimalist i18n lib in moonscript
-- a compiled lua file is also available

format = (fstring, vals) ->
  fstring = fstring\gsub "%%{(%w+)}", vals
  fstring = fstring\gsub "(`|)", "#"
  fstring\gsub "(``)", "\n"

ldstring = (contents) ->
  contents = contents\gsub "(#[^\n]*\n)", ""
  intl = {}
  for k, v in contents\gmatch "([%w_]+)=([^\n]*)"
    intl[k] = v
  setmetatable intl, __call: (name, vals) => format @[name], vals

ldfile = (pathname) ->
  with io.open pathname
    content = \read "*a"
    \close!
    return ldstring content

{:ldfile, :ldstring}
