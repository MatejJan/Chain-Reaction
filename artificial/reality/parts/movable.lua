movable={}
movable.new=function()
  local _=part.new()
  local __=extend(_)
  _.constructor=movable
  _.install=function(parent)
    __.install(parent)
    _.position=parent.require_field(position)
    _.velocity=parent.require_field(velocity)
  end
  return _
end
