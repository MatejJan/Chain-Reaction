function v2_set(a,x,y) a.x=x a.y=y return a end
function v2_length_squared(a) return a.x*a.x+a.y+a.y end
function v2_length(a) return sqrt(v2_length_squared(a)) end
function v2_normalize(a) local l=v2_length(a) return v2_set(a.x/l,a.y/l) end
function v2_negate(a) return v2_set(a,-a.x,-a.y) end
function v2_add(a,b,r) return v2_set(r,a.x+b.x,a.y+b.y) end
function v2_subtract(a,b,r) return v2_set(r,a.x-b.x,a.y-b.y) end
function v2_multiply(a,s,r) return v2_set(r,a.x*s,a.y*s) end
function v2_dot(a,b) return a.x*b.x+a.y*b.y end
function v2_transform(a,m,r) return v2_set(r,a.x*m.m11+a.y*m.m21+m.m31,a.x*m.m12+a.y*m.m22+m.m32) end
function v2_transform_normal(a,m,r) return v2_set(r,a.x*m.m11+a.y*m.m21,a.x*m.m12+a.y*m.m22) end
function v2_lerp(a,b,f,r) if (f<=0) then return v2_set(r,a.x,a.y) end if (f>=1) then return v2_set(r,b.x,b.y) end return v2_set(r,a.x+(b.x-a.x)*f,a.y+(b.y-a.y)*f) end
v2={}
v2.normalize=function(a) return v2_normalize(a) end
v2.negate=function(a) return v2_negate(a) end
v2.add=function(a,b) return v2_add(a,b,v2.new()) end
v2.subtract=function(a,b) return v2_subtract(a,b,v2.new()) end
v2.multiply=function(a,s) return v2_multiply(a,s,v2.new()) end
v2.dot=function(a,b) return v2_dot(a,b) end
v2.transform=function(a,m) return v2_transform(a,m,v2.new()) end
v2.transformNormal=function(a,m) return v2_transform_normal(a,m,v2.new()) end
v2.lerp=function(a,b,f) return v2_lerp(a,b,f,v2.new()) end
v2.zero=function() return v2.new() end
v2.one=function() return v2_set(v2.new(),1,1) end
v2.unit_x=function() return v2_set(v2.new(),1,0) end
v2.unit_y=function() return v2_set(v2.new(),0,1) end
v2.new=function(x,y)
  local _={x=x or 0,y=y or 0}
  _.set=function(x,y) _.x=x or 0 _.y=y or 0 end
  _.length=function() return v2_length(_) end
  _.lengthSquared=function() return v2_length_squared(_) end
  _.normalize=function() return v2_normalize(_) end
  _.negate=function() return v2_negate(_) end
  _.add=function(b) return v2_add(_,b,_) end
  _.subtract=function(b) return v2_subtract(_,b,_) end
  _.multiply=function(s) return v2_multiply(_,s,_) end
  _.transform=function(m) return v2_transform(_,m,_) end
  _.transform_normal=function(m) return v2_transform_normal(_,m,_) end
  _.print=function() print("vector2(".._.x..", ".._.y..")") return _ end
  return _
end
