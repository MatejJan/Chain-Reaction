physics_renderer={}
physics_renderer.new=function(s)
  local _={}
  local __=extend(_)
  _.constructor=physics_renderer
  _.draw=function()
    for i in all(s.items) do
      pos = i.as(position)
      cc = i.as(circle_c)
      if pos then
        line(pos.value.x,pos.value.y-1,pos.value.x,pos.value.y+1,10)
        line(pos.value.x-1,pos.value.y,pos.value.x+1,pos.value.y,10)
      end
      if cc then
        circ(cc.position().x,cc.position().y,cc.radius(),3)
      end
    end
  end
  return _
end
