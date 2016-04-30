return text
  end
  end
 if matches[1]:lower() == 'اطلاعات' and not matches[2] then
  local receiver = get_receiver(msg)
  local Reply = msg.reply_id
  if msg.reply_id then
    msgr = get_message(msg.reply_id, action_by_reply, {receiver=receiver, Reply=Reply})
  else
  if msg.from.username then
   Username = '@'..msg.from.username
   else
   Username = 'ندارد'
   end
   local text = 'نام : '..(msg.from.first_name or 'ندارد')..'\n'
   local text = text..'فاميل : '..(msg.from.last_name or 'ندارد')..'\n'  
   local text = text..'يوزر : '..Username..'\n'
   local text = text..'ايدي کاربري : '..msg.from.id..'\n\n'
   local hash = 'rank:'..msg.to.id..':variables'
  if hash then
    local value = redis:hget(hash, msg.from.id)
    if not value then
    if msg.from.id == tonumber(creed) then
     text = text..'مقام : مدير کل ربات (Executive Admin) \n\n'
    elseif is_sudo(msg) then
     text = text..'مقام : ادمين ربات (Admin) \n\n'
    elseif is_owner(msg) then
     text = text..'مقام : مدير کل گروه (Owner) \n\n'
    elseif is_momod(msg) then
     text = text..'مقام : مدير گروه (Moderator) \n\n'
    else
     text = text..'مقام : کاربر (Member) \n\n'
    end
    else
     text = text..'مقام : '..value..'\n'
    end
  end
    
   local uhash = 'user:'..msg.from.id
    local user = redis:hgetall(uhash)
     local um_hash = 'msgs:'..msg.from.id..':'..msg.to.id
   user_info_msgs = tonumber(redis:get(um_hash) or 0)
   text = text..'تعداد پيام هاي فرستاده شده : '..user_info_msgs..'\n\n'
   if msg.to.type == 'chat' then
   text = text..'نام گروه : '..msg.to.title..'\n'
     text = text..'ايدي گروه : '..msg.to.id
    end
  text = text..'\n\nورژن ربات : 2.1'
    return send_msg(receiver, text, ok_cb, true)
    end
  end
  if matches[1]:lower() == 'اطلاعات' and matches[2] then
   local user = matches[2]
   local chat2 = msg.to.id
   local receiver = get_receiver(msg)
   if string.match(user, '^%d+$') then
    user_info('user#id'..user, action_by_id, {receiver=receiver, user=user, text=text, chat2=chat2})
    elseif string.match(user, '^@.+$') then
      username = string.gsub(user, '@', '')
      msgr = res_user(username, res_user_callback, {receiver=receiver, user=user, text=text, chat2=chat2})
   end
  end
end

return {
  description = 'Know your information or the info of a chat members.',
  usage = {
  '!info: Return your info and the chat info if you are in one.',
  },
  patterns = {
  "^(اطلاعات)$",
  "^(اطلاعات) (.*)$",
  "^(نصب مقام) (%d+) (.*)$",
  "^(نصب مقام) (.*)$",
  },
  run = run
}

end
