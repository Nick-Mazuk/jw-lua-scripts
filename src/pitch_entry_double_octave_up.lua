function plugindef()
    finaleplugin.RequireSelection = true
    finaleplugin.Author = "Nick Mazuk"
    finaleplugin.Copyright = "CC0 https://creativecommons.org/publicdomain/zero/1.0/"
    finaleplugin.Version = "1.0.2"
    finaleplugin.Date = "March 31, 2021"
    finaleplugin.CategoryTags = "Pitch"
    finaleplugin.AuthorURL = "https://nickmazuk.com"
    return "Octave Doubling Up", "Octave Doubling Up", "Doubles the current note an octave higher"
end

local path = finale.FCString()
path:SetRunningLuaFolderPath()
package.path = package.path .. ";" .. path.LuaString .. "?.lua"
local transposition = require("library.transposition")
local note_entry = require("Library.note_entry")

function pitch_entry_double_octave_up()
    for entry in eachentrysaved(finenv.Region()) do
        local note_count = entry.Count
        local note_index = 0
        for note in each(entry) do
            note_index = note_index + 1
            if note_index > note_count then
                break
            end
            local new_note = note_entry.duplicate_note(note)
            if nil ~= new_note then
                transposition.change_octave(new_note, 1)
            end
        end
    end
end

pitch_entry_double_octave_up()
