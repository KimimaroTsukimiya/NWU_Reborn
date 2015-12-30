function GameMode:RescaleUnit( unit )
	if     unit:GetName() == "npc_dota_roshan" then 
		GameMode:kyuubi(unit)
    elseif  unit:GetName() == "npc_dota_courier" then 
    	GameMode:rescaleCourier(unit)
    elseif  unit:GetModelName() == "models/creeps/lane_creeps/creep_radiant_melee/radiant_melee.vmdl" then 
    	unit:SetModelScale(2.2)
    elseif  unit:GetModelName() == "models/creeps/lane_creeps/creep_bad_melee/creep_bad_melee.vmdl" then 
        unit:SetModelScale(0.8)
    elseif  unit:GetModelName() == "models/props_gameplay/donkey_wings.vmdl" then 
    	unit:SetModelScale(5.0)
    elseif  unit:GetModelName() == "models/heroes/clinkz/clinkz_arrow.vmdl" then 
        unit:SetModelScale(0.6)
    else                 
    	
    end
end

function GameMode:kyuubi( unit )
	unit:SetModelScale(3.6)
end


function GameMode:rescaleCourier( unit )
	if unit:GetModelName() == "models/props_gameplay/donkey.vmdl" then
		unit:SetModelScale(0.6)
	end
	if unit:GetModelName() == "models/props_gameplay/donkey_dire.vmdl" then
		unit:SetModelScale(0.6)
	end
end