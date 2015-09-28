function GiveMana( event )
	event.caster:EmitSound("DOTA_Item.ArcaneBoots.Activate")
	ParticleManager:CreateParticle("particles/items_fx/arcane_boots.vpcf", PATTACH_ABSORIGIN_FOLLOW, event.caster)

  local target = event.target
  local mana_amount = event.mana_amount
  target:GiveMana(mana_amount)
end