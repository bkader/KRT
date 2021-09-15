if GetLocale() ~= "ruRU" then return end
local addonName, addon = ...
local L = addon.L

-- ==================== Roll Pattern ==================== --
L.RollPattern = "(.+) rolls (%d+) %((%d+)%-(%d+)%)"
