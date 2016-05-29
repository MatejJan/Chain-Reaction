circle_half_plane_collisions={}
circle_half_plane_collisions.new=function(order)
  local _=part.new()
  local __=extend(_)
  _.constructor=circle_half_plane_collisions

  local _resolve_collision=function(i1, i2)
    local cc1=i1.as(circle_collider)
    local cc2=i2.as(circle_collider)
    local hpc1=i1.as(half_plane_collider)
    local hpc2=i2.as(half_plane_collider)
    local cc=cc1 or cc2
    local hpc=hpc1 or hpc2
    if not (cc and hpc) then return end

    local n=hpc.half_plane.normal
    local a=vector.dot(cc.position(),n)-cc.radius()
    local rd=a-hpc.half_plane.distance
    if rd>0 then return end

    local vrd=vector.multiply(n,rd*2)

    collision.relax(cc.parent,hpc.parent,vrd)
    collision.collide(cc.parent,hpc.parent,n)
  end

  _.install=function(parent)
    __.install(parent)
    parent.as(collision_detector).register_method(_resolve_collision,order)
  end

  return _
end
