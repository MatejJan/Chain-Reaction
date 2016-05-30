force_user={}
force_user.new=function()
  local _=part.new()
  local __=extend(_)
  _.constructor=force_user
  _.install=function(parent)
    __.install(parent)
    _.mass=parent.require_field(mass)
    _.accumulated_force=parent.require_field(accumulated_force)
    _.accumulated_acceleration=parent.require_field(accumulated_acceleration)
    _.acceleration=parent.require_field(acceleration)
    parent.require(movable)
    _.position=parent.require_field(position)
    _.velocity=parent.require_field(velocity)
  end
  return _
end
