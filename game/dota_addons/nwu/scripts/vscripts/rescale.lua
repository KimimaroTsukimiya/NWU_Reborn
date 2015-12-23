function GameMode:RescaleUnit( unit )
	if     unit:GetName() == "npc_dota_roshan" then 
		GameMode:kyuubi(unit)
    elseif  unit:GetName() == "npc_dota_courier" then 
    	GameMode:rescaleCourier(unit)
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