(local pickers (require :telescope.pickers))
(local finders (require :telescope.finders))
(local actions (require :telescope.actions))
(local previewers (require :telescope.previewers))
(local actions-state (require :telescope.actions.state))
(local conf (. (require :telescope.config) :values))
(local {: map : first : println : merge} (require :nfnl.core))

(fn buf-info [buf]
  {:idx buf :name (vim.api.nvim_buf_get_name buf)})

(fn get-bufs-from-tab [tab]
  (let [buffers (->> tab
                   (vim.api.nvim_tabpage_list_wins)
                   (map vim.api.nvim_win_get_buf))]
    {:tab tab :buffers (map buf-info buffers)}))

(fn get-tab-entries []
  (map 
    get-bufs-from-tab 
    (vim.api.nvim_list_tabpages))) 

(fn tab-results []
  (let [tab-entries (get-tab-entries)]
    (map 
      (fn [{: buffers : tab}] 
        (let [first-buffer-name (-> buffers first (. :name))]
          {:name first-buffer-name :tab tab}))
      tab-entries)))

(fn s->plain
  [s]
  "prevent replacement magic"
  (s:gsub "(%W)" "%%%1"))

(fn cut-cwd [s]
  (let [cwd (vim.fn.getcwd)]
    (s:gsub (s->plain cwd) "")))

(fn entry-maker [{: name : tab}]
  {:display (cut-cwd name) :ordinal name :value name :tab tab})

(fn handle-attach-mappings [prompt-bufnr _map]
  (actions.select_default:replace 
    (fn []
      (actions.close prompt-bufnr)
      (let [selection (actions-state.get_selected_entry)
            tab-number (when selection 
                           (vim.api.nvim_tabpage_get_number selection.tab))]
        (when tab-number
          (vim.api.nvim_input (.. (tostring tab-number) "gt"))))))
  true)


(fn tab-picker [opts]
  (let [opts (or opts {})]
    (pickers.new opts {:prompt_title "TABS"
                       :finder (finders.new_table {:results (tab-results)
                                                   :entry_maker entry-maker})
                       :previewer (previewers.cat.new opts)     
                       :sorter (conf.generic_sorter opts)
                       :attach_mappings handle-attach-mappings})))

(fn start-tab-picker [opts]
  (let [picker (tab-picker opts)]
    (picker:find)))

{: start-tab-picker}
