circle_half_plane_collisions={}
circle_half_plane_collisions.new=function(order)
  local _=part.new()
  local __=extend(_)
  _.constructor=circle_half_plane_collisions

  local _detect_collision=function(i1, i2)
    local cc=i1.as(circle_collider)
    local hpc=i2.as(half_plane_collider)
    if not (cc and hpc) then return end

    local n=hpc.half_plane.normal
    local a=vector.dot(cc.position(),n)-cc.radius()
    local rd=a-hpc.half_plane.distance
    if rd>0 then return end

    --if cc==cc2 then
    --  n.negate()
    --end

    return{
      normal=n,
      relax_distance=rd,
      relax_vector=vector.multiply(n,rd)
    }
  end

  _.install=function(parent)
    __.install(parent)
    parent.as(collision_detector).register_method(_detect_collision,order)
  end

  return _
end
