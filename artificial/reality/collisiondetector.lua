collision_detector={}
collision_detector.new=function()
  local _=part.new()
  local __=extend(_)
  _.constructor=collision_detector

  local _methods=sorted_list.new()
  _.register_method=function(m, order) _methods.add(m,order) end

  _.detect_collision=function(i1,i2)
    if i1~=i2 then
      for m in all(_methods) do
        local collision_info=m(i1, i2)
        if collision_info then return collision_info end
      end
    end
  end

  return _
end
