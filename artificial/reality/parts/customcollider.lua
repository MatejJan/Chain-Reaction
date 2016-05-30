custom_collider={}
custom_collider.new=function()
  local _=part.new()
  local __=extend(_)
  _.constructor=custom_collider
  _.collision_info=nil
  _.colliding_with_item=nil
  _.collided_with_item=nil
  return _
end
