force_user={}
force_user.new=function()
  local _=part.new()
  local __=extend(_)
  _.constructor=movable
  _.install=function(parent)
    __.install(parent)
    _.mass=parent.require_field(mass)
    _.force=parent.require_field(force)
    _.acceleration=parent.require_field(acceleration)
    parent.require(movable)
    _.position=parent.require_field(position)
    _.velocity=parent.require_field(velocity)
  end
  return _
end
