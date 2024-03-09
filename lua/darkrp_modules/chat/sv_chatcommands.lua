module("chatcommands", package.seeall)

List = {}

function Add(cmd, func)
    if cmd == nil then
        -- log.throw_error(LOG_ERROR_STOP, "received type null")
        return
    end

    List[#List + 1] = {
        Commands = cmd,
        Function = func
    }

    return #List
end

function Get(cmd)
    -- Could've been done better?
    for i = 1, #List do
        if table.HasValue(List[i].Commands, cmd) then
            return List[i].Function
        end
    end

    return nil
end

hook.Add("PlayerSay", "animelife.chatcommands.PlayerSay", function(ply, msg)
    -- At least it should look like a command
    if !string.StartWith(msg, "!") and !string.StartWith(msg, "/") then return end
    
    local cmd = utf8.sub(string.Split(msg, " ")[1], 2)
    local command = Get(cmd)
    if command ~= nil then
        -- Run command. No regrets.
        local func = command(ply, msg)
        if func == "" then return "" end
    end
end)

_G.CHATCOMMANDS = chatcommands
_G.ChatCommands = chatcommands
_G.chat_commands = chatcommands