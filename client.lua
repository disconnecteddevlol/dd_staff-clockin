local onDuty = false

-- Build department options from Config or fallback
local function getDepartmentOptions()
    local options = {}

    if Config and Config.Departments then
        for deptName, _ in pairs(Config.Departments) do
            table.insert(options, { value = deptName, label = deptName })
        end
    else
        -- fallback if Config is nil (prevents crashes)
        options = {
            { value = "CIA", label = "CIA" },
            { value = "Staff", label = "Staff Team" },
            { value = "DHS", label = "DHS" },
            { value = "Staff Trainer", label = "Staff Trainer" }
        }
    end

    return options
end

-- Open duty menu with /clockin
RegisterCommand("clockin", function()
    if onDuty then
        TriggerEvent("okokNotify:Alert", "Duty System", "You are already clocked in!", 5000, "error")
        return
    end

    local input = lib.inputDialog("Staff Duty Clock-In", {
        { type = "input", label = "Name", placeholder = "disconnected" },
        { type = "input", label = "Callsign", placeholder = "101" },
        { 
            type = "select", 
            label = "Department", 
            options = getDepartmentOptions()
        }
    })

    if not input then return end -- menu closed

    local data = {
        name = input[1],
        callsign = input[2],
        department = input[3]
    }

    TriggerServerEvent("mirp:staffClockIn", data)
end)

-- /clockout
RegisterCommand("clockout", function()
    if not onDuty then
        TriggerEvent("okokNotify:Alert", "Duty System", "You are not clocked in!", 5000, "error")
        return
    end
    TriggerServerEvent("mirp:staffClockOut")
end)

-- Success events from server
RegisterNetEvent("mirp:clockInSuccess", function(data)
    onDuty = true
    TriggerEvent("okokNotify:Alert", "Duty System", "Clocked-in successfully", 5000, "success")
end)

RegisterNetEvent("mirp:clockOutSuccess", function(data)
    onDuty = false
    TriggerEvent("okokNotify:Alert", "Duty System", "Clocked out successfully", 5000, "success")
end)
