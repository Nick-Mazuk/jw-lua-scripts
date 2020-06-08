function plugindef()
    finaleplugin.RequireSelection = true
    finaleplugin.Author = "Nick Mazuk"
    finaleplugin.Version = "1.0"
    finaleplugin.Copyright = "CC0 https://creativecommons.org/publicdomain/zero/1.0/"
    finaleplugin.Date = "6/6/2020"
    finaleplugin.CategoryTags = "Expression"
    finaleplugin.AuthorURL = "https://nickmazuk.com"
    return "Move Expression Baseline Up", "Move Expression Baseline Up",
           "Moves the selected expression baseline up one space"
end

function ToEvpus(text)
    local str = finale.FCString()
    str.LuaString = text
    return str:GetMeasurement(finale.MEASUREMENTUNIT_DEFAULT)
end

function expression_baseline_move_up()
    local region = finenv.Region()
    local systems = finale.FCStaffSystems()
    systems:LoadAll()

    local start_measure = region:GetStartMeasure()
    local end_measure = region:GetEndMeasure()
    local system = systems:FindMeasureNumber(start_measure)
    local lastSys = systems:FindMeasureNumber(end_measure)
    local system_number = system:GetItemNo()
    local lastSys_number = lastSys:GetItemNo()
    local start_staff = region:GetStartStaff()
    local end_staff = region:GetEndStaff()

    for i = system_number, lastSys_number, 1 do
        local baselines = finale.FCBaselines()
        baselines:LoadAllForSystem(finale.BASELINEMODE_EXPRESSIONABOVE, i)
        for j = start_staff, end_staff, 1 do
            bl = baselines:AssureSavedStaff(finale.BASELINEMODE_EXPRESSIONABOVE, i, j)
            bl.VerticalOffset = bl.VerticalOffset + ToEvpus("1s")
            bl:Save()
        end
    end
end

expression_baseline_move_up()