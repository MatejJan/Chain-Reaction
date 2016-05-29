function print_deep(o,d)
  if d==nil then d=1 end
  local t=type(o)
  if t=="table" and d>0 then
    for k,v in pairs(o) do
      if k and v then
        local line="xx"
        if type(k)=="table" then
          line="[table]="
        else
          line=k.."="
        end
        if type(v)=="table" and v.print then
          print(line)
          v.print()
        else
          if d==1 then
            local tv=type(v)
            if tv=="table" then
              print(line.."table")
            elseif tv=="function" then
              print(line.."function")
            else
              print(line..v)
            end
          else
            print(line)
            print_deep(v,d-1)
          end
        end
      else
        print(k.."=nil")
      end
    end
  else
    print(o)
  end
end
