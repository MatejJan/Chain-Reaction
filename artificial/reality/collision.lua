collision={}
collision.relax=function(i1,i2,vrd)
  local p1=0.5
  local p2=0.5
  local im1=i1.as(mass)
  local im2=i2.as(mass)
  local ip1=i1.as(position)
  local ip2=i2.as(position)
  if im1 and im2 then
    local m1=im1.value
    local m2=im2.value
    local m=m1+m2
    p1=m2/m
    p2=m1/m
  elseif im1 then
    p1=1
    p2=0
  elseif im2 then
    p1=0
    p2=1
  else
    if ip1 and not ip2 then
      p1=1
      p2=0
    elseif not ip1 and ip2 then
      p1=0
      p2=1
    end
  end
  if ip1 then ip1.value.subtract(vector.multiply(vrd,p1)) end
  if ip2 then ip2.value.add(vector.multiply(vrd,p2)) end
end
collision.collide=function(i1,i2,n)
  local vl1=vector.zero()
  local vl2=vector.zero()
  local iv1=i1.as(velocity)
  local iv2=i2.as(velocity)
  if iv1 then vl1.set(iv1.value) end
  if iv2 then vl2.set(iv2.value) end
  local cor=1
  local ic1=i1.as(coefficient_of_restitution)
  local ic2=i2.as(coefficient_of_restitution)
  if ic1 then cor=ic1.value end
  if ic2 then cor*=ic2.value end
  local s1=iv1 and vector.dot(iv1.value,n) or 0
  local s2=iv2 and vector.dot(iv2.value,n) or 0
  local s12=s1-s2
  local im1=i1.as(mass)
  local im2=i2.as(mass)
  local m1=im1 and im1.value or 0
  local m2=im2 and im2.value or nil
  local m1i=m1 and 1/m1 or 0
  local m2i=m2 and 1/m2 or 0
  local f=-(1+cor)*s12/(m1i+m2i)
  if iv1 then iv1.value.add(vector.multiply(n,f*m1i)) end
  if iv2 then iv2.value.subtract(vector.multiply(n,f*m2i)) end
end
