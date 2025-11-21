while true do
    local ok, err = pcall(function() shell.run("ae2_storage.lua") end)
    if not ok then print("Error: " .. err) end
    print("Export run at " .. textutils.formatTime(os.time(), true))
    os.sleep(60)
end