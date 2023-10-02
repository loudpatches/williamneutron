--alternate hook version.  worked but complained after first relaid about no typeclass.
--WIP...

--baseunit = import('/units/UEB2108/UEB2108_Script.lua').UEB2108
--do
--  oldOnStopBeingBuilt = baseunit.OnStopBeingBuilt

--  baseunit.OnStopBeingBuilt =
--      function(self,builder,layer)
--        LOG("built one!")
--        oldOnStopBeingBuilt(self,builder,layer)
--      end
--end

--blind copy of unit script, with modifications:
--1) ensure we have confirmation our code is traversed on unit built with
--a simple log function (overriding OnStopBeingBuilt
--2) Looks like the default weapon was pointing at CruiseMissile and finding nothing.
--So we change that to TacNukMissile as the identifier in the key.  This now works.  Note:
--this is how the comm is set up.  I am inferring that there must be a matching correspondence
--between the weapon name and the blueprint value.
--So I bet we can have two weapons, e.g. leave the legacy CruiseMissile on, and
--add the tacnuke as a second weapon.

--I think the ui event for launch nuke sends a message to an expected TacNuke weapon entry,
--and finding none (at the time only the old CruiseMissile was there), it just gets swallowed up.

LOG("defining william neutron")
local TStructureUnit = import('/lua/defaultunits.lua').StructureUnit
local TIFCruiseMissileLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileLauncher
local EffectTemplate = import('/lua/EffectTemplates.lua')

UEB2108 = Class(TStructureUnit) {
    Weapons = {
        --CruiseMissile = Class(TIFCruiseMissileLauncher) {
        TacNukeMissile = Class(TIFCruiseMissileLauncher) {
            FxMuzzleFlash = EffectTemplate.TIFCruiseMissileLaunchBuilding,}
     },
    OnStopBeingBuilt =
      function(self,builder,layer)
        LOG("built one!")
      end
}
TypeClass = UEB2108