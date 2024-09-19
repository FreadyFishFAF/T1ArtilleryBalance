-- Subtract 1125 after hooked, for debugging
do
    local oldModBlueprints = ModBlueprints

    function ModBlueprints(all_bps)
        oldModBlueprints(all_bps)

        -- Loop through all blueprints to find T1 artillery units
        for id, bp in all_bps.Unit do
            -- Check if the unit is categorized as T1 artillery
            if table.find(bp.Categories, "ARTILLERY") and table.find(bp.Categories, "TECH1") then

                -- Disable predictive projectiles to make them ineffective against moving targets
                bp.Weapon[1].LeadTarget = false

                -- Double the cost
                bp.Economy.BuildCostEnergy = bp.Economy.BuildCostEnergy * 2
                bp.Economy.BuildCostMass = bp.Economy.BuildCostMass * 2

                -- Increase weapon range by 2 units
                bp.Weapon[1].MaxRadius = bp.Weapon[1].MaxRadius + 2

                if id == "uel0103" then -- UEF T1 Artillery

                    local uefRoF = 0.5
                    local uefDPS = 2

                    bp.Weapon[1].RateOfFire = bp.Weapon[1].RateOfFire * uefRoF

                    bp.Weapon[1].Damage = bp.Weapon[1].Damage * uefDPS / uefRoF

                    bp.Intel.VisionRadius = bp.Intel.VisionRadius * 2

                elseif id == "url0103" then -- Cybran T1 Artillery

                    local cybranRoF = 1.5
                    local cybranDPS = 1

                    bp.Weapon[1].RateOfFire = bp.Weapon[1].RateOfFire * cybranRoF

                    bp.Weapon[1].Damage = bp.Weapon[1].Damage * cybranDPS / cybranRoF

                    bp.Physics.MaxSpeed = 3.7

                    bp.Weapon[1].DamageRadius = bp.Weapon[1].DamageRadius * 1.5

                    bp.Weapon[1].FiringRandomness = bp.Weapon[1].FiringRandomness * 1.25

                    -- Stun
                    for k, v in bp.Weapon[1].Buffs do
                        v.Duration = v.Duration + 2 -- default is 3s for T1, 2s for T2, this makes it 5s for T1, 4s for T2
                    end

                elseif id == "ual0103" then -- Aeon T1 Artillery

                    local aeonRoF = 1.5
                    local aeonDPS = 2

                    bp.Weapon[1].RateOfFire = bp.Weapon[1].RateOfFire * aeonRoF

                    bp.Weapon[1].Damage = bp.Weapon[1].Damage * aeonDPS / aeonRoF

                    bp.Weapon[1].DamageRadius = 0

                    bp.Weapon[1].FiringRandomness = 0

                elseif id == "xsl0103" then -- Seraphim T1 Artillery

                    local seraRoF = 3
                    local seraDPS = 2

                    bp.Weapon[1].RateOfFire = bp.Weapon[1].RateOfFire * seraRoF

                    bp.Weapon[1].Damage = bp.Weapon[1].Damage * seraDPS / seraRoF

                    bp.Weapon[1].BallisticArc = 'RULEUBA_LowArc'

                    -- bp.Weapon[1].MuzzleVelocity = bp.Weapon[1].MuzzleVelocity
                end
            end
        end
    end
end
