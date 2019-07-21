local ADDON_NAME, PRIVATE_TABLE = ...

local L = LibStub("AceLocale-3.0"):GetLocale("AutoLooter")
local ListHelper = PRIVATE_TABLE.ListHelper

local module = LibStub("AceAddon-3.0"):GetAddon("AutoLooter"):NewModule("AlertList", "AceEvent-3.0")
module.priority = 1

local PlaySoundFile = PlaySoundFile
local RaidNotice_AddMessage = RaidNotice_AddMessage

function module.CanLoot(link, icon, sTitle, nQuantity, currencyID, nRarity, locked, isQuestItem, questId, isActive)
	if PRIVATE_TABLE.DB.alert[sTitle] then
		if PRIVATE_TABLE.DB.alertSound then
			PlaySoundFile(PRIVATE_TABLE.DB.alertSound) -- safe
		end

		RaidNotice_AddMessage(RaidWarningFrame, link, ChatTypeInfo["RAID_WARNING"])
	end
end

function module:GetOptions()
	return {
		alertlist = {
			name = L["Alert List"],
			type = "group",
			args = {
				add = {
					type = "input",
					name = L["Add item to alert list"],
					width = "double",
					set = function(info, val) ListHelper.AddItem(val, PRIVATE_TABLE.DB.alert) end,
					get = false
				},
				remove = {
					type = "input",
					name = L["Remove item from alert list"],
					width = "double",
					set = function(info, val) ListHelper.RemoveItem(val, PRIVATE_TABLE.DB.alert) end,
					get = false
				},
				sound = {
					type = "input",
					name = L["Set alert sound"],
					width = "double",
					set = function(info, val) PRIVATE_TABLE.DB.alertSound = val end,
					get = function(info) return PRIVATE_TABLE.DB.alertSound end,
				}
			}
		}
	}
end