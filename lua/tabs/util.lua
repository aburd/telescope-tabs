-- [nfnl] Compiled from util.fnl by https://github.com/Olical/nfnl, do not edit.
local function flatten(t, acc)
  local new_t = (acc or {})
  for _, item in pairs(t) do
    if ("table" == type(item)) then
      flatten(item, new_t)
    else
      table.insert(new_t, item)
    end
  end
  return new_t
end
return {flatten = flatten}
