circle_collider={}
circle_collider.new=function()
  local _=part.new()
  local __=extend(_)
  _.constructor=circle_collider
  _.install=function(parent)
    __.install(parent)
    _.position=parent.require_field(position)
    _.radius=parent.require_field(radius)
  end
  return _
end
