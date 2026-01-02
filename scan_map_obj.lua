print("════════ START MAP SCAN ════════")

-- 1. Cek Folder Checkpoints/Stages
local folders = {"Checkpoints", "Stages", "Stage", "Points", "Levels"}
for _, name in pairs(folders) do
    local folder = workspace:FindFirstChild(name, true)
    if folder then
        print("📁 Folder Ditemukan: " .. folder:GetFullName())
        local children = folder:GetChildren()
        print("   Isi Folder (5 teratas):")
        for i = 1, math.min(5, #children) do
            print("   - " .. children[i].Name .. " (" .. children[i].ClassName .. ")")
        end
    end
end

-- 2. Cek Objek dengan nama mencurigakan (Finish/Win)
print("\n🔎 Mencari Objek Finish:")
for _, v in pairs(workspace:GetDescendants()) do
    -- Filter nama-nama umum
    if v.Name:match("Win") or v.Name:match("Finish") or v.Name:match("End") or v.Name:match("Goal") or v.Name:match("Trophy") then
        if v:IsA("BasePart") or v:IsA("Model") then
            print("🎯 POTENSI TARGET: " .. v:GetFullName() .. " (" .. v.ClassName .. ")")
            -- Cetak posisi jika ada
            if v:IsA("BasePart") then
                print("   Posisi: " .. tostring(v.Position))
            elseif v:IsA("Model") then
                print("   Posisi: " .. tostring(v:GetPivot().Position))
            end
        end
    end
end

print("════════ END MAP SCAN ════════")