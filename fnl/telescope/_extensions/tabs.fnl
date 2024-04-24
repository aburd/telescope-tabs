(local {: register_extension} (require :telescope))
(local tabs (require :tabs))

(local extender {:theme {}})

(fn get-tab-picker [opts]
  (tabs.start-tab-picker (vim.tbl_deep_extend "force" extender.theme opts)))

(register_extension 
  {:setup (fn [ext_config config]
            ; (print "ext_config")
            ; (print (vim.inspect ext_config))
            ; (print "config")
            ; (print (vim.inspect config))
            (when ext_config.theme
              (tset extender :theme ext_config.theme)))
   :exports {:tabs get-tab-picker}})
