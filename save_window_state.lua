-- On window closed save windows state
dofile( "lib/table.save-1.0.lua" )
local commons = require("lib.save_window_state_commons")

local function save_to_file()
curent_state =  {
        index = window_sizes_table.index,
        last_modified_epoch = os.execute("date +%s"),
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
    window_sizes_table[ format_window_size_db_key() ] = curent_state
    
    table.save(window_sizes_table, get_window_sizes_file())
end

local function increment_table_ring_buffer()
    -- incremment size and index of table
    if window_sizes_table.size == nil then
        window_sizes_table.size = 1
        window_sizes_table.index = 1
    else
        window_sizes_table.size = window_sizes_table.size + 1
        window_sizes_table.index = window_sizes_table.index + 1
    end
end


local function circle_table_ring_buffer()
    -- remove oldest items 
    local MAX_SAVE_SIZE = 400
    local REMOVE_ITEM_COUNT = 10

    if window_sizes_table.size > MAX_SAVE_SIZE then
        window_sizes_table.index = window_sizes_table.index % MAX_SAVE_SIZE
        for app_name,app_saved_state in pairs(window_sizes_table) do
            if app_saved_state.index > 0 + window_sizes_table.index and app_saved_state <= REMOVE_ITEM_COUNT + window_sizes_table.index then
                window_sizes_table = table.remove( window_sizes_table, app_name )
            end 
        end
    
        window_sizes_table.size = MAX_SAVE_SIZE - REMOVE_ITEM_COUNT
    end
end

local function sortByIndex (a, b )
    if (a.index < b.index) then
           return true
    end
end



os.execute("mkdir saved_state")

window_sizes_table,err = table.load(get_window_sizes_file())
if window_sizes_table == nil then
    window_sizes_table = {}
end

increment_table_ring_buffer()
circle_table_ring_buffer()
save_to_file()