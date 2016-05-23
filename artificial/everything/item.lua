item={}
item.new=function()
  local _={}
  _.constructor=item
  _.parts={}
  _.add=function(p)
    _.parts[p.constructor] = p
    if p.install then p.install(_) end
  end
  _.remove=function(p) _.parts[p.constructor]=nil end
  _.as=function(t) if t==_.constructor then return _ end return _.parts[t] end
  _.has=function(t) return _.parts[t]~=nil end
  _.require=function(t)
    local p=_.as(t)
    if p==nil then
      p=t.new()
      _.add(p)
    end
    return p
  end
  _.require_field=function(t)
    local p=_.require(t)
    return field(p)
  end
  return _
end
