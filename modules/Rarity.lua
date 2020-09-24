local ADDON_NAME, PRIVATE_TABLE = ...

local L = LibStub("AceLocale-3.0"):GetLocale("AutoLooter")
local Color = PRIVATE_TABLE.Color
local Util = PRIVATE_TABLE.Util

local AutoLooter = LibStub("AceAddon-3.0"):GetAddon("AutoLooter")
local module = AutoLooter:NewModule("Rarity", PRIVATE_TABLE.ToggleableModulePrototype, "AceEvent-3.0")
module.priority = 700

local reason = Color.GREEN .. L["Rarity"]

local MAX_RARITY = 6

function module:CanEnable()
	for i = 0, MAX_RARITY do
		if self.db.profile.rarity[i] then return true end
	end
end

function module:InitializeDb()
	local defaults = { profile = { rarity = {} } }
	for i = 2, MAX_RARITY do
		defaults.profile.rarity[i] = true
	end
	self.db = AutoLooter.db:RegisterNamespace("RarityModule", defaults)
end

function module.CanLoot(link, icon, sTitle, nQuantity, currencyID, nRarity, locked, isQuestItem, questId, isActive)
	if nRarity and module.db.profile.rarity[nRarity] then
		return true, reason, AutoLooter.FormatLoot(icon, link, nQuantity), nil
	end
end

function module:GetOptions()
	return {
		general = {
			args = {
				rarity = {
					type = "multiselect",
					name = L["Rarity"],
					order = 1001,
					values = function()
						local values = {}
						for i = 0, MAX_RARITY do
							values[i] = Util.GetColorForRarity(i) .. _G["ITEM_QUALITY" .. i .. "_DESC"]
						end
						return values
					end,
					set = function(info, key, value) self:SetProfileVarKey("rarity", key, value) end,
					get = function(info, key) return self.db.profile.rarity[key] end
				}
			}
		}
	}
end