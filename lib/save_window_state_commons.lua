
function get_window_sizes_file()
    window_sizes_file = os.getenv( "HOME" ) .. "/.config/devilspie2/saved_state/window_sizes_db.lua"
    return window_sizes_file
end

function get_window_sizes_file_dir()
    window_sizes_file = os.getenv( "HOME" ) .. "/.config/devilspie2/saved_state"
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

-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint (tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
      formatting = string.rep("  ", indent) .. k .. ": "
      if type(v) == "table" then
        print(formatting)
        tprint(v, indent+1)
      elseif type(v) == 'boolean' then
        print(formatting .. tostring(v))      
      else
        print(formatting .. v)
      end
    end
  end


return{
    format_window_size_db_key = format_window_size_db_key,
    get_window_sizes_file = get_window_sizes_file,
    get_window_sizes_file_dir = get_window_sizes_file_dir,
    tprint = tprint
}