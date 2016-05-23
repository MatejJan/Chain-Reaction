scene_iterator={}
scene_iterator.new=function(order)
  local _=part.new()
  local __=extend(_)
  _.constructor=scene_iterator

  local _methods=sorted_list.new()
  _.register_method=function(m, order) _methods.add(m,order) end

  local _iterate=function()
    s=_.parent.as(scene)
    for i in all(s.items) do
      for m in all(_methods) do m(i) end
    end
  end

  _.install=function(parent)
    __.install(parent)
    parent.as(simulator).register_method(_iterate, order)
  end

  return _
end