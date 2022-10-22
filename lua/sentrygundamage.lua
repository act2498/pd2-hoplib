Hooks:PostHook(SentryGunDamage, "_apply_damage", "_apply_damage_hoplib", function (self, damage, dmg_shield, dmg_body, is_local, attacker_unit)

	local dmg = damage == "death" and (dmg_shield and self._SHIELD_HEALTH_INIT or dmg_body and self._HEALTH_INIT) or damage
	if type(dmg) == "number" then
		local info = HopLib:unit_info_manager():get_info(attacker_unit)
		if info then
			info:update_damage(dmg, self._dead)
		end
		local attack_data = {
			damage = dmg,
			attacker_unit = attacker_unit
		}
		Hooks:Call("HopLibOnUnitDamaged", self._unit, attack_data)
		if self._dead then
			Hooks:Call("HopLibOnUnitDied", self._unit, attack_data)
			HopLib:unit_info_manager():clear_info(self._unit)
		end
	end

end)