if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local addonName, addon = ...
local L = addon.L

-- ==================== Roll Pattern ==================== --
L.RollPattern = "(.+) tira los dados y obtiene (%d+) %((%d+)%-(%d+)%)"
