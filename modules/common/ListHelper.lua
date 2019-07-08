local ADDON_NAME, PRIVATE_TABLE = ...;

local L = PRIVATE_TABLE.GetTable("L")
local ListHelper = PRIVATE_TABLE.GetTable("ListHelper")
local Util = AutoLooter:GetUtil()
local Color = AutoLooter:GetColorTable()

function ListHelper.AddItem(sTitle, list)
	if not sTitle or sTitle == "" then
		sTitle = GameTooltip:GetItem()

		if not sTitle or sTitle == "" then
			for k, _ in pairs(list) do
				Util.print(k)
			end

			return
		end
	end

	local sName = GetItemInfo(sTitle)

	if not sName then Util.print(L["Invalid item"], ": ", sTitle); return end

	if (list[sName]) then
		Util.print(L["Already in the list"], ": ", Color.YELLOW, sName)
		return
	end

	list[sName] = true
	Util.print(L["Added"], ": ", Color.YELLOW, sName)
end

function ListHelper.RemoveItem(sTitle, list)
	if not sTitle or sTitle == "" then
		sTitle = GameTooltip:GetItem()

		if not sTitle or sTitle == "" then
			for k, _ in pairs(list) do
				Util.print(k)
			end

			return
		end
	end

	local sName = GetItemInfo(sTitle)

	if (list[sName]) then
		list[sName] = nil
		Util.print(L["Removed"], ": ", Color.YELLOW, sName)
		return
	end

	Util.print(L["Not listed"], ": ", Color.YELLOW, sName)
end