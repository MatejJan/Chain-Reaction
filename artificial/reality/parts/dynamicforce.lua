dynamic_force={}
dynamic_force.new=function()
  local _=part.new()
  local __=extend(_)
  _.constructor=dynamic_force
  _.add_force=nil
  return _
end
