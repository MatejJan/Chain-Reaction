lab_renderer={}
lab_renderer.new=function(lab)
  local _={}
  local __=extend(_)
  _.constructor=lab_renderer
  _.render=function()
    --draw water
    local wave_width=16
    for x=0,127 do
      local a1=((x)%wave_width)/wave_width
      local a2=((x+wave_width/2)%wave_width)/wave_width
      local t1=sin(game_time/9) t1*=t1
      local t2=sin(game_time/7+0.25) t2*=t2
      local d1=-(sin(a1/2)*t1+t1)*2
      local d2=-(sin(a2/2)*t2+t2)*2
      pset(x,-lab.water.as(half_plane_collider).half_plane.distance+d1+d2,1)
    end
  end
  return _
end
