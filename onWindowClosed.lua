-- On window closed save windows state
dofile( "lib/table.save-1.0.lua" )


os.execute("mkdir saved_state")
local window_sizes_file = "saved_state/window_sizes_db.lua"
local window_sizes_table,err = table.load(window_sizes_file)
if window_sizes_table == nil then
    window_sizes_table = {}
end

curent_state =  {
    get_window_name = get_window_name() ,
    get_window_has_name = get_window_has_name() ,
    get_application_name = get_application_name() ,
    get_class_instance_name = get_class_instance_name() ,
    get_window_geometry = { get_window_geometry() } ,
    get_window_client_geometry = {get_window_client_geometry()} ,
    get_window_is_maximized = get_window_is_maximized() ,
    get_window_is_maximized_vertically = get_window_is_maximized_vertically() ,
    get_window_is_maximized_horizontally = get_window_is_maximized_horizontally() ,
    get_window_type = get_window_type() ,
    get_window_role = get_window_role() ,
    get_window_xid = get_window_xid() ,
    get_window_class = get_window_class() ,
    get_workspace_count = get_workspace_count() ,
    get_screen_geometry = {get_screen_geometry()}
}

function formatDbKey( get_class_instance_name,get_window_name, get_window_type)
    -- remove all before ' - ' inclusive
    res, count = string.gsub( get_window_name , ".* %- ", "")
    
    if string.find( res, '.*%/' ) ~= nil then
        res = ""
    end

    return get_class_instance_name .. " " .. res .. get_window_type
end

window_sizes_table[ formatDbKey(get_class_instance_name(),get_window_name(),get_window_type()) ] = curent_state


table.save(window_sizes_table, window_sizes_file)