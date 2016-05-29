half_plane={}
half_plane.new=function(normal, distance)
  local _={}
  _.normal=vector.normalize(normal)
  _.distance=distance
  _.constructor=half_plane
  return _
end
