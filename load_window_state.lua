dofile( "lib/table.save-1.0.lua" )

local window_sizes_file = "saved_state/window_sizes_db.lua"
local window_sizes_table,err = table.load(window_sizes_file)
if window_sizes_table == nil then
    window_sizes_table = {}
end


saved_state =  window_sizes_table[get_class_instance_name()]

set_window_geometry( 
    saved_state.get_window_geometry[1],
    saved_state.get_window_geometry[2],
    saved_state.get_window_geometry[3],
    saved_state.get_window_geometry[4] 
) 

if saved_state.get_window_is_maximized then
    maximaze() 
end

if  saved_state.get_window_is_maximized_vertically  then
    maximized_vertically() 
end

if  saved_state.get_window_is_maximized_horizontally  then
    maximized_horizontally() 
end

