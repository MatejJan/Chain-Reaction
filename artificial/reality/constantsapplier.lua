constants_applier={}
constants_applier.new=function(accumulation_order)
  local _=part.new()
  local __=extend(_)
  _.constructor=constants_applier

  _.acceleration_accumulator=vector.new()

  local _accumulate=function()
    _.acceleration_accumulator.set(0,0)
    local s=_.parent.as(scene)
    for i in all(s.items) do
      local ca=i.as(constant_acceleration)
      if ca then _.acceleration_accumulator.add(ca.value) end
    end
  end

  _.apply=function(item)
    local f= item.as(force_user)
    if f then
      f.accumulated_acceleration().add(_.acceleration_accumulator)
    end
    local s=_.parent.as(scene)
    for i2 in all(s.items) do
      local idf=i2.as(dynamic_force)
      if idf then
        idf.add_force(item,_.parent)
      end
    end
  end

  _.install=function(parent)
    __.install(parent)
    parent.as(simulator).register_method(_accumulate,accumulation_order)
  end

  return _
end
