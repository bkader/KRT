if GetLocale() ~= "deDE" then return end
local addonName, addon = ...
local L = addon.L

-- ==================== Roll Pattern ==================== --
L.RollPattern = "(.+) würfelt. Ergebnis: (%d+) %((%d+)%-(%d+)%)"
