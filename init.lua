--chain reaction
dt=1/30
game_time=0

game=item.new()
game.add(simulator.new())
game.add(renderer.new())

overflow_info=nil
overflow_count=0
overflow=function(a,b,op)
  overflow_count+=1
  overflow_info={a=a,b=b,op=op}
end

debug_text=nil
debug=function(text)
  debug_text=text
end

_lab=lab.new(0)
game.add(_lab)

function _init()
  cls()
end

function _update()
  game_time+=dt
  game.as(simulator).simulate()
end

function _draw()
  cls()
  game.as(renderer).render()

  if overflow_info then
    print(overflow_count.."x overflow "..overflow_info.a.." "..overflow_info.op.." "..overflow_info.b,3,121,8)
    rect(0,0,127,127,8)
  end
  overflow_count=0
  overflow_info=nil

  if debug_text then
    print(debug_text,3,3,5)
  end
  debug_text=nil
end
