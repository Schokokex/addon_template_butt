function say(...)
	local str = ""
	for i,v in ipairs({...}) do
		str = str..tostring(v).." "
	end
	Say(nil,str,true)
end

function table.merge(weak, strong)
	if (type(weak) ~= "table") then error("1st argument of table.merge() is not a table") end
	if (type(strong) == "table") then
		for k,v in pairs(strong) do
			if type(v)=="table" then
				if (type(weak[k])~="table") then weak[k] = {} end
				table.merge(weak[k],v)
				if next(weak[k])==nil then weak[k] = nil end
			else
				weak[k] = v
			end
		end
	end
	return weak
end

function copyFile(fromFile, toFile)
	local infile = io.open(fromFile, "rb")
	instr = infile:read("*a")
	infile:close()

	local outfile = io.open(toFile, "wb")
	outfile:write(instr)
	outfile:close()
end

function strToFile(str, filename)
	local file = io.open(filename,"w")
	file:write(str)
	io.close(file)
end

function kvToFile(kv, filename)
	strToFile(kvToString(kv,""),filename)
end

function fileToString(filename)
	local file = io.open(filename, "r")
	local out = file:read("*all")
	io.close(file)
	return out
end

function kvToString(kv,prefix)
	local out = ""
	if type(kv)=="table" then
		for k,v in opairs(kv) do
			if type(v)=="table" then
				out = ("%s%s\"%s\"\n%s{\n%s%s}\n"):format(out,prefix,k,prefix,kvToString(v,prefix.."\t"),prefix)
				-- out = out .. prefix .. "\"" .. k .. "\" " .. "\n".. prefix .."{\n" .. kvToString(v,prefix.."\t") .. prefix .. "}\n"
			else
				local val = (type(v)=="string" or type(v)=="number") and v or "ERR"
				out = ("%s%s\"%-32s \"%s\"\n"):format(out,prefix,(k .. "\""),val)
			end
		end
	end
	return out
end

function fileToTable(filename)
	return fixParsedTable(LoadKeyValues(filename))
end

function fixParsedTable( tabl )
	if "table"~=type(tabl) then return tabl end
	for k,v in pairs(tabl) do
		if "number"==type(v) then
			tabl[k] = 0.001 * math.floor(v*1000+0.5)
		else tabl[k] = fixParsedTable(tabl[k]) end
	end
	return tabl
end

function globalsToString()
	local out = ""
	for k,v in pairs(_G) do
		if type(v)=="function" then v = "f()" end
		if type(v)=="table" then v = "{}" end
		if type(v)=="userdata" then v = "udat" end
		if type(v)=="boolean" then v = V and "true" or "false" end
		out = out .. k .. ": " .. v .. "\n"
	end
	return out
end

function length(t)
	if (type(t) == "table") then
		local len = 0
		for _,_ in pairs(t) do
			len = len + 1
		end
		return len
	else
		print(t, "is not a table")
	end
end

function table.copy(tabel)
	if ("table"~=type(tabel)) then return nil end
	local out = {}
	for k,v in pairs(tabel) do
		out[k]=v
	end
	return out
end

function DebugPrint(...)
	local spew = Convars:GetInt('barebones_spew') or -1
	if spew == -1 and BAREBONES_DEBUG_SPEW then
		spew = 1
	end

	if spew == 1 then
		print(...)
	end
end

function DebugPrintTable(...)
	local spew = Convars:GetInt('barebones_spew') or -1
	if spew == -1 and BAREBONES_DEBUG_SPEW then
		spew = 1
	end

	if spew == 1 then
		PrintTable(...)
	end
end

function PrintTable(t, indent, done)
	--print ( string.format ('PrintTable type %s', type(keys)) )
	if type(t) ~= "table" then return end

	done = done or {}
	done[t] = true
	indent = indent or 0

	local l = {}
	for k, v in pairs(t) do
		table.insert(l, k)
	end

	table.sort(l)
	for k, v in ipairs(l) do
		-- Ignore FDesc
		if v ~= 'FDesc' then
			local value = t[v]

			if type(value) == "table" and not done[value] then
				done [value] = true
				print(string.rep ("\t", indent)..tostring(v)..":")
				PrintTable (value, indent + 2, done)
			elseif type(value) == "userdata" and not done[value] then
				done [value] = true
				print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
				PrintTable ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
			else
				if t.FDesc and t.FDesc[v] then
					print(string.rep ("\t", indent)..tostring(t.FDesc[v]))
				else
					print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
				end
			end
		end
	end
end

-- Colors
COLOR_NONE = '\x06'
COLOR_GRAY = '\x06'
COLOR_GREY = '\x06'
COLOR_GREEN = '\x0C'
COLOR_DPURPLE = '\x0D'
COLOR_SPINK = '\x0E'
COLOR_DYELLOW = '\x10'
COLOR_PINK = '\x11'
COLOR_RED = '\x12'
COLOR_LGREEN = '\x15'
COLOR_BLUE = '\x16'
COLOR_DGREEN = '\x18'
COLOR_SBLUE = '\x19'
COLOR_PURPLE = '\x1A'
COLOR_ORANGE = '\x1B'
COLOR_LRED = '\x1C'
COLOR_GOLD = '\x1D'


--[[Author: Noya
	Date: 09.08.2015.
	Hides all dem hats
	]]
	function HideWearables( event )
		local hero = event.caster
		local ability = event.ability

		hero.hiddenWearables = {} -- Keep every wearable handle in a table to show them later
		local model = hero:FirstMoveChild()
		while model ~= nil do
			if model:GetClassname() == "dota_item_wearable" then
				model:AddEffects(EF_NODRAW) -- Set model hidden
				table.insert(hero.hiddenWearables, model)
			end
			model = model:NextMovePeer()
		end
	end

	function ShowWearables( event )
		local hero = event.caster

		for i,v in pairs(hero.hiddenWearables) do
			v:RemoveEffects(EF_NODRAW)
		end
	end
	
function opairs(t)
	function orderedNext(t, state)
		function __genOrderedIndex( t )
		    local orderedIndex = {}
		    for key in pairs(t) do
		        table.insert( orderedIndex, key )
		    end
		    table.sort( orderedIndex )
		    return orderedIndex
		end

	    -- Equivalent of the next function, but returns the keys in the alphabetic
	    -- order. We use a temporary ordered key table that is stored in the
	    -- table being iterated.

	    local key = nil
	    --print("orderedNext: state = "..tostring(state) )
	    if state == nil then
	        -- the first time, generate the index
	        t.__orderedIndex = __genOrderedIndex( t )
	        key = t.__orderedIndex[1]
	    else
	        -- fetch the next value
	        for i = 1,table.getn(t.__orderedIndex) do
	            if t.__orderedIndex[i] == state then
	                key = t.__orderedIndex[i+1]
	            end
	        end
	    end

	    if key then
	        return key, t[key]
	    end

	    -- no more value to return, cleanup
	    t.__orderedIndex = nil
	    return
	end
    -- Equivalent of the pairs() function on tables. Allows to iterate
    -- in order
    return orderedNext, t, nil
end