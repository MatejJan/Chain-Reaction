function plus(a,b)
  local ap=a>0
  local bp=b>0
  local r=a+b
  if a==0 or b==0 then return r end
  local rp=r>0
  if ap==bp and rp~=ap then
    overflow(a,b,"+")
    return rp and -32768.0 or 32767.99
  end
  return r
end
function minus(a,b) return plus(a,-b) end
function mul(a,b)
  local ap=a>0
  local bp=b>0
  local r=a*b
  if r==0 then return 0 end
  local rp=r>0
  if (ap==bp)~=rp then
    overflow(a,b,"*")
    return rp and -32768.0 or 32767.99
  end
  return r
end
function vector_set(a,x,y) a.x=x a.y=y return a end
function vector_length_squared(a) return plus(mul(a.x,a.x),mul(a.y,a.y)) end
function vector_length(a) return sqrt(vector_length_squared(a)) end
function vector_normalize(a) local l=vector_length(a) return vector_set(a,a.x/l,a.y/l) end
function vector_negate(a) return vector_set(a,-a.x,-a.y) end
function vector_add(a,b,r) return vector_set(r,plus(a.x,b.x),plus(a.y,b.y)) end
function vector_subtract(a,b,r) return vector_set(r,minus(a.x,b.x),minus(a.y,b.y)) end
function vector_multiply(a,s,r) return vector_set(r,mul(a.x,s),mul(a.y,s)) end
function vector_dot(a,b) return plus(mul(a.x,b.x),mul(a.y,b.y)) end
function vector_transform(a,m,r) return vector_set(r,a.x*m.m11+a.y*m.m21+m.m31,a.x*m.m12+a.y*m.m22+m.m32) end
function vector_transform_normal(a,m,r) return vector_set(r,a.x*m.m11+a.y*m.m21,a.x*m.m12+a.y*m.m22) end
function vector_lerp(a,b,f,r) if (f<=0) then return vector_set(r,a.x,a.y) end if (f>=1) then return vector_set(r,b.x,b.y) end return vector_set(r,a.x+(b.x-a.x)*f,a.y+(b.y-a.y)*f) end
vector={}
vector.normalize=function(a) local b=vector.new(a) return vector_normalize(b) end
vector.negate=function(a) local b=vector.new(a) return vector_negate(b) end
vector.add=function(a,b) return vector_add(a,b,vector.new()) end
vector.subtract=function(a,b) return vector_subtract(a,b,vector.new()) end
vector.multiply=function(a,s) return vector_multiply(a,s,vector.new()) end
vector.dot=function(a,b) return vector_dot(a,b) end
vector.transform=function(a,m) return vector_transform(a,m,vector.new()) end
vector.transform_normal=function(a,m) return vector_transform_normal(a,m,vector.new()) end
vector.lerp=function(a,b,f) return vector_lerp(a,b,f,vector.new()) end
vector.zero=function() return vector.new() end
vector.one=function() return vector_set(vector.new(),1,1) end
vector.unit_x=function() return vector_set(vector.new(),1,0) end
vector.unit_y=function() return vector_set(vector.new(),0,1) end
vector.left=function() return vector_set(vector.new(),-1,0) end
vector.up=function() return vector_set(vector.new(),0,-1) end
vector.right=function() return vector_set(vector.new(),1,0) end
vector.down=function() return vector_set(vector.new(),0,1) end
vector.new=function(vx,y)
  local _={}
  _.set=function(vx,y) if type(vx)=="table" then _.x=vx.x _.y=vx.y else _.x=vx or 0 _.y=y or 0 end return _ end
  _.set(vx,y)
  _.length=function() return vector_length(_) end
  _.length_squared=function() return vector_length_squared(_) end
  _.normalize=function() return vector_normalize(_) end
  _.negate=function() return vector_negate(_) end
  _.add=function(b) return vector_add(_,b,_) end
  _.subtract=function(b) return vector_subtract(_,b,_) end
  _.multiply=function(s) return vector_multiply(_,s,_) end
  _.transform=function(m) return vector_transform(_,m,_) end
  _.transform_normal=function(m) return vector_transform_normal(_,m,_) end
  _.to_string=function() return "vector2(".._.x..", ".._.y..")" end
  _.print=function() print(_.to_string()) return _ end
  return _
end
