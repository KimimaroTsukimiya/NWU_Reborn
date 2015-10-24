modifier_neji_kaiten_stun = class({})

function modifier_neji_kaiten_stun:IsDebuff()
    return 1
end

function modifier_neji_kaiten_stun:IsHidden()
    return 0
end

function modifier_neji_kaiten_stun:CheckState()
    local state = {
        [MODIFIER_STATE_STUNNED] = true,
    }
    return state
end

function modifier_neji_kaiten_stun:OnCreated( kv )
    if IsServer() then
        if self:GetParent() == self:GetCaster() then
            local nFXIndex = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_stunned.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
            self:AddParticle( nFXIndex, false, false, -1, false, false )
        else
            local nFXIndex = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_stunned.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
            self:AddParticle( nFXIndex, false, false, -1, false, false )
        end
    end
end