static_fluid={}
static_fluid.new=function(collider)
  local _=item.new()
  local __=extend(_)
  _.constructor=static_fluid
  _.density=0
  _.density=0
  _.drag_factor=1
  _.add(collider)
  local _cc=custom_collider.new()
  _.add(_cc)

  local _df=dynamic_force.new()
  _.add(_df)

  _df.add_force=function(item, simulator)
    if item==_ then return end
    local collision_info=simulator.as(collision_detector).detect_collision(item, _)
    if not collision_info then return end

    if not item.has(radius) then return end
    local radius=item.as(radius).value

    --buoyancy
    local d=2*radius
    local p=min(1, -collision_info.relax_distance/d)
    if p<0 then assert.fail() end
    if p>1 then assert.fail() end
    local area=pi*radius*radius*p
    local buoyancy=vector.negate(simulator.as(constants_applier).acceleration_accumulator)
    buoyancy.multiply(area*_.density)
    item.as(accumulated_force).value.add(buoyancy)

    if item.has(velocity) and item.has(accumulated_force) then
      --drag
      local velocity=item.as(velocity).value
      local speed_squared=velocity.length_squared()
      local drag_coefficient=0.47 * _.drag_factor
      local area=pi*radius*radius
      local drag_force=mul(area,mul(_.density,mul(speed_squared,drag_coefficient*0.5)))
      local force_vector=vector.normalize(velocity).multiply(-drag_force)
      item.as(accumulated_force).value.add(force_vector)
    end
  end
  _cc.colliding_with_item=function(item)
    return false
  end
  return _
end
