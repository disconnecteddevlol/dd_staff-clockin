local onDutyStaff = {}

local webhook = Config.Webhook
local departments = Config.Departments

-- Send logs to Discord
local function sendToDiscord(title, description, color)
    local embed = {{
        ["title"] = title,
        ["description"] = description,
        ["color"] = color,
        ["footer"] = { ["text"] = "Staff Clockin Logs" },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}

    PerformHttpRequest(webhook, function() end, "POST", json.encode({
        username = "Staff Duty Logs",
        embeds = embed
    }), { ["Content-Type"] = "application/json" })
end

-- Clock in
RegisterNetEvent("mirp:staffClockIn", function(data)
    local src = source
    local department = data.department
    local acePerm = "dd_staff-duty." .. string.lower(department)

    -- ✅ Check ACE permission
    if not IsPlayerAceAllowed(src, acePerm) then
        TriggerClientEvent("okokNotify:Alert", src, "Duty System", "❌ You don’t have permission for this department", 5000, "error")
        return
    end

    onDutyStaff[src] = data

    print(("%s clocked in as %s (%s)"):format(data.name, data.department, data.callsign))
    TriggerClientEvent("mirp:clockInSuccess", src, data)

    sendToDiscord(
        "Staff Clocked In",
        ("**Name:** %s\n**Department:** %s\n**Callsign:** %s\n**Server ID:** %s"):format(data.name, department, data.callsign, src),
        65280
    )
end)

-- Clock out
RegisterNetEvent("mirp:staffClockOut", function()
    local src = source
    if onDutyStaff[src] then
        local data = onDutyStaff[src]

        print(("%s clocked out"):format(data.name))
        TriggerClientEvent("mirp:clockOutSuccess", src, data)

        sendToDiscord(
            "Staff Clocked Out",
            ("**Name:** %s\n**Department:** %s\n**Callsign:** %s\n**Server ID:** %s"):format(data.name, data.department, data.callsign, src),
            16711680
        )
        onDutyStaff[src] = nil
    else
        TriggerClientEvent("okokNotify:Alert", src, "Duty System", "❌ You are not clocked in!", 5000, "error")
    end
end)

-- Handle disconnects
AddEventHandler("playerDropped", function()
    local src = source
    if onDutyStaff[src] then
        local data = onDutyStaff[src]
        sendToDiscord(
            "🚪 Staff Disconnected",
            ("**Name:** %s\n**Department:** %s\n**Callsign:** %s\n**Server ID:** %s"):format(data.name, data.department, data.callsign, src),
            16776960
        )
        onDutyStaff[src] = nil
    end
end)
