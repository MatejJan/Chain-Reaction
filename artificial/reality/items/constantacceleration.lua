constant_acceleration={}
constant_acceleration.new=function(value)
  local _=item.new()
  local __=extend(_)
  _.constructor=constant_acceleration
  _.value=vector.new(value)
  return _
end
