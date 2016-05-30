lab={}
lab.new=function(simulate_order, render_order)
  local _=part.new()
  local __=extend(_)
  _.constructor=lab

  _.scene=scene.new()

  _.scene.add(constant_acceleration.new(vector.new(0,98)))

  _.water=static_fluid.new(half_plane_collider.new(half_plane.new(vector.up(), -32)))
  _.water.density=0.1
  _.water.drag_factor=0.2
  _.scene.add(_.water)

  local hp
  hp=collision_half_plane.new(half_plane.new(vector.up(),-127)) _.scene.add(hp)
  hp=collision_half_plane.new(half_plane.new(vector.left(),-127)) _.scene.add(hp)
  hp=collision_half_plane.new(half_plane.new(vector.down(),0)) _.scene.add(hp)
  hp=collision_half_plane.new(half_plane.new(vector.right(),0)) _.scene.add(hp)

  local _ball={}
  _ball.new=function()
    local _=item.new()
    _.require(particle)
    _.position=_.require_field(position)
    _.velocity=_.require_field(velocity)
    _.radius=_.require_field(radius)
    _.mass=_.require_field(mass)
    _.require(coefficient_of_restitution).value=0.9
    return _
  end

  local _simulator=simulator.new()
  _simulator.add(_.scene)
  _simulator.add(scene_iterator.new(50))

  local _classical_mechanics=classical_mechanics.new(20,40)
  _simulator.add(_classical_mechanics)
  _classical_mechanics.register_full_step(20)

  _simulator.add(collision_detector.new())
  _simulator.add(collision_resolver.new(60))
  _simulator.add(constants_applier.new(10))

  _simulator.add(circle_circle_collisions.new(0))
  _simulator.add(circle_half_plane_collisions.new(1))

  local _lab_renderer=lab_renderer.new(_)

  local _physics_renderer=physics_renderer.new(_.scene)
  _physics_renderer.acceleration=true
  _physics_renderer.velocity=true

  local _simulate=function()
    if btnp()>0 then
      local b=_ball.new()
      b.position(vector.new(64,16))
      b.velocity(vector.new(rnd()*100-50,100))
      if (rnd()<0.5) then
        b.radius(12)
        b.mass(pi*12*12*_.water.density*0.5)
      else
        b.radius(12)
        b.mass(pi*12*12*_.water.density)
      end
      _.scene.add(b)
    end

    _simulator.simulate()
  end

  local _render=function()
    _lab_renderer.render()
    _physics_renderer.render()
  end

  _.install=function(parent)
    __.install(parent)
    parent.as(simulator).register_method(_simulate, simulate_order)
    parent.as(renderer).register_method(_render, render_order)
  end
  _.uninstall=function()
    __.uninstall()
    parent.as(simulator).unregister_method(_simulate, simulate_order)
    parent.as(renderer).unregister_method(_render, render_order)
  end

  return _
end
