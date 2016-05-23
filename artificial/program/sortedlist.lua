sorted_list={}
sorted_list.new=function()
  local _={}
  _.constructor=sorted_list
  local _items={}
  _.add=function(i,o)
    l=#_items
    p=1
    while(p<=l)do
      if _items[p].o<o then p+=1 else break end
    end
    for j=l,p,-1 do
      _items[j+1]=_items[j]
      _[j+1]=_[j]
    end
    _items[p]={i=i,o=o}
    _[p]=i
  end
  return _
end
