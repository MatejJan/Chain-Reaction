collision_resolver={}
collision_resolver.new=function(order)
  local _=part.new()
  local __=extend(_)
  _.constructor=collision_resolver

  local _methods=sorted_list.new()
  _.register_method=function(m, order) _methods.add(m,order) end

  local _resolve_collisions=function(i1)
    local s=_.parent.as(scene)
    for i2 in all(s.items) do
      if i1~=i2 then
        local collision_info=_.parent.as(collision_detector).detect_collision(i1, i2)
        if collision_info then
          collision.resolve(i1,i2,collision_info)
        end
      end
    end
  end

  _.install=function(parent)
    __.install(parent)
    parent.as(scene_iterator).register_method(_resolve_collisions, order)
  end

  return _
end
