util.AddNetworkString("animelife.jobabilities.musiclover.play_track")
util.AddNetworkString("animelife.jobabilities.musiclover.stop_track")

-- Soundcloud API
local client_id = "2e0e541854cbabd873d647c1d45f79e8"
local resolve = "http://api.soundcloud.com/resolve.json?url=%s&client_id="

function BoomboxPlay(ply, url)
    local sound_type = "def"
    if string.StartWith(url, "http") or string.StartWith(url, "www") then
        if url:find("soundcloud.com") then
            sound_type = "soundcloud"
        else
            sound_type = "def"
        end
    else
        return
    end

    local processed_url = url
    local song_name = "Unknown Artist - Unknown Track"
    if sound_type == "soundcloud" then
       local function callback(stream, name)
            processed_url = stream .. "?client_id=" .. client_id
            song_name = name

            net.Start("animelife.jobabilities.musiclover.play_track")
                net.WriteEntity(ply)
                net.WriteString(processed_url)
                net.WriteString(song_name)
            net.Broadcast()
       end 

       http.Fetch(string.format(resolve, url) .. client_id, function(body, len, headers, code)
            local resp = util.JSONToTable(body)
            local stream = resp.stream_url
            local artist = resp.user and resp.user.username or "Unknown Artist"
            local title = artist .. " - " .. (resp.title or "Unknown Track")
            callback(stream, title)
        end)
    else
        net.Start("animelife.jobabilities.musiclover.play_track")
            net.WriteEntity(ply)
            net.WriteString(processed_url)
            net.WriteString(song_name)
        net.Broadcast()
    end
end

concommand.Add("animelife_boombox", function(ply, cmd, args, arg_str)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    if ply:Team() ~= TEAM_MUSILY then return end

    BoomboxPlay(ply, args[1])
end)

concommand.Add("animelife_boombox_stop", function(ply, cmd)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    if ply:Team() ~= TEAM_MUSILY then return end

    net.Start("animelife.jobabilities.musiclover.stop_track")
    net.Broadcast()
end)

hook.Add("PlayerButtonDown", "animelife.jobabilities.musiclover.volume", function(ply, btn)
    if btn ~= MOUSE_RIGHT then return end
    if ply:Team() ~= TEAM_MUSILY then return end

    local last_vol = ply:GetNWFloat("animelife.jobabilities.musiclover.volume", 1)
    if last_vol < 0.9 then
        ply:SetNWFloat("animelife.jobabilities.musiclover.volume", last_vol + 0.1)
    else
        ply:SetNWFloat("animelife.jobabilities.musiclover.volume", 0)
    end
end)