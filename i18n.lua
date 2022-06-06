local format
format = function(fstring, vals)
  fstring = fstring:gsub("%%{(%w+)}", vals)
  fstring = fstring:gsub("(`|)", "#")
  return fstring:gsub("(``)", "\n")
end
local ldstring
ldstring = function(contents)
  contents = contents:gsub("(#[^\n]*\n)", "")
  local intl = { }
  for k, v in contents:gmatch("([%w_]+)=([^\n]*)") do
    intl[k] = v
  end
  return setmetatable(intl, {
    __call = function(self, name, vals)
      return format(self[name], vals)
    end
  })
end
local ldfile
ldfile = function(pathname)
  do
    local _with_0 = io.open(pathname)
    local content = _with_0:read("*a")
    _with_0:close()
    return ldstring(content)
  end
end
return {
  ldfile = ldfile,
  ldstring = ldstring
}
