function nil_to_str( str )
    if str == nil then
        return ""
    else
        return str
    end
end

cwd = nil_to_str(debug.getinfo(1).source:match("@?(.*/)"))
dofile(cwd.."lib/table.save-1.0.lua")
dofile(cwd.."lib/save_window_state_commons.lua")

local window_sizes_table,err = table.load(get_window_sizes_file())
if window_sizes_table == nil then
    window_sizes_table = {}
end
key = format_window_size_db_key()
saved_state = window_sizes_table[key]
print("Loading window state with key = " .. key .. " ")

if saved_state ~= nil then
    tprint(saved_state)

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
        maximize_vertically() 
    end

    if  saved_state.get_window_is_maximized_horizontally  then
        maximize_horizontally() 
    end

else
    print("no state found")
end

print("")

