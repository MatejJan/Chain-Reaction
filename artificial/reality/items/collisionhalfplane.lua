collision_half_plane={}
collision_half_plane.new=function(half_plane)
  local _=item.new()
  local __=extend(_)
  _.constructor=collision_half_plane
  local hpc=half_plane_collider.new(half_plane)
  _.add(hpc)
  return _
end
