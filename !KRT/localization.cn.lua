if GetLocale() ~= "zhCN" then return end
local addonName, addon = ...
local L = addon.L

-- ==================== Roll Pattern ==================== --
L.RollPattern = "(.+) rolls (%d+) %((%d+)%-(%d+)%)"
