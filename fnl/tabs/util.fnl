(fn flatten [t acc]
  (let [new-t (or acc [])]
    (each [_ item (pairs t)]
      (if (= :table (type item))
          (flatten item new-t)
          (table.insert new-t item)))
    new-t))

{: flatten}
