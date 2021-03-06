simulator={}
simulator.new=function()
  local _=part.new()
  _.constructor=simulator

  local _methods=sorted_list.new()
  _.register_method=function(m, order) _methods.add(m,order) end
  _.unregister_method=function(m) _methods.remove(m) end

  _.simulate=function() for m in all(_methods) do m() end end

  return _
end
