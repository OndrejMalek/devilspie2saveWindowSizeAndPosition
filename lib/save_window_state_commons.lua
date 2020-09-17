
function get_window_sizes_file()
    window_sizes_file = "saved_state/window_sizes_db.lua"
    return window_sizes_file
end

function format_window_size_db_key()
    --Guess work how to separate different windows

    -- remove all before ' - ' inclusive and words with non alphanumeric values
    if get_window_name() ~= nil then
        res, count = string.gsub( get_window_name() , ".* %- ", ""):gsub("%w*[\\%^%$%(%)%%%.%[%]%*%+%-%?%/]%w*","")
    end

    -- -- discard when contains '/'
    -- if string.find( res, '.*%/' ) ~= nil then
    --     res = ""
    -- end

    return nil_to_str(get_class_instance_name()) .. " " .. nil_to_str(res) .. nil_to_str(get_window_type())
end

function nil_to_str( str )
    if str == nil then
        return ""
    else
        return str
    end
end

return{
    format_window_size_db_key = format_window_size_db_key,
    get_window_sizes_file = get_window_sizes_file
}