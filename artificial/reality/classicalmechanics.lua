classical_mechanics={}
classical_mechanics.new=function()
  local _=part.new()
  local __=extend(_)
  _.constructor=classical_mechanics

  --Forward Euler
  local _full_step=function(i)
    local movable =i.as(movable)
    local force_user =i.as(force_user)
    if force_user then
      if movable then
        local m=force_user.mass()
        if m then
          force_user.accumulated_force().set(0,0)
          force_user.accumulated_acceleration().set(0,0)
          _.parent.as(constants_applier).apply(i)

          local acceleration_from_force=vector.multiply(force_user.accumulated_force(),1/m)
          force_user.acceleration(vector.add(acceleration_from_force, force_user.accumulated_acceleration()))

          force_user.velocity().add(vector.multiply(force_user.acceleration(),dt))
        end
      end
    end
    if movable then
      movable.position().add(vector.multiply(movable.velocity(),dt))
    end
  end

  --Newmark
  local _velocity_half_step=function(item)
    local movable = item.as(movable)
    local force_user = item.as(force_user)
    if not movable or not force_user then return end

    local m = force_user.mass()
    if not m then return end

    local v=vector.new(movable.velocity())
    force_user.velocity().set(v)

    for i=1,3 do
      force_user.accumulated_force().set(0,0)
      force_user.accumulated_acceleration().set(0,0)
      _.parent.as(constants_applier).apply(item)
      local a=vector.multiply(force_user.accumulated_force(),1/m).add(force_user.accumulated_acceleration())
      force_user.acceleration(a)
      force_user.velocity().set(vector.multiply(a,dt/2).add(v))
    end
  end

  local _position_full_step=function(item)
    local movable = item.as(movable)
    if movable then
      movable.position().add(vector.multiply(movable.velocity(),dt))
    end
  end

  _.register_velocity_half_step=function(order) _.parent.as(scene_iterator).register_method(_velocity_half_step,order) end
  _.register_position_full_step=function(order) _.parent.as(scene_iterator).register_method(_position_full_step,order) end
  _.register_full_step=function(order) _.parent.as(scene_iterator).register_method(_full_step,order) end

  return _
end
