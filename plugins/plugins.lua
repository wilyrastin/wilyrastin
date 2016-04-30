end
— Disable a plugin on a chat
if matches[1] == 'disable' and matches[3] == 'chat' then
local plugin = matches[2]
local receiver = get_receiver(msg)
print("disable "..plugin..' on this chat')
return disable_plugin_on_chat(receiver, plugin)
end
— Disable a plugin
if matches[1] == 'disable' and is_sudo(msg) then —after changed to moderator mode, set only sudo
if matches[2] == 'plugins' then
return 'This plugin can\'t be disabled'
end
print("disable: "..matches[2])
return disable_plugin(matches[2])
end
— Reload all the plugins!
if matches[1] == 'reload' and is_sudo(msg) then —after changed to moderator mode, set only sudo
return reload_plugins(true)
end
end
return {
description = "Plugin to manage other plugins. Enable, disable or reload.",
usage = {
moderator = {
"!plugins disable [plugin] chat : disable plugin only this chat.",
"!plugins enable [plugin] chat : enable plugin only this chat.",
},
sudo = {
"!plugins : list all plugins.",
"!plugins enable [plugin] : enable plugin.",
"!plugins disable [plugin] : disable plugin.",
"!plugins reload : reloads all plugins." },
},
patterns = {
"^!plugins$",
"^!plugins? (enable) ([%w_%.%-]+)$",
"^!plugins? (disable) ([%w_%.%-]+)$",
"^!plugins? (enable) ([%w_%.%-]+) (chat)",
"^!plugins? (disable) ([%w_%.%-]+) (chat)",
"^!plugins? (reload)$" },
run = run,
moderated = true, — set to moderator mode
—privileged = true
}
end
