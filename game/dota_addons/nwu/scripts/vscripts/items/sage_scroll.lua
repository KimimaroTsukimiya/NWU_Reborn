--[[Author: Pizzalol
	Date: 18.01.2015.
	Checks if the target is an illusion, if true then it kills it
	otherwise the target model gets swapped into a frog]]
function voodoo_start( keys )
	print("1")
	local target = keys.target
	local model = keys.model

	if target:IsIllusion() then
		target:ForceKill(true)
	else
		print("2")
		if target.target_model == nil then
			target.target_model = target:GetModelName()
		end
		print("3")
		target:SetOriginalModel(model)
		print("4")
	end
end

--[[Author: Pizzalol
	Date: 18.01.2015.
	Reverts the target model back to what it was]]
function voodoo_end( keys )
	local target = keys.target

	-- Checking for errors
	if target.target_model ~= nil then
		print(target.target_model)
		target:SetModel(target.target_model)
		target:SetOriginalModel(target.target_model)
		if target.target_model == "models/creeps/roshan/roshan.vmdl" then
			print("rescale")
			target:SetModelScale(3.6)
		end

	end
end

--[[Author: Noya
	Date: 10.01.2015.
	Hides all dem hats
]]
function HideWearables( event )
	local hero = event.target
	print("5")
	local ability = event.ability
	local duration = ability:GetLevelSpecialValueFor( "duration", ability:GetLevel() - 1 )
	print("Hiding Wearables")
	--hero:AddNoDraw() -- Doesn't work on classname dota_item_wearable

	hero.wearableNames = {} -- In here we'll store the wearable names to revert the change
	hero.hiddenWearables = {} -- Keep every wearable handle in a table, as its way better to iterate than in the MovePeer system

	-- Handle faulty models (might be more!)
	if hero:GetModelName() == "models/heroes/lina/lina.vmdl" then
		print("lina.vmdl is potato")
		DeepPrintTable(hero:GetChildren())
		return
	end
	print("6")
    local model = hero:FirstMoveChild()
    while model ~= nil do
        if model:GetClassname() ~= "" and model:GetClassname() == "dota_item_wearable" then
            local modelName = model:GetModelName()
            if string.find(modelName, "invisiblebox") == nil then
            	-- Add the original model name to revert later
            	table.insert(hero.wearableNames,modelName)
            	print("Hidden "..modelName.."")

            	-- Set model invisible
            	model:SetModel("models/development/invisiblebox.vmdl")
            	table.insert(hero.hiddenWearables,model)
            end
        end
        model = model:NextMovePeer()
        if model ~= nil then
        	print("Next Peer:" .. model:GetModelName())
        end
        print("7")
    end
end

--[[Author: Noya
	Date: 10.01.2015.
	Shows the hidden hero wearables
]]
function ShowWearables( event )
	local hero = event.target
	print("Showing Wearables on ".. hero:GetModelName())

	if hero.hiddenWearables then
		-- Iterate on both tables to set each item back to their original modelName
		for i,v in ipairs(hero.hiddenWearables) do
			for index,modelName in ipairs(hero.wearableNames) do
				if i==index then
					print("Changed "..v:GetModelName().. " back to "..modelName)
					v:SetModel(modelName)
				end
			end
		end
	end
end