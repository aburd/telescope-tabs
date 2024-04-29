-- [nfnl] Compiled from fnl/tabs/init.fnl by https://github.com/Olical/nfnl, do not edit.
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local actions_state = require("telescope.actions.state")
local conf = (require("telescope.config")).values
local _local_1_ = require("nfnl.core")
local map = _local_1_["map"]
local first = _local_1_["first"]
local println = _local_1_["println"]
local merge = _local_1_["merge"]
local function buf_info(buf)
  return {idx = buf, name = vim.api.nvim_buf_get_name(buf)}
end
local function get_bufs_from_tab(tab)
  local buffers = map(vim.api.nvim_win_get_buf, vim.api.nvim_tabpage_list_wins(tab))
  return {tab = tab, buffers = map(buf_info, buffers)}
end
local function get_tab_entries()
  return map(get_bufs_from_tab, vim.api.nvim_list_tabpages())
end
local function tab_results()
  local tab_entries = get_tab_entries()
  local function _4_(_2_)
    local _arg_3_ = _2_
    local buffers = _arg_3_["buffers"]
    local tab = _arg_3_["tab"]
    local first_buffer_name = first(buffers).name
    return {name = first_buffer_name, tab = tab}
  end
  return map(_4_, tab_entries)
end
local function s__3eplain(s)
  return s:gsub("(%W)", "%%%1")
end
local function cut_cwd(s)
  local cwd = vim.fn.getcwd()
  return s:gsub(s__3eplain(cwd), "")
end
local function entry_maker(_5_)
  local _arg_6_ = _5_
  local name = _arg_6_["name"]
  local tab = _arg_6_["tab"]
  return {display = cut_cwd(name), ordinal = name, value = name, tab = tab}
end
local function handle_attach_mappings(prompt_bufnr, _map)
  local function _7_()
    actions.close(prompt_bufnr)
    local selection = actions_state.get_selected_entry()
    local tab_number
    if selection then
      tab_number = vim.api.nvim_tabpage_get_number(selection.tab)
    else
      tab_number = nil
    end
    if tab_number then
      return vim.api.nvim_input((tostring(tab_number) .. "gt"))
    else
      return nil
    end
  end
  do end (actions.select_default):replace(_7_)
  return true
end
local function tab_picker(opts)
  local opts0 = (opts or {})
  return pickers.new(opts0, {prompt_title = "TABS", finder = finders.new_table({results = tab_results(), entry_maker = entry_maker}), previewer = previewers.cat.new(opts0), sorter = conf.generic_sorter(opts0), attach_mappings = handle_attach_mappings})
end
local function start_tab_picker(opts)
  local picker = tab_picker(opts)
  return picker:find()
end
return {["start-tab-picker"] = start_tab_picker}
