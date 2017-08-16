use Amnesia

defdatabase Physics.Database do
    
    deftable Planet, [{:id, autoincrement}, :name, :mass, :radius, :type, :ev], type: :ordered_set do
        # helper methods, lookups, etc.
    end

end