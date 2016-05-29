physics_renderer={}
physics_renderer.new=function(s)
  local _={
    position=true,
    velocity=false,
    geometry=true
  }
  local __=extend(_)
  _.constructor=physics_renderer
  _.draw=function()
    for i in all(s.items) do
      local p = i.as(position)
      local v = i.as(velocity)
      local cc = i.as(circle_collider)
      local hpc = i.as(half_plane_collider)
      if p then
        if _.position then
          line(p.value.x,p.value.y-1,p.value.x,p.value.y+1,10)
          line(p.value.x-1,p.value.y,p.value.x+1,p.value.y,10)
        end
        if v and _.velocity then
          local d=vector.multiply(v.value, 2)
          line(p.value.x,p.value.y,p.value.x+d.x,p.value.y+d.y,11)
        end
      end
      if cc and _.geometry then
        circ(p.value.x,p.value.y,cc.radius(),3)
      end
      if hpc and _.geometry then
        local hp=hpc.half_plane
        local n=hp.normal
        if n.x==0 then
          local y=n.y*hp.distance
          line(-1000,y,1000,y,3)
        elseif n.y==0 then
          local x=n.x*hp.distance
          line(x,-1000,x,1000,3)
        else
          local k=-n.x/n.y
          local p=vector.multiply(n,hp.distance)
          line(p.x-1000,p.y-1000*k,p.x+1000,p.y+1000*k,3)
        end
      end
    end
  end
  return _
end
