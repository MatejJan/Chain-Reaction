half_plane_collider={}
half_plane_collider.new=function(half_plane)
  local _=part.new()
  local __=extend(_)
  _.constructor=half_plane_collider
  _.half_plane=half_plane
  return _
end
