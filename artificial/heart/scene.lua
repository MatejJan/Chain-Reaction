scene={}
scene.new=function()
  local _={}
  _.constructor=scene
  _.items={}
  _.add=function(i) add(_.items,i) end
  _.remove=function(i) del(_.items,i) end
  return _
end
