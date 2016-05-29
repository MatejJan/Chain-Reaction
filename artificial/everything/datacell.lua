data_cell={}
data_cell.new=function()
  local _={}
  _.constructor=data_cell
  _.install=function(parent) _.parent=parent end
  return _
end
