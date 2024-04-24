-- [nfnl] Compiled from fnl/telescope/_extensions/tabs.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("telescope")
local register_extension = _local_1_["register_extension"]
local tabs = require("tabs")
local extender = {theme = {}}
local function get_tab_picker(opts)
  return tabs["start-tab-picker"](vim.tbl_deep_extend("force", extender.theme, opts))
end
local function _2_(ext_config, config)
  if ext_config.theme then
    extender["theme"] = ext_config.theme
    return nil
  else
    return nil
  end
end
return register_extension({setup = _2_, exports = {tabs = get_tab_picker}})
