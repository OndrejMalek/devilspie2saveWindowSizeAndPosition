
function get_window_sizes_file()
    window_sizes_file = "saved_state/window_sizes_db.lua"
    return window_sizes_file
end

function format_window_size_db_key()
    --Guess work how to separate different windows

    -- remove all before ' - ' inclusive and words with non alphanumeric values
    res, count = string.gsub( str , ".* %- ", ""):gsub("%w*[\\%^%$%(%)%%%.%[%]%*%+%-%?%/]%w*","")

    -- -- discard when contains '/'
    -- if string.find( res, '.*%/' ) ~= nil then
    --     res = ""
    -- end

    return get_class_instance_name() .. " " .. res .. get_window_type()
end

return{
    format_window_size_db_key = format_window_size_db_key,
    get_window_sizes_file = get_window_sizes_file
}