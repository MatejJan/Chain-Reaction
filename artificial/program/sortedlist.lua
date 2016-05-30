sorted_list={}
sorted_list.new=function()
  local _={}
  _.constructor=sorted_list
  local _items={}
  _.add=function(item, order)
    local l=#_items
    local p=1
    while(p<=l)do
      if _items[p].order<order then p+=1 else break end
    end
    for j=l,p,-1 do
      _items[j+1]=_items[j]
      _[j+1]=_[j]
    end
    _items[p]={item=item,order=order}
    _[p]= item
  end
  _.remove=function(item)
    local i=1
    local l=#_items
    while(_[i]~=item and i<=l)do
      i+=1
    end
    if i>l then return end
    for j=i,l-1,1 do
      _items[j]=_items[j+1]
      _[j]=_[j+1]
    end
    _items[l]=nil
    _[l]=nil
  end
  return _
end
