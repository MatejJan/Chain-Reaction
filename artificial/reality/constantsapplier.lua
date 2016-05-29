constants_applier={}
constants_applier.new=function(accumulation_order, application_order)
  local _=part.new()
  local __=extend(_)
  _.constructor=constants_applier

  local accumulator=vector.new()

  local _accumulate=function()
    accumulator.set(0,0)
    local s=_.parent.as(scene)
    for i in all(s.items) do
      local ca=i.as(constant_acceleration)
      if ca then accumulator.add(ca.value) end
    end
  end

  local _apply=function(i)
    local f=i.as(force_user)
    if f then
      f.accumulated_force().add(vector.multiply(accumulator, f.mass()))
    end
  end

  _.install=function(parent)
    __.install(parent)
    parent.as(simulator).register_method(_accumulate,accumulation_order)
    parent.as(scene_iterator).register_method(_apply,application_order)
  end

  return _
end
