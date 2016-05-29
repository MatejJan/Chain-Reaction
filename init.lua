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
  _.require(coefficient_of_restitution).value=0.5
  return _
end

s=scene.new()

b=ball.new()
b.position(vector.new(20,20))
--b.velocity(vector.new(10,5))
b.radius(10)
b.mass(40)
s.add(b)

b=ball.new()
b.position(vector.new(100,80))
--b.velocity(vector.new(-10,-10))
b.radius(5)
b.mass(10)
s.add(b)

b=ball.new()
b.position(vector.new(50,50))
--b.velocity(vector.new(100,-10))
b.radius(3)
b.mass(5)
s.add(b)

hp=collision_half_plane.new(half_plane.new(vector.up(),-127)) s.add(hp)
hp=collision_half_plane.new(half_plane.new(vector.new(-1,-2),-140)) s.add(hp)
hp=collision_half_plane.new(half_plane.new(vector.left(),-127)) s.add(hp)
hp=collision_half_plane.new(half_plane.new(vector.down(),0)) s.add(hp)
hp=collision_half_plane.new(half_plane.new(vector.right(),0)) s.add(hp)

s.add(constant_acceleration.new(vector.new(0,98)))

sim=simulator.new()
sim.add(s)
sim.add(scene_iterator.new(50))
sim.add(classical_mechanics.new(20))
sim.add(collision_detector.new(30))
sim.add(circle_circle_collisions.new(0))
sim.add(circle_half_plane_collisions.new(1))
sim.add(constants_applier.new(10, 15))

pr=physics_renderer.new(s)
--pr.velocity=true

function _init()
  cls()
end

function _update()
  if btnp()>0 then
    b=ball.new()
    b.position(vector.new(14+rnd()*100,14+rnd()*100))
    --b.velocity(vector.new(100,-10))
    local size=3+rnd()*7
    b.radius(size)
    b.mass(size*size)
    s.add(b)
  end

  sim.simulate()
end

function _draw()
  cls()
  pr.draw()
end

