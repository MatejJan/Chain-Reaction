classical_mechanics={}
classical_mechanics.new=function(order)
  local _=part.new()
  local __=extend(_)
  _.constructor=classical_mechanics

  local _simulate=function(i)
    local m=i.as(movable)
    local f=i.as(force_user)
    if f then
      if f.mass() then
        f.acceleration(f.force()/f.mass())
        f.force().set(0,0)
        f.velocity().add(v2.multiply(f.acceleration(),dt))
      end
    end
    if m then
      m.position().add(v2.multiply(m.velocity(),dt))
    end
  end

  _.install=function(parent)
    __.install(parent)
    parent.as(scene_iterator).register_method(_simulate,order)
  end

  return _
end
