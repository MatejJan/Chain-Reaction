part={}
part.new=function()
  local _=item.new()
  local __=extend(_)
  _.constructor=part
  _.install=function(parent) _.parent=parent end
  _.uninstall=function() end
  return _
end
