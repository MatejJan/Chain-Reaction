--chain reaction
dt=1/30

ball={}
ball.new=function()
  local _=item.new()
  _.require(particle)
  _.position=_.require_field(position)
  _.velocity=_.require_field(velocity)
  _.radius=_.require_field(radius)
  _.mass=_.require_field(mass)
  return _
end

s=scene.new()

b1=ball.new()
b1.position(v2.new(10,10))
b1.velocity(v2.new(10,5))
b1.radius(10)
b1.mass(40)

b2=ball.new()
b2.position(v2.new(100,80))
b2.velocity(v2.new(-10,-10))
b2.radius(5)
b2.mass(10)

s.add(b1)
s.add(b2)

sim=simulator.new()
sim.add(s)
sim.add(scene_iterator.new(50))
sim.add(classical_mechanics.new(20))

pr=physics_renderer.new(s)

function _init()

end

function _update()
  sim.simulate()
end

function _draw()
  cls()
  pr.draw()
end

