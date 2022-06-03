local addonName, addon = ...
addon.Utils = {}

local Utils = addon.Utils
local type, ipairs, pairs = type, ipairs, pairs
local floor, random = math.floor, math.random
local setmetatable, getmetatable = setmetatable, getmetatable
local tinsert, tremove, twipe = table.insert, table.remove, table.wipe
local find, match = string.find, string.match
local format, gsub = string.format, string.gsub
local strsub, strlen = string.sub, string.len
local lower, upper = string.lower, string.upper
local select = select
local GetLocale = GetLocale

-- Shuffle a table:
_G.table.shuffle = function(t)
	local n = #t
	while n > 2 do
		local k = random(1, n)
		t[n], t[k] = t[k], t[n]
		n = n - 1
	end
end

-- Fills a table (t1) with missing values from another (t2):
function Utils.fillTable(t1, t2)
	for i, v in pairs(t2) do
		if t1[i] == nil then
			t1[i] = v
		elseif type(v) == "table" then
			Utils.fillTable(v, t2[i])
		end
	end
end

-- DeepCopy:
_G.table.deepCopy = function(t)
	if type(t) ~= "table" then return t end
    local mt = getmetatable(t)
    local res = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            v = _G.table.deepCopy(v)
        end
        res[k] = v
    end
    setmetatable(res, mt)
    return res
end

-- Reverse table:
_G.table.reverse = function(t, count)
	local i, j = 1, #t
	while i < j do
		t[i], t[j] = t[j], t[i]
		i = i + 1
		j = j - 1
	end
end

-- Trim a string:
_G.string.trim = function(str)
	return gsub(str, "^%s*(.-)%s*$", "%1")
end

-- String starts with:
_G.string.startsWith = function(str, piece)
	return strsub(str, 1, strlen(piece)) == piece
end

-- String ends with:
_G.string.endsWith = function(str, piece)
	return #str >= #piece and find(str, #str - #piece + 1, true) and true or false
end

-- Uppercase first:
_G.string.ucfirst = function(str)
	str = lower(str)
	return gsub(str, "%a", upper, 1)
end

-- Determines if a given string is a number
function Utils.isNumber(str)
	local valid = false
	if str then
		valid = find(str, "^(%d+%.?%d*)$")
	end
	return valid
end

-- Determines if the given string is non-empty:
function Utils.isString(str)
	return (str and strlen(str) > 0)
end

-- Math Clamp
_G.math.clamp = function(val, min, max)
	if val and val <= min then
		return min
	elseif val and val >= max then
		return max
	end
	return val
end

-- math.round
_G.math.round = function(num, idp)
	if idp and idp > 0 then
		local mult = 10^idp
		return floor(num * mult + 0.5) / mult
	end
	return floor(num + 0.5)
end

-- RBG to Hex:
function Utils.rgb2hex(r, g, b)
	return format("%02x%02x%02x", r * 255, g * 255, b * 255)
end

-- Enable/Disable Frame:
function Utils.enableDisable(frame, cond)
	if frame == nil then
		return
	elseif cond and frame:IsEnabled() == 0 then
		frame:Enable()
	elseif not cond and frame:IsEnabled() == 1 then
		frame:Disable()
	end
end

-- Unconditional show/hide frame:
function Utils.toggle(frame)
	if frame == nil then
		return
	elseif frame:IsVisible() then
		frame:Hide()
	else
		frame:Show()
	end
end

-- Conditional Show/Hide Frame:
function Utils.showHide(frame, cond)
	if frame == nil then
		return
	elseif cond and not frame:IsShown() then
		frame:Show()
	elseif not cond and frame:IsShown() then
		frame:Hide()
	end
end

-- Lock/Unlock Highlight:
function Utils.toggleHighlight(frame, cond)
	if frame == nil then
		return
	elseif cond then
		frame:LockHighlight()
	else
		frame:UnlockHighlight()
	end
end

-- Set frameent text with condition:
function Utils.setText(frame, str1, str2, cond)
	if frame == nil then
		return
	elseif cond then
		frame:SetText(str1)
	else
		frame:SetText(str2)
	end
end

-- Return with IF:
function Utils.returnIf(cond, a, b)
	return (cond ~= nil and cond ~= false) and a or b
end

