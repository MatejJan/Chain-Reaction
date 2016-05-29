circle_circle_collisions={}
circle_circle_collisions.new=function(order)
  local _=part.new()
  local __=extend(_)
  _.constructor=circle_circle_collisions

  local _resolve_collision=function(i1, i2)
    local c1=i1.as(circle_collider)
    local c2=i2.as(circle_collider)
    if not (c1 and c2) then return end

    local vdc=vector.subtract(c2.position(),c1.position())
    local dc=vdc.length()
    local md=c1.radius()+c2.radius()
    if dc>=md then return end

    local rd=md-dc
    local n=vector.unit_x()
    if dc then n.set(vdc).normalize() end
    local vrd=vector.multiply(n,rd*2)

    collision.relax(i1,i2,vrd)
    collision.collide(i1,i2,n)
  end

  _.install=function(parent)
    __.install(parent)
    parent.as(collision_detector).register_method(_resolve_collision,order)
  end

  return _
end
