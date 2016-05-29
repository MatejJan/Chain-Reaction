collision_detector={}
collision_detector.new=function(order)
  local _=part.new()
  local __=extend(_)
  _.constructor=collision_detector

  local _methods=sorted_list.new()
  _.register_method=function(m, order) _methods.add(m,order) end

  local _detect_collisions=function(i1)
    local s=_.parent.as(scene)
    for i2 in all(s.items) do
      if i1~=i2 then
        for m in all(_methods) do m(i1, i2) end
      end
    end
  end

  _.install=function(parent)
    __.install(parent)
    parent.as(scene_iterator).register_method(_detect_collisions, order)
  end

  return _
end