-------------------
-- Tasks Manager --
-------------------
do
	-- Table of scheduled tasks:
	local tasks = {}

	-- Schedule a task:
	function Utils.schedule(sec, func, ...)
		local task = {}
		task.time = time() + sec
		task.func = func
		for i = 1, select("#", ...) do
			task[i] = select(i, ...)
		end
		tasks[#tasks+1] = task
		tinsert(tasks, task)
	end

	-- Unschedule a task:
	function Utils.unschedule(func)
		for i, v in pairs(tasks) do
			if func == v.func then
				tremove(tasks, i)
				break
			end
		end
	end

	-- Run all scheduled tasks:
	function Utils.run()
		local now = time()
		for i = 1, #tasks do
			local task = tasks[i]
			if task and type(task.func) == "function" and task.time <= now then
				task.func(unpack(task))
				tremove(tasks, i) -- Only once!
			end
		end
	end
end

-- Periodic frame update:
function Utils.periodic(frame, name, period, elapsed)
	local t = frame[name] or 0
	t = t + elapsed
	if t > period then
		frame[name] = 0
		return true
	end
	frame[name] = t
	return false
end

-- Check entry in a table:
function Utils.checkEntry(t, val)
	for i, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

-- Remove all val occurrences from a table:
function Utils.removeEntry(t, val)
	local removed = false
	for i = #t, 1, -1 do
		if t[i] == val then
			tremove(t, i)
			removed = true
		end
	end
	return removed
end

-- Returns the "real" table's length:
function Utils.tableLen(t)
	local len = 0
	for _, _ in pairs(t) do
		len = len + 1
	end
	return len
end

-- Checks if a table is empty
function Utils.isEmpty(t)
	return (Utils.tableLen(t) == 0)
end

-- Boolean <> String conversion:
function Utils.bool2str(bool)
	return bool and "true" or "false"
end
function Utils.str2bool(str)
	return (str ~= "false")
end

-- Number <> Boolean conversion:
function Utils.bool2num(bool)
	return bool and 1 or 0
end
function Utils.num2bool(num)
	return (num ~= 0)
end

-- Convert seconds to readable clock string:
function Utils.sec2clock(seconds)
	local sec = tonumber(seconds)
	if sec <= 0 then
		return "00:00:00"
	end
	local hours, mins, secs
	hours = format("%02.f", floor(sec / 3600))
	mins  = format("%02.f", floor(sec / 60 - (hours * 60)))
	secs  = format("%02.f", floor(sec - hours * 3600 - mins * 60))
	return hours..":"..mins..":"..secs
end

-- Messages functions:
do
	local CHAT_FRAME = DEFAULT_CHAT_FRAME
	function Utils._print(opt, ...)
		if not CHAT_FRAME then return end
		local msg, num = "", select("#", ...)
		for i = 1, num do
			local m
			local v = select(i, ...)
			if type(v) == "boolean" then
				m = Utils.bool2str(v)
			elseif type(v) == "table" then
				m ="<table>"
			elseif type(v) == "function" then
				m ="<function>"
			elseif v == nil then
				m ="<nil>"
			else
				m = v
			end
			msg = msg.." "..m
		end
		if opt.str then
			return msg
		elseif opt.r ~= nil then
			CHAT_FRAME:AddMessage(msg, opt.r, opt.g, opt.b)
		else
			CHAT_FRAME:AddMessage(msg)
		end
	end

	function Utils.print(...)
		local opt = {}
		return Utils._print(opt, ...)
	end

	function Utils.print_str(...)
		local opt = {}
		opt.str = true
		return Utils._print(opt, ...)
	end

	function Utils.print_color(r, g, b, ...)
		local opt = {}
		opt.r = r
		opt.g = g
		opt.b = b
		return Utils._print(opt, ...)
	end

	function Utils.print_gold(...)
		return Utils.print_color(1.00, 0.82, 0.00, ...)
	end
	function Utils.print_gray(...)
		return Utils.print_color(0.50, 0.50, 0.50, ...)
	end
	function Utils.print_orange(...)
		return Utils.print_color(1.00, 0.49, 0.24, ...)
	end
	function Utils.print_red(...)
		return Utils.print_color(1.00, 0.12, 0.12, ...)
	end
	function Utils.print_yellow(...)
		return Utils.print_color(1.00, 1.00, 0.00, ...)
	end
	function Utils.print_white(...)
		return Utils.print_color(1.00, 1.00, 1.00, ...)
	end
	function Utils.print_green(...)
		return Utils.print_color(0.12, 1.00, 0.12, ...)
	end
	function Utils.print_blue(...)
		return Utils.print_color(0.00, 0.44, 0.87, ...)
	end
	function Utils.print_purple(...)
		return Utils.print_color(0.64, 0.21, 0.93, ...)
	end
end

-- Sends an addOn message to the appropriate channel:
function Utils.sync(prefix, msg)
	local zone = select(2, IsInInstance())
	if zone == "pvp" or zone == "arena" then
		SendAddonMessage(prefix, msg, "BATTLEGROUND")
	elseif GetRealNumRaidMembers() > 0 then
		SendAddonMessage(prefix, msg, "RAID")
	elseif GetRealNumPartyMembers() > 0 then
		SendAddonMessage(prefix, msg, "PARTY")
	end
end

-- Send a whisper to a player by his/her character name or BNet ID
-- Returns true if the message was sent, nil otherwise
function Utils.whisper(target, msg)
	if type(target) == "number" then
		-- Make sure to never send BNet whispers to ourselves.
		if not BNIsSelf(target) then
			BNSendWhisper(target, msg)
			return true
		end
	elseif type(target) == "string" then
		-- Unlike above, it is sometimes useful to whisper ourselves.
		SendChatMessage(msg, "WHISPER", nil, target)
		return true
	end
end
local BNSendWhisper = Utils.whisper

-- Returns the current UTC date and time in seconds:
function Utils.getUTCTimestamp()
	local utcDateTime = date("!*t")
	return time(utcDateTime)
end
function Utils.getSecondsAsString(t)
	local str = "00:00:00"
	local sec
	if t > 0 then
		local hrs = floor(t / 3600)
		sec = t - (hrs * 3600)
		local min = floor(sec / 60)
		sec = sec - (min * 60)
		str = format("%02d:%02d:%02d", hrs, min, sec)
	end
	return str
end

-- Determines if the player is in a raid instance
function Utils.IsRaidInstance()
	local inInstance, instanceType = IsInInstance()
	return ((inInstance) and (instanceType == "raid"))
end

-- Returns the raid difficulty:
function Utils.GetDifficulty()
	local difficulty = nil
	local inInstance, instanceType = IsInInstance()
	if inInstance and instanceType == "raid" then
		difficulty = GetRaidDifficulty()
	end
	return difficulty
end

-- Returns the NPCID or nil:
function Utils.GetNPCID(GUID)
	local first3 = tonumber("0x"..strsub(GUID, 3, 5))
	local unitType = bit.band(first3, 0x007)
	if ((unitType == 0x003) or (unitType == 0x005)) then
		return tonumber("0x"..strsub(GUID, 9, 12))
	end
	return nil
end

-- Returns the current time:
function Utils.GetCurrentTime(server)
	server = server or true
	local t = time()
	if server == true then
		local _, month, day, year = CalendarGetDate()
		local hour, minute = GetGameTime()
		t = time({year = year, month = month, day = day, hour = hour, min = minute})
	end
	return t
end

-- Returns the server offset:
function Utils.GetServerOffset()
	local sH, sM = GetGameTime()
	local lH, lM = tonumber(date("%H")), tonumber(date("%M"))
	local sT = sH + sM / 60
	local lT = lH + lM / 60
	local offset = floor((sT - lT) * 2 + 0.5) / 2
	if offset >= 12 then
		offset = offset - 24
	elseif offset < -12 then
		offset = offset + 24
	end
	return offset
end

--[==[ Base64 encode/decode ]==]--
do
	-- Characters table string:
	local char, byte = string.char, string.byte
	local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

	-- Encoding:
	function Utils.encode(data)
	    return ((gsub(data, ".", function(x)
	        local r, b = "", byte(x)
	        for i = 8, 1, -1 do
			r = r..(b%2^i-b%2^(i-1)>0 and "1" or "0")
	        end
	        return r
	    end).."0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
	        if #x < 6 then return "" end
	        local c = 0
	        for i = 1, 6 do
				c = c + (strsub(x, i, i) == "1" and 2^(6-i) or 0)
	        end
	        return strsub(b, c+1, c+1)
	    end)..({"", "==", "="})[#data%3+1])
	end

	-- Decoding:
	function Utils.decode(data)
	    data = gsub(data, "[^"..b.."=]", '')
	    return (gsub(data, ".", function(x)
	        if x == "=" then return "" end
	        local r, f = "", (find(b, x) - 1)
	        for i = 6, 1, -1 do
				r = r..(f%2^i-f%2^(i-1) > 0 and "1" or "0")
	        end
	        return r
	    end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
	        if #x ~= 8 then return "" end
	        local c = 0
	        for i = 1, 8 do
				c = c + (strsub(x, i, i) == "1" and 2^(8-i) or 0)
	        end
	        return char(c)
	    end))
	end
end