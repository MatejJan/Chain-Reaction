particle={}
particle.new=function()
  local _=part.new()
  local __=extend(_)
  _.constructor=movable
  _.install=function(parent)
    __.install(parent)
    parent.require(movable)
    parent.require(force_user)
    parent.require(circle_c)
    _.position=parent.require_field(position)
    _.velocity=parent.require_field(velocity)
    _.mass=parent.require_field(mass)
    _.force=parent.require_field(force)
    _.acceleration=parent.require_field(acceleration)
    _.r=parent.require_field(radius)
  end
  return _
end
