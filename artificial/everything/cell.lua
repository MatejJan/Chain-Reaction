cell={}
cell.new=function()
  local _={}
  _.constructor=cell
  _.install=function(parent) _.parent=parent end
  return _
end
