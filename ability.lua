local ability = {
    spellkey = Menu.AddKeyOption({"ability"}, "ability autocast key", Enum.ButtonCode.KEY_SPACE),
    particle = 0,
    walking = {},
    orbwalking = {},
    channelling = {},
    defender = {},
    sleeptime = {},
    calling = {},
    tracking = {},
    spellinfo = {},
    casttime = {},
    cooldown = {},
    cast_pos = {},
    handle = {},
    printing = {},
    throw_allies = false
}

function ability.OnGameEnd()
    ability.particle = 0
    ability.walking = {}
    ability.orbwalking = {}
    ability.channelling = {}
    ability.defender = {}
    ability.sleeptime = {}
    ability.calling = {}
    ability.tracking = {}
    ability.spellinfo = {}
    ability.casttime = {}
    ability.cooldown = {}
    ability.cast_pos = {}
    ability.handle = {}
    ability.printing = {}
    ability.throw_allies = false
end

ability.ignorespell = {
    "ancient_apparition_chilling_touch",
    "axe_berserkers_call",
    "axe_culling_blade",
    "bane_nightmare",
    "batrider_sticky_napalm",
    "bloodseeker_bloodrage",
    "bounty_hunter_wind_walk",
    "beastmaster_call_of_the_wild",
    "beastmaster_call_of_the_wild_boar",
    "beastmaster_call_of_the_wild_hawk",
    "broodmother_spin_web",
    "centaur_double_edge",
    "centaur_return",
    "chaos_knight_reality_rift",
    "chen_holy_persuasion",
    "clinkz_wind_walk",
    "dazzle_shallow_grave",
    "doom_bringer_devour",
    "doom_bringer_infernal_blade",
    "drow_ranger_trueshot",
    "earth_spirit_boulder_smash",
    "earth_spirit_rolling_boulder",
    "earth_spirit_geomagnetic_grip",
    "enigma_demonic_conversion",
    "faceless_void_time_walk",
    "faceless_void_time_dilation",
    "faceless_void_chronosphere",
    "furion_sprout",
    "furion_teleportation",
    "furion_force_of_nature",
    "huskar_life_break",
    "invoker_ghost_walk",
    "invoker_invoke",
    "jakiro_liquid_fire",
    "kunkka_tidebringer",
    "kunkka_x_marks_the_spot",
    "legion_commander_duel",
    "lich_sinister_gaze",
    "lion_mana_drain",
    "lone_druid_spirit_bear",
    "lone_druid_spirit_link",
    "lone_druid_savage_roar",
    "lone_druid_true_form_battle_cry",
    "medusa_mana_shield",
    "meepo_poof",
    "magnataur_empower",
    "magnataur_skewer",
    "morphling_adaptive_strike_str",
    "morphling_morph_agi",
    "morphling_morph_str",
    "monkey_king_tree_dance",
    "pudge_rot",
    "phantom_assassin_stifling_dagger",
    "phantom_assassin_phantom_strike",
    "phantom_assassin_blur",
    "phantom_lancer_doppelwalk",
    "queenofpain_blink",
    "rattletrap_battery_assault",
    "rattletrap_power_cogs",
    "riki_blink_strike",
    "rubick_telekinesis",
    "rubick_fade_bolt",
    "sandking_sand_storm",
    "shredder_chakram_2",
    "sniper_take_aim",
    "spirit_breaker_charge_of_darkness",
    "spirit_breaker_empowering_haste",
    "spirit_breaker_nether_strike",
    "techies_stasis_trap",
    "techies_suicide",
    "terrorblade_conjure_image",
    "tiny_toss",
    "tiny_craggy_exterior",
    "tiny_toss_tree",
    "treant_natures_guise",
    "troll_warlord_berserkers_rage",
    "troll_warlord_whirling_axes_ranged",
    "troll_warlord_battle_trance",
    "tusk_walrus_kick",
    "ursa_earthshock",
    "ursa_overpower",
    "weaver_shukuchi",
    "wisp_tether",
    "wisp_tether_break",
    "wisp_relocate",
    "wisp_spirits_in",
    "wisp_spirits_out",
    "witch_doctor_voodoo_restoration",
    "bristleback_viscous_nasal_goo",
    "bristleback_quill_spray",
    "storm_spirit_ball_lightning",
    "mars_arena_of_blood",
    "faceless_void_time_dilation",
    "vengefulspirit_nether_swap",
    "invoker_invoke",
    "naga_siren_song_of_the_siren",
    "naga_siren_song_of_the_siren_cancel",
    "puck_phase_shift",
    "alchemist_unstable_concoction",
    "alchemist_unstable_concoction_throw",
    "ancient_apparition_ice_blast_release",
    "venomancer_plague_ward",
    "clinkz_searing_arrows",
    "life_stealer_rage",
    "life_stealer_open_wounds",
    "life_stealer_infest",
    "tusk_tag_team",
    "tusk_walrus_kick",
    "phoenix_icarus_dive",
    "phoenix_fire_spirits",
    "phoenix_launch_fire_spirit",
    "antimage_blink",
    "abaddon_borrowed_time",
    "hoodwink_scurry",
    "templar_assassin_meld",
    "mars_bulwark",
    "skeleton_king_vampiric_aura",
    "zuus_static_field",
    "phantom_lancer_phantom_edge",
    "disruptor_glimpse",
    "dark_seer_surge",
    "shadow_demon_disruption",
    "shadow_demon_shadow_poison",
    "slardar_sprint",
    "templar_assassin_psionic_trap",
    "templar_assassin_trap",
    "weaver_geminate_attack",
    "oracle_false_promise",
    "dawnbreaker_fire_wreath",
    "dawnbreaker_celestial_hammer",
    "enchantress_natures_attendants",
    "warlock_shadow_word",
    "warlock_upheaval",
    "elder_titan_echo_stomp",
    "pudge_flesh_heap"
    --"obsidian_destroyer_astral_imprisonment"
}

function ability.mutedspell(name)
    for _, v in pairs(ability.ignorespell) do
        if v and name and v == name then return true end
    end
    return false
end

function ability.OnUpdate()
    if not Heroes.GetLocal() then return end

    local mytable = {}
    for i = 1, NPCs.Count() do
        local npc = NPCs.Get(i)
        if npc and Entity.IsSameTeam(Heroes.GetLocal(), npc) and Entity.IsAlive(npc) and (NPC.IsHero(npc) or NPC.IsCreep(npc) or NPC.GetUnitName(npc) == "npc_dota_lone_druid_bear1" or NPC.GetUnitName(npc) == "npc_dota_lone_druid_bear2" or NPC.GetUnitName(npc) == "npc_dota_lone_druid_bear3" or NPC.GetUnitName(npc) == "npc_dota_lone_druid_bear4") and (Entity.GetOwner(Heroes.GetLocal()) == Entity.GetOwner(npc) or Entity.OwnedBy(npc, Heroes.GetLocal())) and not NPC.HasModifier(npc, "modifier_antimage_blink_illusion") and not NPC.HasModifier(npc, "modifier_monkey_king_fur_army_soldier_hidden") and not NPC.HasModifier(npc, "modifier_monkey_king_fur_army_soldier") then
            table.insert(mytable, npc)
        end
    end

    for _, me in ipairs(mytable) do
        if me then
            local ability0, ability1, ability2, ability3, ability4, ability5, cast_rearm = NPC.GetAbilityByIndex(me, 0), NPC.GetAbilityByIndex(me, 1), NPC.GetAbilityByIndex(me, 2), NPC.GetAbilityByIndex(me, 3), NPC.GetAbilityByIndex(me, 4), NPC.GetAbilityByIndex(me, 5), true
            local ethereal_blade, force_staff = NPC.GetItem(me, "item_ethereal_blade"), NPC.GetItem(me, "item_force_staff") or NPC.GetItem(me, "item_hurricane_pike")
            local dagon = NPC.GetItem(me, "item_dagon_1") or NPC.GetItem(me, "item_dagon_2") or NPC.GetItem(me, "item_dagon_3") or NPC.GetItem(me, "item_dagon_4") or NPC.GetItem(me, "item_dagon_5")
            if not target and Input.GetNearestHeroToCursor(Entity.GetTeamNum(me), 0) and NPC.IsPositionInRange(Input.GetNearestHeroToCursor(Entity.GetTeamNum(me), 0), Input.GetWorldCursorPos(), 300) then target = Input.GetNearestHeroToCursor(Entity.GetTeamNum(me), 0) end
            if target and Menu.IsKeyDown(ability.spellkey) and Entity.IsAlive(target) and not Entity.IsDormant(target) then
                target = target
                if ability.particle == 0 then ability.particle = Particle.Create("particles/ui_mouseactions/range_finder_tower_aoe.vpcf", Enum.ParticleAttachment.PATTACH_INVALID, target) end 
                if ability.particle and ability.particle > 0 then
                    Particle.SetControlPoint(ability.particle, 2, Entity.GetOrigin(Heroes.GetLocal()))
                    Particle.SetControlPoint(ability.particle, 6, Vector(1, 0, 0))
                    Particle.SetControlPoint(ability.particle, 7, Entity.GetOrigin(target))
                end
                if (not ability.channelling[me] or ability.channelling[me] < GameRules.GetGameTime()) and not NPC.IsChannellingAbility(me) and not NPC.HasModifier(me, "modifier_hoodwink_sharpshooter_windup") and not NPC.HasModifier(me, "modifier_spirit_breaker_charge_of_darkness") and not NPC.HasModifier(me, "modifier_monkey_king_bounce_leap") and not NPC.HasModifier(me, "modifier_snapfire_mortimer_kisses") and not NPC.HasModifier(me, "modifier_primal_beast_onslaught_windup") and not NPC.HasModifier(me, "modifier_primal_beast_onslaught_windup") and not NPC.HasModifier(me, "modifier_void_spirit_dissimilate_phase") and not NPC.IsStunned(me) then
                    if not ability.orbwalking[me] then
                        if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > NPC.GetAttackRange(me) + 90 or NPC.HasModifier(target, "modifier_ghost_state") or NPC.HasModifier(target, "modifier_item_ethereal_blade_ethereal") or NPC.HasModifier(me, "modifier_windrunner_focusfire") or NPC.HasModifier(me, "modifier_prevent_taunts") or NPC.HasModifier(me, "modifier_weaver_shukuchi") or not ability.safe_cast(me, target) then
                            if not ability.walking[me] or ability.walking[me] < GameRules.GetGameTime() then
                                Player.AttackTarget(Players.GetLocal(), me, target)
                                ability.walking[me] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + (math.random(6, 9) / 10)
                            end
                        else
                              Player.AttackTarget(Players.GetLocal(), me, target)
                        end
                    else
                        if ability.orbwalking[me] + NPC.GetAttackTime(me) - (NPC.GetAttackTime(me) / 1.5) < GameRules.GetGameTime() then
                            if not ability.walking[me] or ability.walking[me] < GameRules.GetGameTime() then
                                Player.AttackTarget(Players.GetLocal(), me, target)
                                ability.walking[me] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + (math.random(6, 9) / 10)
                            end
                        end
                        if ability.orbwalking[me] + NPC.GetAttackTime(me) + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) < GameRules.GetGameTime() then
                            ability.orbwalking[me] = nil
                        end
                    end
                end
            else
                if ability.particle and ability.particle > 0 then
                    Particle.Destroy(ability.particle)
                    ability.particle = 0
                end
                if not target and Menu.IsKeyDown(ability.spellkey) then
                    if not ability.walking[me] or ability.walking[me] < GameRules.GetGameTime() then
                        Player.AttackTarget(Players.GetLocal(), me, target)
                        ability.walking[me] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + (math.random(6, 9) / 10)
                    end
                end
                target = nil
            end
            
            for _, handle in pairs(ability.handle) do
                if handle.spell and Entity.IsAbility(handle.spell) then
                    if Ability.IsReady(handle.spell) and not NPC.IsStunned(me) and not NPC.IsSilenced(me) and not NPC.HasState(me, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then
                        for caster, date in pairs(ability.defender) do
                            if date.spell and NPC.GetActivity(date.unit) ~= 1500 and NPC.GetTimeToFace(caster, me) < 0.02 and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(caster)):Length2D() < handle.distance then
                                if (Ability.GetBehavior(date.spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 then
                                    if not NPC.HasModifier(caster, "modifier_antimage_counterspell") and not NPC.HasModifier(caster, "modifier_item_lotus_orb_active") and not NPC.HasState(caster, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and ((Ability.GetBehavior(handle.spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 and Ability.GetDispellableType(handle.spell) == 1 and Ability.GetCastPoint(handle.spell) == 0 or Ability.GetName(handle.spell) == "item_orchid" or Ability.GetName(handle.spell) == "item_bloodthorn") then
                                        Ability.CastTarget(handle.spell, caster)
                                        ability.defender[caster] = nil
                                    elseif (Ability.GetName(handle.spell) == "antimage_counterspell" or Ability.GetName(handle.spell) == "weaver_shukuchi" or Ability.GetName(handle.spell) == "nyx_assassin_spiked_carapace" or Ability.GetName(handle.spell) == "life_stealer_rage") and date.time + date.castpoint - 0.15 - (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) < GameRules.GetGameTime() then
                                        Ability.CastNoTarget(handle.spell)
                                        ability.defender[caster] = nil
                                    elseif Ability.GetName(handle.spell) == "juggernaut_blade_fury" and date.time + date.castpoint - 0.03 - (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) < GameRules.GetGameTime() then
                                        Ability.CastNoTarget(handle.spell)
                                        ability.defender[caster] = nil
                                    elseif Ability.GetName(date.spell) ~= "legion_commander_duel" and Ability.GetName(handle.spell) == "item_lotus_orb" and date.time + date.castpoint - 0.15 - (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) < GameRules.GetGameTime() then
                                        Ability.CastTarget(handle.spell, me)
                                        ability.defender[caster] = nil
                                    elseif (Ability.GetName(handle.spell) == "item_cyclone" or Ability.GetName(handle.spell) == "item_wind_waker") and date.time + date.castpoint - (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) < GameRules.GetGameTime() then
                                        Ability.CastTarget(handle.spell, me)
                                        ability.defender[caster] = nil
                                    elseif (Ability.GetName(handle.spell) == "puck_phase_shift" or Ability.GetName(handle.spell) == "item_stormcrafter") and date.time + date.castpoint - (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) < GameRules.GetGameTime() then
                                        Ability.CastNoTarget(handle.spell)
                                        ability.defender[caster] = nil
                                    elseif Ability.GetName(handle.spell) == "dawnbreaker_fire_wreath" and NPC.HasModifier(me, "modifier_item_aghanims_shard") and date.time + date.castpoint - 0.35 - (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) < GameRules.GetGameTime() then
                                        Ability.CastPosition(handle.spell, ability.skillshotXYZ(me, caster, 950))
                                        ability.defender[caster] = nil
                                    end
                                elseif (Ability.GetBehavior(date.spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 or (Ability.GetBehavior(date.spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
                                    if (Ability.GetName(handle.spell) == "item_manta" or Ability.GetName(handle.spell) == "nyx_assassin_spiked_carapace" or Ability.GetName(handle.spell) == "life_stealer_rage" or Ability.GetName(handle.spell) == "item_stormcrafter" or Ability.GetName(handle.spell) == "juggernaut_blade_fury" or Ability.GetName(handle.spell) == "puck_phase_shift" or Ability.GetName(handle.spell) == "item_black_king_bar") and date.time + date.castpoint - 0.15 < GameRules.GetGameTime() then
                                        Ability.CastNoTarget(handle.spell)
                                        ability.defender[caster] = nil
                                    elseif Ability.GetName(handle.spell) == "juggernaut_blade_fury" and date.time + date.castpoint - 0.03 - (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) < GameRules.GetGameTime() then
                                        Ability.CastNoTarget(handle.spell)
                                        ability.defender[caster] = nil
                                    elseif not NPC.HasModifier(caster, "modifier_antimage_counterspell") and not NPC.HasModifier(caster, "modifier_item_lotus_orb_active") and not NPC.HasState(caster, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and (Ability.GetBehavior(handle.spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 and Ability.GetDispellableType(handle.spell) == 1 and Ability.GetCastPoint(handle.spell) == 0 or Ability.GetName(handle.spell) == "item_orchid" or Ability.GetName(handle.spell) == "item_bloodthorn" then
                                        Ability.CastTarget(handle.spell, caster)
                                        ability.defender[caster] = nil
                                    elseif (Ability.GetName(handle.spell) == "item_cyclone" or Ability.GetName(handle.spell) == "item_wind_waker") and date.time + date.castpoint - 0.15 - (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) < GameRules.GetGameTime() then
                                        Ability.CastTarget(handle.spell, me)
                                        ability.defender[caster] = nil
                                    elseif Ability.GetName(handle.spell) == "dawnbreaker_fire_wreath" and NPC.HasModifier(me, "modifier_item_aghanims_shard") and date.time + date.castpoint - 0.35 - (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) < GameRules.GetGameTime() then
                                        Ability.CastPosition(handle.spell, ability.skillshotXYZ(me, caster, 950))
                                        ability.defender[caster] = nil
                                    end
                                end
                                ability.sleeptime[Ability.GetName(handle.spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + date.castpoint
                            end
                            if NPC.GetActivity(date.unit) == 1500 or date.time + date.castpoint * 3 < GameRules.GetGameTime() then
                                ability.defender[caster] = nil
                            end
                        end
                        if (not ability.sleeptime[Ability.GetName(handle.spell)] or GameRules.GetGameTime() > ability.sleeptime[Ability.GetName(handle.spell)]) then
                            if Ability.GetName(handle.spell) == "item_phase_boots" or Ability.GetName(handle.spell) == "item_spider_legs" then
                                if Entity.GetAbsOrigin(me):Distance(Input.GetWorldCursorPos()):Length2D() > 600 and Input.IsKeyDown(Enum.ButtonCode.MOUSE_RIGHT) then
                                    Ability.CastNoTarget(handle.spell)
                                    ability.sleeptime[Ability.GetName(handle.spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                end
                            elseif Ability.GetName(handle.spell) == "item_hand_of_midas" then
                                local unit_table = {}
                                for n, unit in ipairs(Entity.GetUnitsInRadius(me, Ability.GetCastRange(handle.spell) + 350, 0)) do  
                                    if unit and NPC.IsCreep(unit) then
                                        table.insert(unit_table, unit)
                                        if #unit_table > 0 then
                                            table.sort(unit_table, function (a, b) return NPC.GetCurrentLevel(a) > NPC.GetCurrentLevel(b) end)
                                        end
                                    end
                                end
                                if unit_table[1] and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(unit_table[1])):Length2D() < Ability.GetCastRange(handle.spell) then
                                    Ability.CastTarget(handle.spell, unit_table[1])
                                    ability.sleeptime[Ability.GetName(handle.spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                end
                            elseif Ability.GetName(handle.spell) == "item_bottle" then
                                if NPC.HasModifier(me, "modifier_fountain_aura_buff") then
                                    for _, friend in pairs(Entity.GetHeroesInRadius(me, 350, Enum.TeamType.TEAM_FRIEND)) do
                                        if friend and Entity.IsAlive(friend) and (Entity.GetHealth(friend) ~= Entity.GetMaxHealth(friend) or NPC.GetMana(friend) ~= NPC.GetMaxMana(friend)) then
                                            Ability.CastTarget(handle.spell, friend)
                                            ability.sleeptime[Ability.GetName(handle.spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        end
                                    end
                                    if Entity.GetHealth(me) ~= Entity.GetMaxHealth(me) or NPC.GetMana(me) ~= NPC.GetMaxMana(me) then
                                        Ability.CastTarget(handle.spell, me)
                                        ability.sleeptime[Ability.GetName(handle.spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                end
                            end
                        end
                        if Ability.GetName(handle.spell) ~= "tinker_warp_grenade" and (Ability.GetName(handle.spell) == "tinker_heat_seeking_missile" or (Ability.GetBehavior(handle.spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 and target and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < Ability.GetCastRange(handle.spell) or (Ability.GetBehavior(handle.spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT) ~= 0) and (Ability.GetTargetTeam(handle.spell) & Enum.TargetTeam.DOTA_UNIT_TARGET_TEAM_FRIENDLY) == 0 then
                            cast_rearm = false
                        end

                    end
                    if Ability.GetName(handle.spell) == "weaver_time_lapse" then
                        if not ability.tracking[GameRules.GetGameTime()] then
                            ability.tracking[GameRules.GetGameTime()] = Entity.GetHealth(me) / Entity.GetMaxHealth(me)
                        end
                        for time, hp in pairs(ability.tracking) do
                            if time + 5 > GameRules.GetGameTime() and Entity.GetHealth(me) / Entity.GetMaxHealth(me) < hp - 0.5 then
                                if Ability.IsReady(handle.spell) and not NPC.IsStunned(me) and not NPC.IsSilenced(me) then
                                    if NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed") then
                                        Ability.CastTarget(handle.spell, me)
                                        ability.sleeptime[Ability.GetName(handle.spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    else
                                        Ability.CastNoTarget(handle.spell)
                                        ability.sleeptime[Ability.GetName(handle.spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                end
                            end
                            if time + 5 < GameRules.GetGameTime() then
                                ability.tracking[time] = nil
                            end
                        end
                    end

                    if NPC.HasModifier(me, "modifier_morphling_replicate") then
                        if not string.find(Ability.GetName(handle.spell), "morphling_") and not Ability.IsPassive(handle.spell) and not Ability.IsItem(handle.spell) then
                            if Ability.GetCooldown(handle.spell) > 0 then
                                if Ability.IsItem(handle.spell) and ((Ability.GetBehavior(handle.spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 or (Ability.GetBehavior(handle.spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) or (Ability.GetBehavior(handle.spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT) ~= 0) and (Ability.GetTargetTeam(handle.spell) & Enum.TargetTeam.DOTA_UNIT_TARGET_TEAM_FRIENDLY) == 0 and target and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < handle.distance then
                                    cast_replicate = false
                                end
                            else
                                cast_replicate = true
                                --i am not morphling😱
                            end
                        end
                    else
                        cast_replicate = false
                        --i am morphling😃
                    end
                end
            end
            
            for i = 0, 16 do
                local item = NPC.GetItemByIndex(me, i)
                if (i < 6 or i == 16) and item and not NPC.HasModifier(me, "modifier_illusion") then
                    --if not ability.printing[Ability.GetName(item)] then Console.Print(Ability.GetName(item) .. " cost: " .. Item.GetCost(item)) ability.printing[Ability.GetName(item)] = item end
                    local distance = ability.get_distance(item, me)
                    if distance > 200 then distance = distance + 50 end
                    if not ability.handle[Ability.GetName(item)] and Entity.IsAbility(item) then
                        ability.handle[Ability.GetName(item)] = {spell = item, distance = distance}
                    else
                        for name, handle in pairs(ability.handle) do
                            if handle.spell and not Entity.IsAbility(handle.spell) then
                                ability.handle[name] = nil
                            end
                        end
                    end
                    if not ability.sleeptime[Ability.GetName(item)] then
                        ability.sleeptime[Ability.GetName(item)] = 0
                    else
                        if (Ability.IsInAbilityPhase(item) or Ability.SecondsSinceLastUse(item) > 0 and Ability.SecondsSinceLastUse(item) < 0.1) and (ability.sleeptime[Ability.GetName(item)] == 0 or GameRules.GetGameTime() > ability.sleeptime[Ability.GetName(item)]) then if Ability.GetCastPoint(item) > 0 then ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Ability.GetCastPoint(item) else ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5 end end
                    end
                    if target and not NPC.HasState(me, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and Entity.IsAbility(item) and (ability.sleeptime[Ability.GetName(item)] == 0 or GameRules.GetGameTime() > ability.sleeptime[Ability.GetName(item)]) and (Ability.GetName(item) == "item_trickster_cloak" or Ability.GetName(item) == "item_glimmer_cape" or (not ability.channelling[me] or ability.channelling[me] < GameRules.GetGameTime()) and not NPC.IsChannellingAbility(me)) and Ability.IsReady(item) then
                        for _, handle in pairs(ability.handle) do
                            if handle.spell and Entity.IsAbility(handle.spell) then
                                if Ability.GetName(item) == "item_blink" or Ability.GetName(item) == "item_overwhelming_blink" or Ability.GetName(item) == "item_swift_blink" or Ability.GetName(item) == "item_arcane_blink" then
                                    if Ability.IsReady(handle.spell) then
                                        if Ability.GetName(handle.spell) == "legion_commander_duel" then ability.sleeptime["legion_commander_overwhelming_odds"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1 end
                                        if Ability.GetName(handle.spell) == "enigma_black_hole" then ability.sleeptime["enigma_malefice"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 5.5 end
                                    end
                                    if Ability.IsReady(handle.spell) and ((Ability.GetDispellableType(handle.spell) == 1 or Ability.GetName(handle.spell) == "tinker_rearm" or NPC.HasModifier(me, "modifier_legion_commander_press_the_attack") or Ability.GetName(handle.spell) == "enigma_black_hole" or Ability.GetName(handle.spell) == "juggernaut_omni_slash" or Ability.GetName(handle.spell) == "legion_commander_duel" or Ability.GetName(handle.spell) == "axe_berserkers_call" or Ability.GetName(handle.spell) == "nevermore_requiem" or Ability.GetName(handle.spell) == "arc_warden_flux" or Ability.GetName(handle.spell) == "dark_willow_shadow_realm" or Ability.GetName(handle.spell) == "meepo_poof") and Ability.GetName(handle.spell) ~= "meepo_divided_we_stand" and Ability.GetName(handle.spell) ~= "mars_spear") then
                                        if Ability.GetName(handle.spell) == "techies_land_mines" or Ability.GetName(handle.spell) == "storm_spirit_ball_lightning" or NPC.HasModifier(me, "modifier_legion_commander_press_the_attack") or Ability.GetName(handle.spell) == "ancient_apparition_ice_blast" or Ability.GetName(handle.spell) == "meepo_poof" or Ability.GetName(handle.spell) == "death_prophet_exorcism" or Ability.GetName(handle.spell) == "nevermore_requiem" or Ability.GetName(handle.spell) == "dark_willow_shadow_realm" then handle.distance = 0 end
                                        if Ability.GetName(handle.spell) ~= "tinker_rearm" then
                                            if (handle.distance < 410 and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < 1199 or handle.distance > 410 and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < 1199 + handle.distance - 150) and (Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > handle.distance or Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < handle.distance and Ability.GetName(handle.spell) ~= "item_blink") then
                                                if handle.distance > 550 then
                                                    if handle.distance < NPC.GetAttackRange(me) then range = NPC.GetAttackRange(me) else range = handle.distance end
                                                    Ability.CastPosition(item, Entity.GetAbsOrigin(me) + ((ability.skillshotXYZ(me, target, 1600) - Entity.GetAbsOrigin(me)):Normalized():Scaled(Entity.GetAbsOrigin(target):Distance(Entity.GetAbsOrigin(me)):Length2D() + range - 1199)))
                                                    ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                else
                                                    Ability.CastPosition(item, ability.skillshotXYZ(me, target, 900))
                                                    ability.sleeptime["nevermore_shadowraze1"], ability.sleeptime["nevermore_shadowraze2"], ability.sleeptime["nevermore_shadowraze3"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                        else
                                            Ability.CastPosition(item, Input.GetWorldCursorPos())
                                            ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        end
                                    end
                                elseif (Ability.GetName(item) == "item_force_staff" or Ability.GetName(item) == "item_hurricane_pike") then
                                    if ((Ability.GetDispellableType(handle.spell) == 1 or Ability.GetName(handle.spell) == "rubick_fade_bolt" or Ability.GetName(handle.spell) == "rattletrap_power_cogs" or Ability.GetName(handle.spell) == "arc_warden_flux" or Ability.GetName(handle.spell) == "dark_willow_shadow_realm" or Ability.GetName(handle.spell) == "tinker_laser" or Ability.GetName(handle.spell) == "meepo_poof" or Ability.IsUltimate(handle.spell)) and Ability.GetName(handle.spell) ~= "rubick_telekinesis" and Ability.GetName(handle.spell) ~= "rubick_spell_steal" and Ability.GetName(handle.spell) ~= "meepo_divided_we_stand" and Ability.GetName(handle.spell) ~= "tinker_keen_teleport" and Ability.GetName(handle.spell) ~= "dark_willow_terrorize" and Ability.GetName(handle.spell) ~= "mars_spear" and Ability.GetName(handle.spell) ~= "weaver_time_lapse") and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > 600 and NPC.GetTimeToFace(me, target) < 0.03 and Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 1000)):Length2D() < handle.distance + 600 and Ability.IsReady(handle.spell) then
                                        Ability.CastTarget(item, me)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                elseif Ability.GetName(item) == "item_refresher_shard" or Ability.GetName(item) == "item_refresher" then
                                    if Ability.GetType(handle.spell) == 1 and (Ability.GetName(handle.spell) ~= "techies_land_mines" and Ability.SecondsSinceLastUse(handle.spell) > 1 and Ability.SecondsSinceLastUse(handle.spell) < 5 or Ability.GetName(handle.spell) == "techies_land_mines" and Ability.GetCurrentCharges(handle.spell) == 0) and NPC.GetMana(Heroes.GetLocal()) > Ability.GetManaCost(handle.spell) + Ability.GetManaCost(item) then
                                        Ability.CastNoTarget(item)
                                        if Ability.GetName(handle.spell) == "faceless_void_chronosphere" then ability.sleeptime["faceless_void_chronosphere"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Ability.GetLevelSpecialValueFor(handle.spell, "duration") - 1.8 end
                                        ability.sleeptime["item_refresher_shard"], ability.sleeptime["item_refresher"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        if Ability.GetName(handle.spell) == "tidehunter_ravage" then ability.sleeptime["tidehunter_ravage"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Ability.GetLevelSpecialValueFor(handle.spell, "duration") - 1.8 end
                                        ability.sleeptime["item_refresher_shard"], ability.sleeptime["item_refresher"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                elseif Ability.GetName(item) == "item_mask_of_madness" then
                                    if (Ability.GetName(handle.spell) == "faceless_void_chronosphere" or Ability.GetName(handle.spell) == "juggernaut_omni_slash" or Ability.GetName(handle.spell) == "sven_gods_strength") and Ability.SecondsSinceLastUse(handle.spell) > 0 and Ability.SecondsSinceLastUse(handle.spell) < 0.3 then
                                        Ability.CastNoTarget(item)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                elseif Ability.GetName(item) == "item_blade_mail" or Ability.GetName(item) == "item_black_king_bar" and not NPC.HasState(me, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
                                    if NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed") then max_souls = 20 else max_souls = 15 end
                                    if (Ability.GetName(handle.spell) == "nevermore_requiem" and NPC.GetModifier(me, "modifier_nevermore_necromastery") and Modifier.GetStackCount(NPC.GetModifier(me, "modifier_nevermore_necromastery")) > max_souls or Ability.GetName(handle.spell) == "witch_doctor_death_ward" or Ability.GetName(handle.spell) == "crystal_maiden_freezing_field" or Ability.GetName(handle.spell) == "enigma_black_hole" or Ability.GetName(handle.spell) == "axe_berserkers_call" or Ability.GetName(handle.spell) == "legion_commander_duel") and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < handle.distance and Ability.IsReady(handle.spell) then
                                        Ability.CastNoTarget(item)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                elseif Ability.GetName(item) == "item_glimmer_cape" then
                                    if (Ability.GetName(handle.spell) == "witch_doctor_death_ward" or Ability.GetName(handle.spell) == "crystal_maiden_freezing_field" or Ability.GetName(handle.spell) == "pugna_life_drain") and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < handle.distance and NPC.GetActivity(me) == 1513 then
                                        Ability.CastTarget(item, me)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                elseif Ability.GetName(item) == "item_trickster_cloak" then
                                    if (Ability.GetName(handle.spell) == "witch_doctor_death_ward" or Ability.GetName(handle.spell) == "crystal_maiden_freezing_field" or Ability.GetName(handle.spell) == "pugna_life_drain") and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < handle.distance and NPC.GetActivity(me) == 1513 then
                                        Ability.CastNoTarget(item)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                end
                            end
                        end
                        if ((Ability.GetBehavior(item) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 or (Ability.GetBehavior(item) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT) ~= 0) and Ability.GetCooldown(item) > 0 then noitem = true else noitem = false end
                        if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < distance then
                            if (Ability.GetBehavior(item) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 and not NPC.HasModifier(target, "modifier_antimage_counterspell") and not NPC.HasModifier(target, "modifier_item_lotus_orb_active") and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasModifier(me, "modifier_spirit_breaker_charge_of_darkness") then
                                if NPC.IsLinkensProtected(target) then
                                    if Item.GetCost(item) < 3000 then
                                        Ability.CastTarget(item , target)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35
                                    end
                                else
                                    if Ability.GetName(item) == "item_sheepstick" then
                                        if ability.npc_stunned(item, target) then
                                            Ability.CastTarget(item, target)
                                            for _, handle in pairs(ability.handle) do
                                                if handle.spell and Entity.IsAbility(handle.spell) and not Ability.IsItem(handle.spell) and Ability.GetDispellableType(handle.spell) == 1 and Ability.IsReady(handle.spell) then
                                                    ability.sleeptime[Ability.GetName(handle.spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                            ability.sleeptime["item_sheepstick"], ability.sleeptime["item_abyssal_blade"], ability.sleeptime["rubick_telekinesis"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35, GameRules.GetGameTime() + 0.35, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1.5
                                        end
                                    elseif Ability.GetName(item) == "item_abyssal_blade" then
                                        if ability.npc_stunned(item, target) then
                                            Ability.CastTarget(item, target)
                                            for _, handle in pairs(ability.handle) do
                                                if handle.spell and Entity.IsAbility(handle.spell) and not Ability.IsItem(handle.spell) and Ability.GetDispellableType(handle.spell) == 1 and Ability.IsReady(handle.spell) then
                                                    ability.sleeptime[Ability.GetName(handle.spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                            ability.sleeptime["item_sheepstick"], ability.sleeptime["item_abyssal_blade"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35
                                        end
                                    elseif Ability.GetName(item) == "item_bloodthorn" or Ability.GetName(item) == "item_orchid" then
                                        local popitem = NPC.GetItem(target, "item_black_king_bar") or NPC.GetItem(target, "item_manta")
                                        if (not popitem or popitem and Ability.GetCooldown(popitem) > 0) and not NPC.IsSilenced(target) then
                                            Ability.CastTarget(item, target)
                                            ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35
                                        end
                                    elseif Ability.GetName(item) == "item_nullifier" then
                                        if NPC.HasModifier(target, "modifier_teleporting") or NPC.HasModifier(target, "modifier_item_aeon_disk_buff") or NPC.HasModifier(target, "modifier_eul_cyclone") or NPC.HasModifier(target, "modifier_wind_waker") or NPC.HasModifier(target, "modifier_ghost_state") or NPC.HasModifier(target, "modifier_item_satanic_unholy") or (NPC.HasModifier(target, "modifier_item_armlet_unholy_strength") and Entity.GetHealth(target) < 600) or NPC.HasModifier(target, "modifier_item_ethereal_blade_ethereal") and not NPC.HasModifier(target, "modifier_item_ethereal_blade_slow") then
                                            Ability.CastTarget(item, target)
                                            ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        end
                                    elseif Ability.GetName(item) == "item_ethereal_blade" then
                                        Ability.CastTarget(item, target)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    elseif Ability.GetName(item) == "item_dagon_1" or Ability.GetName(item) == "item_dagon_2" or Ability.GetName(item) == "item_dagon_3" or Ability.GetName(item) == "item_dagon_4" or Ability.GetName(item) == "item_dagon_5" then
                                        if not ethereal_blade or ethereal_blade and Ability.SecondsSinceLastUse(ethereal_blade) > Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 2200 and Ability.SecondsSinceLastUse(ethereal_blade) < 4 then
                                            Ability.CastTarget(item, target)
                                            ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        end
                                    elseif Ability.GetName(item) == "item_psychic_headband" then
                                        if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < NPC.GetAttackRange(target) and NPC.GetTimeToFace(target, me) < 0.03 and NPC.IsAttacking(target) then
                                            Ability.CastTarget(item, target)
                                            ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        end
                                    elseif Ability.GetName(item) == "item_wind_waker" or Ability.GetName(item) == "item_cyclone" then
                                    else
                                        if (Ability.GetTargetTeam(item) & Enum.TargetTeam.DOTA_UNIT_TARGET_TEAM_FRIENDLY) == 0 then
                                            Ability.CastTarget(item, target)
                                            ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        end
                                    end
                                end
                            elseif (Ability.GetBehavior(item) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 and Ability.GetName(item) ~= "item_ward_observer" and Ability.GetName(item) ~= "item_ward_dispenser" and Ability.GetName(item) ~= "item_pirate_hat" and Ability.GetName(item) ~= "item_trusty_shovel" and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasModifier(me, "modifier_spirit_breaker_charge_of_darkness") and (Ability.GetManaCost(item) > 0 or Ability.GetName(item) == "item_seer_stone" or Ability.GetName(item) == "item_fallen_sky") then
                                Ability.CastPosition(item, ability.skillshotAOE(me, target, 650))
                            elseif (Ability.GetBehavior(item) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 and Ability.GetName(item) ~= "item_power_treads" then
                                if Ability.GetName(item) == "item_ex_machina" then
                                    if not noitem then Ability.CastNoTarget(item) end
                                elseif Ability.GetName(item) == "item_bloodstone" or Ability.GetName(item) == "item_magic_wand" or Ability.GetName(item) == "item_magic_stick" or Ability.GetName(item) == "item_faerie_fire" or Ability.GetName(item) == "item_essence_ring" then
                                    if Entity.GetHealth(me) / Entity.GetMaxHealth(me) < 0.35 then
                                        Ability.CastNoTarget(item)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                elseif Ability.GetName(item) == "item_enchanted_mango" then
                                    if NPC.GetMana(me) / NPC.GetMaxMana(me) < 0.3 then
                                        Ability.CastNoTarget(item)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                elseif Ability.GetName(item) == "item_guardian_greaves" then
                                    if NPC.GetMana(me) / NPC.GetMaxMana(me) < 0.5 then
                                        Ability.CastNoTarget(item)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                elseif Ability.GetName(item) == "item_silver_edge" or Ability.GetName(item) == "item_invis_sword" then
                                    if Entity.GetField(me, "m_iTaggedAsVisibleByTeam") == 22 and NPC.GetUnitName(me) ~= "npc_dota_hero_spirit_breaker" or NPC.HasModifier(me, "modifier_spirit_breaker_charge_of_darkness") then
                                        Ability.CastNoTarget(item)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                elseif Ability.GetName(item) == "item_manta" then
                                    if NPC.IsSilenced(me) then
                                        Ability.CastNoTarget(item)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                elseif Ability.GetName(item) == "item_soul_ring" then
                                    if Entity.GetHealth(me) / Entity.GetMaxHealth(me) > 0.3 then
                                        Ability.CastNoTarget(item)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                    end
                                elseif Ability.GetName(item) == "item_revenants_brooch" then
                                    if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < NPC.GetAttackRange(me) then
                                        Ability.CastNoTarget(item)
                                        ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 15
                                    end
                                elseif Ability.GetName(item) == "item_smoke_of_deceit" then
                                elseif Ability.GetName(item) == "item_dust" then
                                elseif Ability.GetName(item) == "item_bottle" then
                                elseif Ability.GetName(item) == "item_ghost" then
                                elseif Ability.GetName(item) == "item_stormcrafter" then
                                elseif Ability.GetName(item) == "item_trickster_cloak" then
                                elseif Ability.GetName(item) == "item_black_king_bar" then
                                elseif Ability.GetName(item) == "item_radiance" then
                                elseif Ability.GetName(item) == "item_armlet" then
                                elseif Ability.GetName(item) == "item_blade_mail" then
                                elseif Ability.GetName(item) == "item_power_treads" then
                                elseif Ability.GetName(item) == "item_pogo_stick" then
                                elseif Ability.GetName(item) == "item_ring_of_aquila" then
                                elseif Ability.GetName(item) == "item_vambrace" then
                                elseif Ability.GetName(item) == "item_refresher_shard" or Ability.GetName(item) == "item_refresher" or Ability.GetName(item) == "item_mask_of_madness" then
                                else
                                    Ability.CastNoTarget(item)
                                    ability.sleeptime[Ability.GetName(item)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                end
                            end
                        end
                    end
                end
            end
            for a = 0, 15 do
                local spell = NPC.GetAbilityByIndex(me, a)
                if spell and Ability.GetName(spell) == "phoenix_sun_ray_toggle_move" and not Ability.IsActivated(spell) then toggle_move = false end
                if not NPC.HasModifier(me, "modifier_illusion") and spell and not Ability.IsAttributes(spell) and (Ability.IsActivated(spell) or Ability.GetName(spell) == "monkey_king_primal_spring") and not Ability.IsHidden(spell) and Entity.IsAbility(spell) and Ability.GetName(spell) ~= "plus_high_five" and Ability.GetName(spell) ~= "techies_minefield_sign" then
                    local distance = ability.get_distance(spell, me)
                    if distance > 0 and distance < 200 then distance = distance + 150 end
                    if distance == NPC.GetAttackRange(me) then distance = distance + 60 end
                    if NPC.GetAbility(me, "special_bonus_unique_rubick") and Ability.GetLevel(NPC.GetAbility(me, "special_bonus_unique_rubick")) > 0 then throw_range = 837.5 else throw_range = 537.5 end
                    --if spell and not ability.printing[Ability.GetName(spell)] then Console.Print("name " .. Ability.GetName(spell) .. " distance " .. distance) ability.printing[Ability.GetName(spell)] = spell end
                    
                    if not ability.sleeptime[Ability.GetName(spell)] then
                        ability.sleeptime[Ability.GetName(spell)] = 0
                    else
                        if (Ability.IsInAbilityPhase(spell) or Ability.SecondsSinceLastUse(spell) > 0 and Ability.SecondsSinceLastUse(spell) < 0.1) and (ability.sleeptime[Ability.GetName(spell)] == 0 or GameRules.GetGameTime() > ability.sleeptime[Ability.GetName(spell)]) then if Ability.GetCastPoint(spell) > 0 then ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Ability.GetCastPoint(spell) else ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5 end end
                    end

                    if Ability.GetLevel(spell) > 0 then
                        if Ability.IsReady(spell) then
                            if Ability.GetName(spell) == "legion_commander_press_the_attack" then ability.sleeptime["item_blink"], ability.sleeptime["item_overwhelming_blink"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1 end
                            if Ability.GetName(spell) == "axe_berserkers_call" and target and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < distance then ability.sleeptime["axe_battle_hunger"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1 end
                            if Ability.GetName(spell) == "tusk_walrus_punch" then ability.sleeptime["tusk_walrus_kick"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1 end
                            if Ability.GetName(spell) == "tusk_snowball" then ability.sleeptime["tusk_ice_shards"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1 end
                            if Ability.GetName(spell) == "tusk_walrus_kick" then ability.sleeptime["tusk_ice_shards"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 2 end
                            if Ability.GetName(spell) == "mars_arena_of_blood" then ability.sleeptime["mars_gods_rebuke"], ability.sleeptime["mars_spear"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1, GameRules.GetGameTime() + 0.1 end
                            if Ability.GetName(spell) == "mars_spear" and target then ability.sleeptime["mars_gods_rebuke"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 300 end
                            if Ability.GetName(spell) == "storm_spirit_electric_vortex" then ability.sleeptime["storm_spirit_static_remnant"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1 end
                            if Ability.GetName(spell) == "enigma_midnight_pulse" then ability.sleeptime["enigma_black_hole"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1 end
                            if Ability.GetName(spell) == "dark_seer_vacuum" then ability.sleeptime["dark_seer_wall_of_replica"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.6 end
                            if Ability.GetName(spell) == "primal_beast_rock_throw" then ability.sleeptime["primal_beast_onslaught"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1 end
                            if Ability.GetName(spell) == "primal_beast_pulverize" then ability.sleeptime["primal_beast_trample"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1 end
                            if Ability.GetName(spell) == "kunkka_torrent" then ability.sleeptime["kunkka_tidal_wave"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1.4 end
                            if Ability.GetName(spell) == "kunkka_ghostship" then ability.sleeptime["kunkka_tidal_wave"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 3.5 end
                            if Ability.GetName(spell) == "earth_spirit_geomagnetic_grip" then ability.sleeptime["earth_spirit_rolling_boulder"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1 end
                            if Ability.GetName(spell) == "windrunner_shackleshot" then ability.sleeptime["windrunner_powershot"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1 end
                            --if Ability.GetName(spell) == "monkey_king_boundless_strike" then ability.sleeptime["monkey_king_primal_spring"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1 end
                            if Ability.GetName(spell) == "faceless_void_chronosphere" then ability.sleeptime["faceless_void_time_dilation"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1 end
                            if Ability.GetName(spell) == "skywrath_mage_ancient_seal" then ability.sleeptime["skywrath_mage_mystic_flare"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1 end
                            if Ability.GetName(spell) == "puck_illusory_orb" and target then ability.sleeptime["puck_ethereal_jaunt"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 490 end
                            if Ability.GetName(spell) == "lion_impale" then ability.sleeptime["lion_voodoo"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1 end
                            if Ability.GetName(spell) == "leshrac_lightning_storm" then ability.sleeptime["leshrac_split_earth"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1 end
                            if Ability.GetName(spell) == "grimstroke_dark_portrait" then ability.sleeptime["grimstroke_spirit_walk"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1 end
                            if Ability.GetName(spell) == "dawnbreaker_celestial_hammer" and target then ability.sleeptime["dawnbreaker_converge"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 1700 end
                            if Ability.IsStolen(spell) and (Ability.IsUltimate(spell) or Ability.GetDispellableType(spell) == 1) then ability.sleeptime["rubick_telekinesis"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5 end
                        end
                        if not ability.handle[Ability.GetName(spell)] and Entity.IsAbility(spell) then
                            ability.handle[Ability.GetName(spell)] = {spell = spell, distance = distance}
                        else
                            for name, handle in pairs(ability.handle) do
                                if handle.spell and not Entity.IsAbility(handle.spell) then
                                    ability.handle[name] = nil
                                end
                            end
                        end
                    end

                    if target then
                        if NPC.GetActivity(me) == 1723 and ability.cast_pos["monkey_king_primal_spring"] and Entity.GetAbsOrigin(target):Distance(ability.cast_pos["monkey_king_primal_spring"]):Length2D() > 150 then
                            Player.PrepareUnitOrders(Players.GetLocal(), 21, nil, Vector(), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, me)
                            ability.cast_pos["monkey_king_primal_spring"] = nil
                        end
                        if ability.calling[NPC.GetUnitName(target)] and ability.calling[NPC.GetUnitName(target)] == "damaged" and not NPC.HasModifier(me, "modifier_weaver_shukuchi") then
                            ability.calling[NPC.GetUnitName(target)] = nil
                        end
                    end
                    if Ability.GetName(spell) == "meepo_poof" and ability.cast_pos["meepo_poof"] and Ability.SecondsSinceLastUse(spell) > 3 then ability.cast_pos["meepo_poof"] = nil end

                    if ability5 and Ability.GetName(ability5) == "rubick_spell_steal" then
                        if Ability.GetName(spell) == "wisp_spirits_in" or Ability.GetName(spell) == "shredder_return_chakram" or Ability.GetName(spell) == "pangolier_gyroshell_stop" or Ability.GetCooldown(spell) > 0 or ((Ability.GetName(spell) == "slark_pounce" or Ability.GetName(spell) == "ember_spirit_fire_remnant" or Ability.GetName(spell) == "sniper_shrapnel" or Ability.GetName(spell) == "void_spirit_resonant_pulse" or Ability.GetName(spell) == "void_spirit_astral_step" or Ability.GetName(spell) == "hoodwink_scurry" or Ability.GetName(spell) == "techies_land_mines") and Ability.GetCurrentCharges(spell) == 0) then
                            if Ability.GetName(spell) == "void_spirit_resonant_pulse" then
                                if NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed") then ability.cooldown[Ability.GetName(spell)] = 32 else ability.cooldown[Ability.GetName(spell)] = 16 end
                            elseif Ability.GetName(spell) == "void_spirit_astral_step" then
                                if Ability.GetLevel(spell) == 1 then
                                    ability.cooldown[Ability.GetName(spell)] = 60
                                elseif Ability.GetLevel(spell) == 2 then
                                    ability.cooldown[Ability.GetName(spell)] = 50
                                elseif Ability.GetLevel(spell) == 3 then
                                    ability.cooldown[Ability.GetName(spell)] = 40
                                end
                            elseif Ability.GetName(spell) == "ember_spirit_fire_remnant" then
                                if NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed") then
                                    ability.cooldown[Ability.GetName(spell)] = 190
                                else
                                    ability.cooldown[Ability.GetName(spell)] = 114
                                end
                            elseif Ability.GetName(spell) == "sniper_shrapnel" then
                                ability.cooldown[Ability.GetName(spell)] = 175
                            elseif Ability.GetName(spell) == "wisp_spirits_in" then
                                ability.cooldown[Ability.GetName(spell)] = 20
                            elseif Ability.GetName(spell) == "pangolier_gyroshell_stop" then
                                ability.cooldown[Ability.GetName(spell)] = 70
                            elseif Ability.GetName(spell) == "shredder_return_chakram" then
                                ability.cooldown["shredder_chakram"] = 8
                            elseif Ability.GetName(spell) == "hoodwink_scurry" then
                                ability.cooldown[Ability.GetName(spell)] = 30
                            elseif Ability.GetName(spell) == "techies_land_mines" then
                                ability.cooldown[Ability.GetName(spell)] = 40
                            elseif Ability.GetCooldownLength(spell) > 0 then
                                ability.cooldown[Ability.GetName(spell)] = Ability.GetCooldownLength(spell)
                            end
                            ability.casttime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1))
                        end
                        
                        for enemyindex = 1, Heroes.Count() do
                            local enemy = Heroes.Get(enemyindex)
                            if enemy and not Entity.IsSameTeam(me, enemy) then
                                for x = 0, 24 do
                                    local enemyspell = NPC.GetAbilityByIndex(enemy, x)
                                    if enemyspell and not Ability.IsAttributes(enemyspell) and (not Ability.IsPassive(enemyspell) or Ability.IsPassive(enemyspell) and Ability.IsActivated(enemyspell) and Ability.GetManaCost(enemyspell) > 0) and Entity.IsAbility(enemyspell) then
                                        if Ability.SecondsSinceLastUse(enemyspell) > 0 and Ability.SecondsSinceLastUse(enemyspell) < 0.1 or Ability.GetToggleState(enemyspell) or ability.calling[NPC.GetUnitName(enemy)] and ability.calling[NPC.GetUnitName(enemy)] ~= Ability.GetName(ability3) and ability.calling[NPC.GetUnitName(enemy)] == Ability.GetName(enemyspell) or Ability.GetName(enemyspell) == "ancient_apparition_ice_blast" and Ability.IsInAbilityPhase(enemyspell) then
                                            ability.spellinfo[enemy] = {unit = enemy, spell = enemyspell, radius = ability.get_distance(enemyspell, enemy), time = ability.cooldown[Ability.GetName(enemyspell)], start_time = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)), type = Ability.GetType(enemyspell)}
                                        end
                                    end
                                end
                            end
                        end
                        
                        for enemy, value in pairs(ability.spellinfo) do
                            if value then
                                if value.unit and not Entity.IsDormant(value.unit) and Entity.IsAlive(value.unit) and not ability.mutedspell(Ability.GetName(value.spell)) then
                                    if Entity.IsAlive(me) and not NPC.IsChannellingAbility(me) and not NPC.IsStunned(me) and not NPC.IsSilenced(me) and Ability.IsReady(ability5) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(value.unit)):Length2D() < Ability.GetCastRange(ability5) and Ability.GetName(ability3) ~= Ability.GetName(value.spell) and Ability.GetName(ability4) ~= Ability.GetName(value.spell) and not NPC.HasState(me, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and not NPC.HasModifier(me, "modifier_phoenix_sun_ray") and not NPC.HasModifier(me, "modifier_ember_spirit_fire_remnant_timer") then
                                        if not ability.casttime[Ability.GetName(value.spell)] or ability.casttime[Ability.GetName(value.spell)] and value.time and ((GameRules.GetGameTime() - ability.casttime[Ability.GetName(value.spell)])) > value.time then
                                            if Ability.IsUltimate(value.spell) or value.radius > 530 or value.radius > 0 and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(value.unit)):Length2D() < value.radius then
                                                if (NPC.GetAbility(me, "rubick_empty2") or Ability.GetCooldown(ability4) > 0 or ((Ability.GetName(ability4) == "shadow_demon_demonic_purge" or Ability.GetName(ability4) == "obsidian_destroyer_astral_imprisonment" or Ability.GetName(ability4) == "windrunner_windrun" or Ability.GetName(ability4) == "slark_pounce" or Ability.GetName(ability4) == "ember_spirit_fire_remnant" or Ability.GetName(ability4) == "sniper_shrapnel" or Ability.GetName(ability4) == "brewmaster_primal_split" or Ability.GetName(ability4) == "void_spirit_resonant_pulse" or Ability.GetName(ability4) == "void_spirit_astral_step" or Ability.GetName(ability4) == "hoodwink_scurry" or Ability.GetName(ability4) == "dark_seer_ion_shell" or Ability.GetName(ability4) == "techies_land_mines") and Ability.GetCurrentCharges(ability4) == 0)) and (NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed")) or NPC.GetAbility(me, "rubick_empty1") or Ability.GetCooldown(ability3) > 0 or ((Ability.GetName(ability3) == "shadow_demon_demonic_purge" or Ability.GetName(ability3) == "obsidian_destroyer_astral_imprisonment" or Ability.GetName(ability3) == "windrunner_windrun" or Ability.GetName(ability3) == "slark_pounce" or Ability.GetName(ability3) == "ember_spirit_fire_remnant" or Ability.GetName(ability3) == "sniper_shrapnel" or Ability.GetName(ability3) == "brewmaster_primal_split" or Ability.GetName(ability3) == "void_spirit_resonant_pulse" or Ability.GetName(ability3) == "void_spirit_astral_step" or Ability.GetName(ability3) == "hoodwink_scurry" or Ability.GetName(ability3) == "dark_seer_ion_shell" or Ability.GetName(ability3) == "techies_land_mines") and Ability.GetCurrentCharges(ability3) == 0) then
                                                    if (Ability.GetName(ability3) ~= "snapfire_mortimer_kisses" or Ability.GetName(ability3) == "snapfire_mortimer_kisses" and Ability.SecondsSinceLastUse(ability3) > 1 or Ability.GetName(ability4) ~= "snapfire_mortimer_kisses" or Ability.GetName(ability4) == "snapfire_mortimer_kisses" and Ability.SecondsSinceLastUse(ability4) > 1) and not NPC.HasModifier(me, "modifier_snapfire_mortimer_kisses") then
                                                        if (Ability.GetName(ability3) ~= "luna_eclipse" or Ability.GetName(ability3) == "luna_eclipse" and Ability.SecondsSinceLastUse(ability3) > 1 or Ability.GetName(ability4) ~= "luna_eclipse" or Ability.GetName(ability4) == "luna_eclipse" and Ability.SecondsSinceLastUse(ability4) > 1) and not NPC.HasModifier(me, "modifier_luna_eclipse") then
                                                            if not NPC.HasState(value.unit, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.HasModifier(value.unit, "modifier_dark_willow_shadow_realm_buff") and (ability.sleeptime["rubick_spell_steal"] == 0 or GameRules.GetGameTime() > ability.sleeptime["rubick_spell_steal"]) then
                                                                if (value.type == 1 and 
                                                                    Ability.GetName(value.spell) ~= "tinker_rearm" and Ability.GetName(value.spell) ~= "nevermore_requiem" or 
                                                                    ((Ability.GetName(value.spell) == "nevermore_requiem" and NPC.GetModifier(value.unit, "modifier_nevermore_necromastery") and Modifier.GetStackCount(NPC.GetModifier(value.unit, "modifier_nevermore_necromastery")) > 15))) or 
                                                                    (value.type == 0 and (Ability.GetDispellableType(value.spell) == 1 and Ability.GetLevel(value.spell) > 1 or 
                                                                    (Menu.IsKeyDown(ability.spellkey) and 
                                                                    (Ability.GetName(value.spell) == "invoker_sun_strike" and Ability.GetLevel(ability0) > 2 or 
                                                                    (Ability.GetDamageType(value.spell) == 2 or Ability.GetDamageType(value.spell) == 4) and Ability.GetLevel(value.spell) > 2 or 
                                                                    Ability.GetName(value.spell) == "windrunner_gale_force" or 
                                                                    Ability.GetName(value.spell) == "grimstroke_scepter" or 
                                                                    Ability.GetName(value.spell) == "zuus_cloud" or 
                                                                    Ability.GetName(value.spell) == "invoker_tornado" or 
                                                                    Ability.GetName(value.spell) == "invoker_emp" or 
                                                                    Ability.GetName(value.spell) == "invoker_chaos_meteor" or 
                                                                    Ability.GetName(value.spell) == "invoker_deafening_blast" or 
                                                                    Ability.GetName(value.spell) == "snapfire_gobble_up" or 
                                                                    Ability.GetName(value.spell) == "terrorblade_terror_wave" or 
                                                                    Ability.GetName(value.spell) == "kunkka_torrent_storm" or 
                                                                    Ability.GetName(value.spell) == "sniper_shrapnel" and Ability.GetLevel(value.spell) > 1))))
                                                                then
                                                                    Ability.CastTarget(ability5, value.unit)
                                                                    ability.sleeptime[Ability.GetName(ability5)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if ability.calling[NPC.GetUnitName(value.unit)] then
                                        ability.calling[NPC.GetUnitName(value.unit)] = nil
                                    end
                                    ability.spellinfo[value.unit] = nil
                                end
                            end
                        end
                    end

                    if Ability.GetName(spell) ~= "rubick_spell_steal" and Ability.IsReady(spell) and Ability.IsCastable(spell, NPC.GetMana(me)) and (not NPC.IsChannellingAbility(me) or Ability.GetName(spell) == "pudge_rot") then
                        if target and ability.safe_cast(me, target) then
                            if ((Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 or (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_TOGGLE) ~= 0) and NPC.GetTimeToFace(target, me) > 0.03 and NPC.IsRunning(target) then distance = distance - NPC.GetMoveSpeed(target) end
                            if not NPC.HasModifier(me, "modifier_snapfire_mortimer_kisses") and (not NPC.HasState(me, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) or Ability.GetName(spell) == "riki_blink_strike" or target and ability.calling[NPC.GetUnitName(target)] and ability.calling[NPC.GetUnitName(target)] == "damaged" or Ability.GetName(spell) == "bounty_hunter_track") and not NPC.HasModifier(me, "modifier_meepo_petrify") and ability.npc_stunned(spell, target) and (ability.sleeptime[Ability.GetName(spell)] == 0 or GameRules.GetGameTime() > ability.sleeptime[Ability.GetName(spell)]) and (not ability.channelling[me] or ability.channelling[me] < GameRules.GetGameTime()) and not NPC.IsChannellingAbility(me) and not NPC.IsStunned(me) and not NPC.IsSilenced(me) and Ability.IsReady(spell) then
                                if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < distance and (Ability.GetName(spell) == "tinker_keen_teleport" or Ability.GetDamageType(spell) ~= 2 or Ability.GetDamageType(spell) == 2 and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)) and (ethereal_blade and Ability.GetDamageType(spell) ~= 2 or not ethereal_blade or ethereal_blade and (Ability.SecondsSinceLastUse(ethereal_blade) > Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 1250 or Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > Ability.GetCastRange(ethereal_blade))) then
                                    if (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
                                        if Ability.GetName(spell) == "void_spirit_resonant_pulse" and (NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed")) then
                                            if Ability.GetCurrentCharges(spell) > 0 and not NPC.HasModifier(me, "modifier_void_spirit_resonant_pulse_physical_buff") then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "nevermore_shadowraze1" or Ability.GetName(spell) == "nevermore_shadowraze2" or Ability.GetName(spell) == "nevermore_shadowraze3" or Ability.GetName(spell) == "slark_pounce" then
                                            if (Ability.GetName(spell) == "nevermore_shadowraze1" or Ability.GetName(spell) == "slark_pounce" or Ability.GetName(spell) == "nevermore_shadowraze2" and Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 900)):Length2D() > 250 or Ability.GetName(spell) == "nevermore_shadowraze3" and Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 900)):Length2D() > 450) and Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 900)):Length2D() < distance and NPC.GetTimeToFace(me, target) < 0.01 then
                                                Ability.CastNoTarget(spell)
                                                ability.channelling[me], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Ability.GetCastPoint(spell), GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Ability.GetCastPoint(spell)
                                            end
                                        elseif Ability.GetName(spell) == "ancient_apparition_ice_blast_release" then
                                            Ability.CastNoTarget(spell)
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "tinker_rearm" then
                                            if cast_rearm then
                                                Ability.CastNoTarget(spell)
                                                ability.channelling[me], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Ability.GetLevelSpecialValueFor(spell, "AbilityChannelTime")
                                            end
                                        elseif Ability.GetName(spell) == "leshrac_pulse_nova" then
                                            if NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed") then radius = 750 else radius = 450 end
                                            if not Ability.GetToggleState(spell) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < radius then
                                                Ability.Toggle(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            elseif Ability.GetToggleState(spell) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > radius then
                                                Ability.Toggle(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "shredder_return_chakram" then
                                            if not NPC.HasModifier(target, "modifier_shredder_chakram_debuff") then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "shredder_return_chakram_2" then
                                            if not NPC.HasModifier(target, "modifier_shredder_chakram_debuff") then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "terrorblade_terror_wave" or Ability.GetName(spell) == "earthshaker_echo_slam" or Ability.GetName(spell) == "kunkka_torrent_storm" or Ability.GetName(spell) == "magnataur_reverse_polarity" or Ability.GetName(spell) == "tidehunter_ravage" or Ability.GetName(spell) == "treant_overgrowth" or Ability.GetName(spell) == "medusa_stone_gaze" then
                                            if #Heroes.InRadius(Entity.GetAbsOrigin(me), distance, Entity.GetTeamNum(me), 0) > 1 then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "alchemist_unstable_concoction" then
                                            Ability.CastNoTarget(spell)
                                            ability.sleeptime["alchemist_unstable_concoction_throw"], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 4, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "pangolier_gyroshell_stop" then
                                            if NPC.HasModifier(me, "modifier_pangolier_gyroshell") then
                                                Player.PrepareUnitOrders(Players.GetLocal(), 1, nil, Input.GetWorldCursorPos(), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, me)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "alchemist_chemical_rage" or Ability.GetName(spell) == "sniper_take_aim" then
                                            if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < NPC.GetAttackRange(me) + 200 then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "visage_summon_familiars_stone_form" then
                                            Ability.CastNoTarget(spell)
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1.5
                                        elseif Ability.GetName(spell) == "void_spirit_dissimilate" then
                                            if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < 699 and (NPC.IsStunned(target) or NPC.IsRooted(target) or NPC.HasModifier(target, "modifier_void_spirit_aether_remnant_pull")) then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "pudge_rot" then
                                            if not Ability.GetToggleState(spell) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < 300 then
                                                Ability.Toggle(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            elseif Ability.GetToggleState(spell) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > 300 then
                                                Ability.Toggle(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "bloodseeker_blood_mist" then
                                            if not Ability.GetToggleState(spell) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < 450 then
                                                Ability.Toggle(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            elseif Ability.GetToggleState(spell) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > 450 then
                                                Ability.Toggle(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "templar_assassin_meld" then
                                            if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < NPC.GetAttackRange(me) then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "phoenix_sun_ray_toggle_move" then
                                            if not toggle_move and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > 900 then
                                                Ability.CastNoTarget(spell)
                                                toggle_move = true
                                            elseif toggle_move and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < 900 then
                                                Ability.CastNoTarget(spell)
                                                toggle_move = false
                                            end
                                            --nah?!
                                        elseif Ability.GetName(spell) == "magnataur_horn_toss" then
                                            if ability5 and (Ability.SecondsSinceLastUse(ability5) > 1 or Ability.SecondsSinceLastUse(ability5) < 0) then
                                                local unit = {}
                                                for i, v in ipairs(Entity.GetUnitsInRadius(me, distance + 1200, 2)) do
                                                    if v and not Entity.IsDormant(v) and (NPC.IsTower(v) or NPC.IsHero(v) or NPC.GetUnitName(v) == "dota_fountain") then
                                                        table.insert(unit, v)
                                                        if #unit > 0 then
                                                            table.sort(unit, function (a, b) return Entity.GetAbsOrigin(a):Distance(Entity.GetAbsOrigin(b)):Length2D() > Entity.GetAbsOrigin(b):Distance(Entity.GetAbsOrigin(a)):Length2D() end)
                                                        end
                                                    end
                                                end
                                                if  unit[1] and (ability.skillshotXYZ(me, target, 950):GetX() - Entity.GetAbsOrigin(me):GetX()) / (Entity.GetAbsOrigin(unit[1]):GetX() - Entity.GetAbsOrigin(me):GetX()) < 0 and (ability.skillshotXYZ(me, target, 950):GetY() - Entity.GetAbsOrigin(me):GetY()) / (Entity.GetAbsOrigin(unit[1]):GetY() - Entity.GetAbsOrigin(me):GetY()) < 0 and math.abs((ability.skillshotXYZ(me, target, 950):GetX() - Entity.GetAbsOrigin(me):GetX()) / (Entity.GetAbsOrigin(unit[1]):GetX() - Entity.GetAbsOrigin(me):GetX()) - (ability.skillshotXYZ(me, target, 950):GetY() - Entity.GetAbsOrigin(me):GetY()) / (Entity.GetAbsOrigin(unit[1]):GetY() - Entity.GetAbsOrigin(me):GetY())) < 0.3 then
                                                    Ability.CastNoTarget(spell)
                                                    ability.sleeptime["magnataur_reverse_polarity"], ability.sleeptime["magnataur_shockwave"], ability.sleeptime["magnataur_greater_shockwave"], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5, GameRules.GetGameTime() + 0.6, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                        elseif Ability.GetName(spell) == "visage_gravekeepers_cloak" or Ability.GetName(spell) == "meepo_petrify" or Ability.GetName(spell) == "huskar_inner_fire" or Ability.GetName(spell) == "troll_warlord_battle_trance" then
                                            if Entity.GetHealth(me) / Entity.GetMaxHealth(me) < 0.3 then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "elder_titan_echo_stomp" then
                                            if Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() < 500 then Ability.CastNoTarget(spell) end
                                            for i, v in ipairs(Entity.GetUnitsInRadius(me, distance, 2)) do
                                                if v and NPC.GetUnitName(v) == "npc_dota_elder_titan_ancestral_spirit" and Entity.GetAbsOrigin(v):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() < 500 then
                                                    Ability.CastNoTarget(spell)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                        elseif Ability.GetName(spell) == "keeper_of_the_light_recall" then
                                            for _, unit in ipairs(Entity.GetHeroesInRadius(me, distance, 2)) do
                                                if unit and Entity.GetHealth(unit) / Entity.GetMaxHealth(unit) > 0.6 and Entity.GetAbsOrigin(unit):Distance(Entity.GetAbsOrigin(me)):Length2D() > 3000 then
                                                    Ability.CastTarget(spell, unit)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                        elseif Ability.GetName(spell) == "troll_warlord_berserkers_rage" then
                                            if Ability.GetToggleState(spell) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > NPC.GetAttackRange(me) + 100 then
                                                Ability.Toggle(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 500
                                            elseif not Ability.GetToggleState(spell) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < NPC.GetAttackRange(me) + 100 then
                                                Ability.Toggle(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 500
                                            end
                                        elseif Ability.GetName(spell) == "clinkz_wind_walk" then
                                            if Ability.IsStolen(spell) or NPC.HasModifier(me, "modifier_clinkz_piercing_arrow") and NPC.GetTimeToFace(target, me) < 0.03 then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "winter_wyvern_arctic_burn" then
                                            if not NPC.HasModifier(me, "modifier_winter_wyvern_arctic_burn_flight") then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "techies_reactive_tazer" then
                                            for _, unit in ipairs(Entity.GetUnitsInRadius(me, distance, 0, true)) do
                                                if unit and NPC.IsHero(unit) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(unit)):Length2D() < NPC.GetAttackRange(unit) + 150 and NPC.GetTimeToFace(target, me) < 0.03 then
                                                    Ability.CastNoTarget(spell)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                        elseif Ability.GetName(spell) == "skeleton_king_vampiric_aura" then
                                            if NPC.GetModifier(me, "modifier_skeleton_king_vampiric_aura") and Modifier.GetStackCount(NPC.GetModifier(me, "modifier_skeleton_king_vampiric_aura")) > 6 then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "shadow_demon_shadow_poison_release" then
                                            if NPC.GetModifier(target, "modifier_shadow_demon_shadow_poison") and Entity.GetHealth(target) + NPC.GetHealthRegen(target) < (stack_damage + 50) * Modifier.GetStackCount(NPC.GetModifier(target, "modifier_shadow_demon_shadow_poison")) * NPC.GetMagicalArmorDamageMultiplier(target) then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "brewmaster_drunken_brawler" then
                                            if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > NPC.GetAttackRange(me) + 150 and ability.calling[NPC.GetUnitName(me)] ~= "stance_storm" then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.15
                                            elseif Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < NPC.GetAttackRange(me) + 50 and ability.calling[NPC.GetUnitName(me)] ~= "stance_fire" then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.15
                                            end
                                        elseif not Ability.IsStolen(spell) and Ability.GetName(spell) == "zuus_thundergods_wrath" then
                                            if Entity.GetHealth(target) + NPC.GetHealthRegen(target) < Ability.GetLevelSpecialValueFor(spell, "damage") * NPC.GetMagicalArmorDamageMultiplier(target) then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif not Ability.IsStolen(spell) and Ability.GetName(spell) == "nevermore_requiem" then
                                            if NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed") then max_souls = 20 else max_souls = 15 end
                                            if NPC.GetModifier(me, "modifier_nevermore_necromastery") and Modifier.GetStackCount(NPC.GetModifier(me, "modifier_nevermore_necromastery")) > max_souls then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "hoodwink_scurry" then
                                            if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < NPC.GetAttackRange(target) + 100 and NPC.GetTimeToFace(target, me) < 0.03 and NPC.IsAttacking(target) then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.6
                                            end
                                        elseif Ability.GetName(spell) == "storm_spirit_static_remnant" and not Ability.IsStolen(spell) then
                                            if not NPC.HasModifier(me, "modifier_storm_spirit_overload") then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)], ability.sleeptime["storm_spirit_electric_vortex"], ability.sleeptime["storm_spirit_ball_lightning"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35, GameRules.GetGameTime() + 0.35, GameRules.GetGameTime() + 0.35
                                            end
                                        elseif Ability.GetName(spell) == "storm_spirit_overload" then
                                            for _, unit in ipairs(Entity.GetUnitsInRadius(target, 500, 2, true)) do
                                                if unit and NPC.IsHero(unit) and unit ~= target then
                                                    Ability.CastNoTarget(spell)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                        elseif Ability.GetName(spell) == "weaver_shukuchi" then
                                            if not NPC.HasModifier(me, "modifier_weaver_shukuchi") and (NPC.GetTimeToFace(target, me) < 0.03 and NPC.IsAttacking(target) or Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > NPC.GetAttackRange(me) + 110) then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime["weaver_geminate_attack"], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "morphling_morph_replicate" then
                                            if cast_replicate then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "primal_beast_uproar" then
                                            if not NPC.HasModifier(me, "modifier_primal_beast_onslaught_windup") and not NPC.HasModifier(me, "modifier_primal_beast_trample") and NPC.GetModifier(me, "modifier_primal_beast_uproar") and Modifier.GetStackCount(NPC.GetModifier(me, "modifier_primal_beast_uproar")) == 5 then
                                                Ability.CastNoTarget(spell)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "tinker_keen_teleport" then
                                        elseif Ability.GetName(spell) == "phoenix_icarus_dive_stop" then
                                        elseif Ability.GetName(spell) == "hoodwink_sharpshooter_release" then
                                        elseif Ability.GetName(spell) == "spectre_haunt" and not Ability.IsStolen(spell) then
                                        elseif not Ability.IsStolen(spell) and 
                                            (Ability.GetName(spell) == "mars_bulwark" or 
                                            Ability.GetName(spell) == "chen_hand_of_god" or 
                                            Ability.GetName(spell) == "enchantress_natures_attendants" or 
                                            Ability.GetName(spell) == "omniknight_guardian_angel" or 
                                            Ability.GetName(spell) == "nyx_assassin_vendetta" or
                                            Ability.GetName(spell) == "phantom_assassin_blur" or 
                                            Ability.GetName(spell) == "monkey_king_mischief" or 
                                            Ability.GetName(spell) == "puck_phase_shift" or 
                                            Ability.GetName(spell) == "life_stealer_rage" or 
                                            Ability.GetName(spell) == "nyx_assassin_spiked_carapace" or 
                                            Ability.GetName(spell) == "antimage_counterspell" or 
                                            Ability.GetName(spell) == "chaos_knight_phantasm" or 
                                            Ability.GetName(spell) == "phoenix_supernova" or 
                                            Ability.GetName(spell) == "windrunner_windrun" or 
                                            Ability.GetName(spell) == "silencer_global_silence" or 
                                            Ability.GetName(spell) == "weaver_time_lapse" or 
                                            Ability.GetName(spell) == "slark_shadow_dance" or 
                                            Ability.GetName(spell) == "brewmaster_primal_split" or 
                                            Ability.GetName(spell) == "naga_siren_song_of_the_siren" or 
                                            Ability.GetName(spell) == "visage_summon_familiars" or 
                                            Ability.GetName(spell) == "mirana_invis" or 
                                            Ability.GetName(spell) == "troll_warlord_rampage" or 
                                            Ability.GetName(spell) == "pangolier_gyroshell" or 
                                            Ability.GetName(spell) == "juggernaut_blade_fury" or 
                                            Ability.GetName(spell) == "lone_druid_savage_roar" or 
                                            Ability.GetName(spell) == "faceless_void_time_walk_reverse") then
                                            --nah! nah! nah!
                                        else
                                            Ability.CastNoTarget(spell)
                                            if Ability.GetName(spell) == "puck_phase_shift" or Ability.GetName(spell) == "meepo_petrify" or Ability.GetName(spell) == "elder_titan_echo_stomp" then ability.channelling[me] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1 end
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        end
                                    elseif (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_AUTOCAST) ~= 0 then
                                        if (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 then
                                            if Ability.GetName(spell) == "clinkz_searing_arrows" or Ability.GetName(spell) == "drow_ranger_frost_arrows" or Ability.GetName(spell) == "kunkka_tidebringer" or Ability.GetName(spell) == "viper_poison_attack" or Ability.GetName(spell) == "enchantress_impetus" or Ability.GetName(spell) == "enchantress_impetus" or Ability.GetName(spell) == "huskar_burning_spear" or Ability.GetName(spell) == "bounty_hunter_jinada" or Ability.GetName(spell) == "jakiro_liquid_fire" or Ability.GetName(spell) == "jakiro_liquid_ice" or Ability.GetName(spell) == "doom_bringer_infernal_blade" or Ability.GetName(spell) == "ancient_apparition_chilling_touch" or Ability.GetName(spell) == "silencer_glaives_of_wisdom" or Ability.GetName(spell) == "obsidian_destroyer_arcane_orb" or Ability.GetName(spell) == "tusk_walrus_punch" then
                                                Ability.CastTarget(spell, target)
                                               elseif Ability.GetName(spell) == "weaver_geminate_attack" then
                                                if (not NPC.HasModifier(me, "modifier_weaver_shukuchi") or ability.calling[NPC.GetUnitName(target)] == "damaged" and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > NPC.GetAttackRange(me) - 90) then
                                                    Ability.CastTarget(spell, target)
                                                    ability.calling[NPC.GetUnitName(target)], ability.orbwalking[me], ability.sleeptime[Ability.GetName(spell)] = nil, GameRules.GetGameTime(), GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + NPC.GetAttackTime(me)
                                                end
                                            elseif Ability.GetName(spell) == "marci_companion_run" then
                                                if NPC.GetAbility(me, "special_bonus_unique_marci_lunge_range") and Ability.GetLevel(NPC.GetAbility(me, "special_bonus_unique_marci_lunge_range")) > 0 then AbilityCastRange, landing_radius = 1100, 1000 else AbilityCastRange, landing_radius =  850, 750 end
                                                for _, unit in ipairs(Entity.GetUnitsInRadius(me, distance, 2)) do
                                                    if unit and unit ~= me and (NPC.IsCreep(unit) or NPC.IsHero(unit)) and Entity.GetAbsOrigin(unit):Distance(Entity.GetAbsOrigin(me)):Length2D() < AbilityCastRange and Entity.GetAbsOrigin(unit):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() > 350 and Entity.GetAbsOrigin(unit):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() < landing_radius then
                                                        Ability.CastTarget(spell, unit)
                                                        Player.PrepareUnitOrders(Players.GetLocal(), 30, nil, ability.skillshotXYZ(me, target, 950), spell, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, me)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35
                                                    end
                                                end
                                            elseif Ability.GetName(spell) == "hoodwink_acorn_shot" and not Ability.IsStolen(spell) then
                                                if not NPC.HasModifier(target, "modifier_antimage_counterspell") and not NPC.HasModifier(target, "modifier_item_lotus_orb_active") then
                                                    local acorn = nil
                                                    for _, unit in ipairs(Entity.GetUnitsInRadius(me, distance + 525, 1, true)) do
                                                        if unit and (NPC.IsCreep(unit) or NPC.IsHero(unit)) and unit ~= target then
                                                            if not NPC.IsRunning(unit) then unit_pos = Entity.GetAbsOrigin(unit) else unit_pos = Entity.GetAbsOrigin(unit) + Entity.GetRotation(unit):GetForward():Normalized():Scaled(NPC.GetMoveSpeed(unit)) end
                                                            if ability.skillshotXYZ(me, target, 2000):Distance(unit_pos):Length2D() < 330 then
                                                                if NPC.IsLinkensProtected(target) then
                                                                    Ability.CastTarget(spell, unit)
                                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35
                                                                else
                                                                    Ability.CastTarget(spell, target)
                                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35
                                                                end
                                                            end
                                                            acorn = unit
                                                        end
                                                    end
                                                end
                                            end  
                                        end
                                    elseif (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 then
                                        if (Ability.GetTargetTeam(spell) & Enum.TargetTeam.DOTA_UNIT_TARGET_TEAM_FRIENDLY) ~= 0 then
                                            if Ability.GetName(spell) == "snapfire_firesnap_cookie" then
                                                for _, unit in ipairs(Entity.GetUnitsInRadius(me, distance, 2, true)) do
                                                    if unit and (NPC.IsCreep(unit) or NPC.IsHero(unit)) and ability.skillshotXYZ(me, target, 950):Distance(Entity.GetAbsOrigin(unit) + Entity.GetRotation(unit):GetForward():Normalized():Scaled(425)):Length2D() < 150 then
                                                        Ability.CastTarget(spell, unit)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                end
                                            elseif Ability.GetName(spell) == "dark_seer_ion_shell" then
                                                for _, unit in ipairs(Entity.GetUnitsInRadius(target, distance, 0, true)) do
                                                    if unit and (NPC.IsCreep(unit) or NPC.IsHero(unit)) and Entity.GetAbsOrigin(unit):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() < 275 and not NPC.HasModifier(unit, "modifier_dark_seer_ion_shell") then
                                                        Ability.CastTarget(spell, unit)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Ability.GetCastPoint(spell)
                                                    end
                                                end
                                            elseif Ability.GetName(spell) == "marci_guardian" then
                                                if NPC.HasModifier(me, "modifier_marci_unleash") then
                                                    Ability.CastTarget(spell, me)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "obsidian_destroyer_astral_imprisonment" then
                                                local unit_table = {}
                                                for n, unit in ipairs(Entity.GetHeroesInRadius(me, distance, 0)) do
                                                    if unit and not NPC.HasModifier(unit, "modifier_obsidian_destroyer_astral_imprisonment_prison") then
                                                        table.insert(unit_table, unit)
                                                        if #unit_table > 0 then
                                                            table.sort(unit_table, function (a, b) return NPC.GetMaxMana(a) > NPC.GetMaxMana(b) end)
                                                        end
                                                    end
                                                end
                                                if unit_table[1] then
                                                    Ability.CastTarget(spell, unit_table[1])
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "lycan_wolf_bite" then
                                                local unit_table = {}
                                                for n, unit in ipairs(Entity.GetHeroesInRadius(me, 900, 2)) do
                                                    if unit then
                                                        table.insert(unit_table, unit)
                                                        if #unit_table > 0 then
                                                            table.sort(unit_table, function (a, b) return NPC.GetTrueDamage(a) > NPC.GetTrueDamage(b) end)
                                                        end
                                                    end
                                                end
                                                if unit_table[1] then
                                                    Ability.CastTarget(spell, unit_table[1])
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "luna_eclipse" then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 1000))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            elseif Ability.GetName(spell) == "marci_grapple" then
                                                Ability.CastTarget(spell, target)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            elseif Ability.GetName(spell) == "marci_companion_run" then
                                                if NPC.GetAbility(me, "special_bonus_unique_marci_lunge_range") and Ability.GetLevel(NPC.GetAbility(me, "special_bonus_unique_marci_lunge_range")) > 0 then AbilityCastRange, landing_radius = 1100, 1000 else AbilityCastRange, landing_radius =  850, 750 end
                                                for _, unit in ipairs(Entity.GetUnitsInRadius(me, distance, 2)) do
                                                    if unit and unit ~= me and (NPC.IsCreep(unit) or NPC.IsHero(unit)) and Entity.GetAbsOrigin(unit):Distance(Entity.GetAbsOrigin(me)):Length2D() < AbilityCastRange and Entity.GetAbsOrigin(unit):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() > 350 and Entity.GetAbsOrigin(unit):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() < landing_radius then
                                                        Ability.CastTarget(spell, unit)
                                                        Player.PrepareUnitOrders(Players.GetLocal(), 30, nil, ability.skillshotXYZ(me, target, 950), spell, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, me)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35
                                                    end
                                                end
                                            elseif Ability.GetName(spell) == "hoodwink_decoy" then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 950))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            elseif Ability.GetName(spell) == "hoodwink_hunters_boomerang" and not Ability.IsStolen(spell) then
                                                Ability.CastPosition(spell, Entity.GetAbsOrigin(me) + ((ability.skillshotXYZ(me, target, 2000) - Entity.GetAbsOrigin(me)):Normalized():Scaled(1000)))
                                                ability.sleeptime["hoodwink_bushwhack"], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 700, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            elseif Ability.GetName(spell) == "pugna_life_drain" or Ability.GetName(spell) == "furion_sprout" then
                                                Ability.CastTarget(spell, target)
                                            elseif Ability.GetName(spell) == "kunkka_x_marks_the_spot" then
                                                if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > NPC.GetAttackRange(me) + 100 then
                                                    Ability.CastTarget(spell, target)
                                                    ability.sleeptime["kunkka_return"], ability.cast_pos[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1.5, Entity.GetAbsOrigin(target)
                                                end
                                            elseif Ability.GetName(spell) == "magnataur_empower" then
                                                if not NPC.HasModifier(me, "modifier_magnataur_empower") then
                                                    Ability.CastTarget(spell, me)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "meepo_poof" then
                                                if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < 375 then ability.cast_pos[Ability.GetName(spell)] = Entity.GetAbsOrigin(target) end
                                                if ability.cast_pos[Ability.GetName(spell)] then
                                                    Ability.CastPosition(spell, ability.cast_pos[Ability.GetName(spell)])
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "earth_spirit_boulder_smash" or Ability.GetName(spell) == "earth_spirit_geomagnetic_grip" then
                                                for _, stone in ipairs(Entity.GetUnitsInRadius(me, distance, 2)) do
                                                    if stone and NPC.GetUnitName(stone) == "npc_dota_earth_spirit_stone" then
                                                        if Ability.GetName(spell) == "earth_spirit_boulder_smash" and Entity.GetAbsOrigin(stone):Distance(Entity.GetAbsOrigin(me)):Length2D() < 200 then
                                                            Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 1000))
                                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                        elseif Ability.GetName(spell) == "earth_spirit_geomagnetic_grip" and (Entity.GetAbsOrigin(stone):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) < 0 and (Entity.GetAbsOrigin(stone):GetY() - ability.skillshotXYZ(me, target, 2000):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 2000):GetY()) < 0 and math.abs((Entity.GetAbsOrigin(stone):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) - (Entity.GetAbsOrigin(stone):GetY() - ability.skillshotXYZ(me, target, 2000):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 2000):GetY())) < 0.3 or NPC.HasModifier(target, "modifier_earth_spirit_boulder_smash_debuff") then
                                                            Ability.CastPosition(spell, Entity.GetAbsOrigin(stone))
                                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                        end
                                                    end
                                                end
                                            elseif Ability.GetName(spell) == "lich_frost_shield" or Ability.GetName(spell) == "grimstroke_spirit_walk" or Ability.GetName(spell) == "wisp_tether" or Ability.GetName(spell) == "techies_reactive_tazer" then
                                                local unit_table = {}
                                                for _, unit in ipairs(Entity.GetUnitsInRadius(target, distance, 0, true)) do
                                                    if unit and (NPC.GetUnitName(unit) == "npc_dota_grimstroke_ink_creature" or NPC.IsHero(unit)) then
                                                        table.insert(unit_table, unit)
                                                        if #unit_table > 0 then
                                                            table.sort(unit_table, function (a, b) return Entity.GetAbsOrigin(a):Distance(Entity.GetAbsOrigin(b)):Length2D() < Entity.GetAbsOrigin(b):Distance(Entity.GetAbsOrigin(a)):Length2D() end)
                                                        end
                                                    end
                                                end
                                                if unit_table[1] and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(unit_table[1])):Length2D() < Ability.GetCastRange(spell) then
                                                    Ability.CastTarget(spell, unit_table[1])
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "tinker_defense_matrix" then
                                                for _, unit in ipairs(Entity.GetHeroesInRadius(target, distance, 1)) do
                                                    if unit and NPC.IsHero(unit) and Entity.GetAbsOrigin(unit):Distance(Entity.GetAbsOrigin(target)):Length2D() < NPC.GetAttackRange(target) + 150 and NPC.GetTimeToFace(target, unit) < 0.03 and not NPC.HasModifier(unit, "modifier_tinker_defense_matrix") then
                                                        Ability.CastTarget(spell, unit)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                end
                                            elseif Ability.GetName(spell) == "oracle_fortunes_end" then
                                                if not NPC.HasModifier(target, "modifier_oracle_fates_edict") then
                                                    Ability.CastTarget(spell, target)
                                                    ability.channelling[me] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "oracle_fates_edict" then
                                                local unit_table = {}
                                                for n, unit in ipairs(Entity.GetHeroesInRadius(me, distance, 0)) do
                                                    if unit then
                                                        table.insert(unit_table, unit)
                                                        if #unit_table > 0 then
                                                            table.sort(unit_table, function (a, b) return NPC.GetTrueDamage(a) > NPC.GetTrueDamage(b) end)
                                                        end
                                                    end
                                                end
                                                if unit_table[1] and NPC.IsAttacking(unit_table[1]) then
                                                    Ability.CastTarget(spell, unit_table[1])
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "dazzle_shallow_grave" or Ability.GetName(spell) == "dazzle_shadow_wave" or Ability.GetName(spell) == "dark_seer_surge" then
                                                for _, unit in ipairs(Entity.GetUnitsInRadius(target, distance, 0, true)) do
                                                    if unit and (NPC.IsHero(unit) or NPC.IsCreep(unit)) then
                                                        if Ability.GetName(spell) == "dazzle_shadow_wave" and Entity.GetAbsOrigin(unit):Distance(Entity.GetAbsOrigin(target)):Length2D() < 185 then
                                                            Ability.CastTarget(spell, unit)
                                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                        end
                                                        if (Ability.GetName(spell) == "dazzle_shallow_grave" or Ability.GetName(spell) == "dark_seer_surge") and NPC.IsHero(unit) and not NPC.HasModifier(unit, "modifier_illusion") and Entity.GetHealth(unit) / Entity.GetMaxHealth(unit) < 0.2 and Entity.GetAbsOrigin(unit):Distance(Entity.GetAbsOrigin(target)):Length2D() < NPC.GetAttackRange(target) + 150 and NPC.GetTimeToFace(target, unit) < 0.03 then
                                                            Ability.CastTarget(spell, unit)
                                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                        end
                                                    end
                                                end
                                            elseif Ability.GetName(spell) == "dazzle_good_juju" then
                                                local cast_juju = true
                                                for d = 0, 5 do
                                                    local item = NPC.GetItemByIndex(me, d)
                                                    if item and ((Ability.GetBehavior(item) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 or (Ability.GetBehavior(item) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT) ~= 0) and (Ability.GetTargetTeam(item) & Enum.TargetTeam.DOTA_UNIT_TARGET_TEAM_FRIENDLY) == 0 and Ability.IsReady(item) then
                                                        cast_juju = false
                                                    end
                                                end
                                                if cast_juju then
                                                    Ability.CastTarget(spell, me)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "shadow_demon_disruption" then
                                                local unit_table = {}
                                                for n, unit in ipairs(Entity.GetHeroesInRadius(me, distance, 0)) do
                                                    if unit and not NPC.HasModifier(unit, "modifier_shadow_demon_disruption") and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(unit)):Length2D() < NPC.GetAttackRange(unit) + 100 and NPC.GetTimeToFace(unit, me) < 0.03 then
                                                        table.insert(unit_table, unit)
                                                        if #unit_table > 0 then
                                                            table.sort(unit_table, function (a, b) return NPC.GetTrueDamage(a) > NPC.GetTrueDamage(b) end)
                                                        end
                                                    end
                                                end
                                                if unit_table[1] then
                                                    Ability.CastTarget(spell, unit_table[1])
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "necrolyte_death_seeker" then
                                                Ability.CastTarget(spell, target)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            elseif Ability.GetName(spell) == "treant_living_armor" or Ability.GetName(spell) == "shadow_demon_demonic_cleanse" or Ability.GetName(spell) == "omniknight_purification" then
                                                local unit_table = {}
                                                for _, unit in ipairs(Entity.GetUnitsInRadius(target, Ability.GetCastRange(spell), 1)) do
                                                    if unit and NPC.IsHero(unit) and not NPC.HasModifier(unit, "modifier_shadow_demon_purge_slow") then
                                                        table.insert(unit_table, unit)
                                                        if #unit_table > 0 then
                                                            table.sort(unit_table, function (a, b) return Entity.GetHealth(a) < Entity.GetHealth(b) end)
                                                        end
                                                    end
                                                end
                                                if unit_table[1] and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(unit_table[1])):Length2D() < Ability.GetCastRange(spell) and Entity.GetHealth(unit_table[1]) / Entity.GetMaxHealth(unit_table[1]) < 0.6 then
                                                    Ability.CastTarget(spell, unit_table[1])
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1
                                                end
                                            elseif not Ability.IsStolen(spell) and Ability.GetName(spell) == "oracle_purifying_flames" then
                                                if (Entity.GetHealth(target) + NPC.GetHealthRegen(target) < (Ability.GetLevelSpecialValueFor(spell, "damage") * NPC.GetMagicalArmorDamageMultiplier(target)) or Ability.GetLevel(spell) > 3) and not NPC.HasModifier(target, "modifier_oracle_fates_edict") then
                                                    Ability.CastTarget(spell, target)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "riki_tricks_of_the_trade" then
                                                local unit_table = {}
                                                for _, unit in ipairs(Entity.GetUnitsInRadius(target, distance, 0, true)) do
                                                    if unit and NPC.IsHero(unit) then
                                                        table.insert(unit_table, unit)
                                                        if #unit_table > 0 then
                                                            table.sort(unit_table, function (a, b) return Entity.GetAbsOrigin(a):Distance(Entity.GetAbsOrigin(b)):Length2D() < Entity.GetAbsOrigin(b):Distance(Entity.GetAbsOrigin(a)):Length2D() end)
                                                        end
                                                    end
                                                end
                                                if unit_table[1] and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(unit_table[1])):Length2D() < distance then
                                                    Ability.CastTarget(spell, unit_table[1])
                                                    ability.channelling[me], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 4, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "legion_commander_press_the_attack" then
                                                for name, handle in pairs(ability.handle) do
                                                    if handle.spell and Entity.IsAbility(handle.spell) and (string.find(Ability.GetName(handle.spell), "_blink") and Ability.IsReady(handle.spell) or Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < NPC.GetAttackRange(me) + 100) then
                                                        Ability.CastTarget(spell, me)
                                                        ability.sleeptime[Ability.GetName(spell)], ability.sleeptime["legion_commander_duel"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                end  
                                            elseif not Ability.IsStolen(spell) and 
                                                (Ability.GetName(spell) == "oracle_false_promise" or 
                                                Ability.GetName(spell) == "weaver_time_lapse" or 
                                                Ability.GetName(spell) == "winter_wyvern_cold_embrace" or 
                                                Ability.GetName(spell) == "phoenix_supernova") then
                                                -- nahh
                                            else
                                                Ability.CastTarget(spell, me)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif (Ability.GetTargetTeam(spell) & Enum.TargetTeam.DOTA_UNIT_TARGET_TEAM_FRIENDLY) == 0 then
                                            if NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed") then
                                                if Ability.GetName(spell) == "bristleback_viscous_nasal_goo" or Ability.GetName(spell) == "storm_spirit_electric_vortex" or Ability.GetName(spell) == "night_stalker_void" then
                                                    Ability.CastNoTarget(spell)
                                                    ability.sleeptime[Ability.GetName(spell)], ability.sleeptime["storm_spirit_static_remnant"], ability.sleeptime["storm_spirit_ball_lightning"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35, GameRules.GetGameTime() + 0.35, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35
                                                end
                                                if Ability.GetName(spell) == "silencer_last_word" then
                                                    Ability.CastPosition(spell, ability.skillshotAOE(me, target, 650))
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                            if Ability.GetName(spell) == "clinkz_death_pact" then
                                                local creeps = {}
                                                for i, v in ipairs(Entity.GetUnitsInRadius(me, distance, 2)) do
                                                    if v and Entity.IsAlive(v) and (NPC.IsCreep(v) or NPC.IsNeutral(v)) then
                                                        table.insert(creeps, v)
                                                        if #creeps > 0 then
                                                            table.sort(creeps, function (a, b) return Entity.GetHealth(a) > Entity.GetHealth(b) end)
                                                        end
                                                    end
                                                end
                                                if creeps[1] then
                                                    Ability.CastTarget(spell, creeps[1])
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            elseif Ability.GetName(spell) == "snapfire_gobble_up" then
                                                for _, unit in ipairs(Entity.GetUnitsInRadius(me, distance, 2, true)) do
                                                    if unit and (NPC.IsCreep(unit) or NPC.IsHero(unit)) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(unit)):Length2D() < 150 then
                                                        Ability.CastTarget(spell, unit)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                end
                                            end
                                            if not NPC.HasModifier(target, "modifier_antimage_counterspell") and not NPC.HasModifier(target, "modifier_item_lotus_orb_active") then
                                                if Ability.GetName(spell) == "windrunner_shackleshot" then
                                                    for _, tree in ipairs(Trees.InRadius(Entity.GetAbsOrigin(me), Ability.GetCastRange(spell) + 575, true)) do
                                                        if tree and ability.skillshotXYZ(me, target, 1500):Distance(Entity.GetAbsOrigin(tree)):Length2D() < 575 then
                                                            if (Entity.GetAbsOrigin(tree):GetX() - ability.skillshotXYZ(me, target, 1500):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 1500):GetX()) < 0 and (Entity.GetAbsOrigin(tree):GetY() - ability.skillshotXYZ(me, target, 1500):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 1500):GetY()) < 0 and math.abs((Entity.GetAbsOrigin(tree):GetX() - ability.skillshotXYZ(me, target, 1500):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 1500):GetX()) - (Entity.GetAbsOrigin(tree):GetY() - ability.skillshotXYZ(me, target, 1500):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 1500):GetY())) < 0.6 then
                                                                Ability.CastTarget(spell, target)
                                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                            end
                                                        end
                                                    end
                                                    for _, enemy in ipairs(Entity.GetUnitsInRadius(me, Ability.GetCastRange(spell) + 575, 0, true)) do
                                                        if enemy and enemy ~= target and (NPC.IsCreep(enemy) or NPC.IsHero(enemy)) and Entity.IsAlive(enemy) and Entity.GetAbsOrigin(enemy):Distance(ability.skillshotXYZ(me, target, 1500)):Length2D() < 575 then
                                                            if ability.skillshotXYZ(me, target, 1500) and ability.skillshotXYZ(target, enemy, 1500) and (ability.skillshotXYZ(target, enemy, 1500):GetX() - ability.skillshotXYZ(me, target, 1500):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 1500):GetX()) < 0 and (ability.skillshotXYZ(target, enemy, 1500):GetY() - ability.skillshotXYZ(me, target, 1500):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 1500):GetY()) < 0 and math.abs((ability.skillshotXYZ(target, enemy, 1500):GetX() - ability.skillshotXYZ(me, target, 1500):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 1500):GetX()) - (ability.skillshotXYZ(target, enemy, 1500):GetY() - ability.skillshotXYZ(me, target, 1500):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 1500):GetY())) < 0.6 then
                                                                Ability.CastTarget(spell, target)
                                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                            end
                                                            if ability.skillshotXYZ(target, enemy, 1500) and (ability.skillshotXYZ(me, target, 1500):GetX() - ability.skillshotXYZ(target, enemy, 1500):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(target, enemy, 1500):GetX()) < 0 and (ability.skillshotXYZ(me, target, 1500):GetY() - ability.skillshotXYZ(target, enemy, 1500):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(target, enemy, 1500):GetY()) < 0 and math.abs((ability.skillshotXYZ(me, target, 1500):GetX() - ability.skillshotXYZ(target, enemy, 1500):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(target, enemy, 1500):GetX()) - (ability.skillshotXYZ(me, target, 1500):GetY() - ability.skillshotXYZ(target, enemy, 1500):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(target, enemy, 1500):GetY())) < 0.6 then
                                                                Ability.CastTarget(spell, enemy)
                                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                            end
                                                        end
                                                    end
                                                elseif Ability.GetName(spell) == "terrorblade_sunder" then
                                                    if Entity.GetHealth(me) / Entity.GetMaxHealth(me) < 0.2 then
                                                        for _, enemy in ipairs(Entity.GetHeroesInRadius(me, distance, 0)) do
                                                            if enemy and Entity.IsAlive(enemy) then
                                                                if Entity.GetHealth(me) < Entity.GetHealth(enemy) then
                                                                    Ability.CastTarget(spell, enemy)
                                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                                end
                                                            end
                                                        end
                                                    end
                                                elseif Ability.GetName(spell) == "bounty_hunter_track" then
                                                    for _, enemy in ipairs(Entity.GetHeroesInRadius(me, 1000, 0)) do
                                                        if enemy and Entity.IsAlive(enemy) and not NPC.HasModifier(enemy, "modifier_bounty_hunter_track") then
                                                            Ability.CastTarget(spell, enemy)
                                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                        end
                                                    end
                                                elseif Ability.GetName(spell) == "alchemist_unstable_concoction_throw" then
                                                    Ability.CastTarget(spell, target)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                elseif Ability.GetName(spell) == "bloodseeker_rupture" then
                                                    if not NPC.HasModifier(target, "modifier_bloodseeker_rupture") then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "antimage_mana_void" then
                                                    if Entity.GetHealth(target) + NPC.GetHealthRegen(target) < (NPC.GetMaxMana(target) - NPC.GetMana(target) + NPC.GetManaRegen(target)) * (Ability.GetLevelSpecialValueFor(spell, "mana_void_damage_per_mana") * NPC.GetMagicalArmorDamageMultiplier(target)) then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "necrolyte_reapers_scythe" then
                                                    if Entity.GetHealth(target) + NPC.GetHealthRegen(target) < (Entity.GetMaxHealth(target) - Entity.GetHealth(target) + NPC.GetHealthRegen(target)) * (1 + Ability.GetLevelSpecialValueFor(spell, "damage_per_health") * NPC.GetMagicalArmorDamageMultiplier(target)) then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "axe_culling_blade" then
                                                    if NPC.GetAbility(me, "special_bonus_unique_axe_5") and Ability.GetLevel(NPC.GetAbility(me, "special_bonus_unique_axe_5")) > 0 then damage = {400, 500, 600} else damage = {250, 350, 450} end
                                                    if Entity.GetHealth(target) + NPC.GetHealthRegen(target) < damage[Ability.GetLevel(spell)] then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "shadow_demon_demonic_purge" then
                                                    if not NPC.HasModifier(target, "modifier_shadow_demon_purge_slow") then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "rubick_telekinesis" then
                                                    if ability.npc_stunned(spell, target) then
                                                        if NPC.HasModifier(me, "modifier_item_aghanims_shard") then
                                                            for i, v in ipairs(Entity.GetHeroesInRadius(me, Ability.GetCastRange(spell), 2)) do
                                                                if v and Entity.IsAlive(v) and NPC.IsHero(v) and Entity.GetAbsOrigin(v):Distance(Entity.GetAbsOrigin(target)):Length2D() > NPC.GetAttackRange(v) + 100 and NPC.FindFacingNPC(v, nil, 0, 984, 110) == target then
                                                                    Ability.CastTarget(spell, v)
                                                                    ability.sleeptime[Ability.GetName(spell)], ability.sleeptime["item_sheepstick"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.39, GameRules.GetGameTime() + 1
                                                                    ability.throw_allies = true
                                                                end
                                                            end
                                                        end
                                                        if not ability.throw_allies then
                                                            Ability.CastTarget(spell, target)
                                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.39
                                                        end
                                                    end
                                                elseif Ability.GetName(spell) == "brewmaster_storm_cyclone" then
                                                    for i, v in ipairs(Entity.GetHeroesInRadius(me, distance, 0)) do
                                                        if v and v ~= target then
                                                            Ability.CastTarget(spell, v)
                                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                        end
                                                    end
                                                elseif Ability.GetName(spell) == "broodmother_spawn_spiderlings" then
                                                    if NPC.GetAbility(me, "special_bonus_unique_broodmother_3") and Ability.GetLevel(NPC.GetAbility(me, "special_bonus_unique_broodmother_3")) > 0 then bonus = 80 else bonus = 0 end
                                                    for i, v in ipairs(Entity.GetUnitsInRadius(me, distance, 2)) do
                                                        if v and Entity.IsAlive(v) and (NPC.IsCreep(v) or NPC.IsHero(v)) and Entity.GetHealth(v) + NPC.GetHealthRegen(v) < Ability.GetLevelSpecialValueFor(spell, "damage") + bonus then
                                                            Ability.CastTarget(spell, v)
                                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                        end
                                                    end
                                                elseif Ability.GetName(spell) == "axe_battle_hunger" then
                                                    if not NPC.HasModifier(target, "modifier_axe_battle_hunger") then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "nevermore_necromastery" then
                                                    if NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed") then max_souls = 23 else max_souls = 18 end
                                                    if NPC.GetModifier(me, "modifier_nevermore_necromastery") and Modifier.GetStackCount(NPC.GetModifier(me, "modifier_nevermore_necromastery")) > max_souls then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "pugna_decrepify" then
                                                    Ability.CastTarget(spell, target)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                elseif Ability.GetName(spell) == "grimstroke_soul_chain" then
                                                    if #Heroes.InRadius(Entity.GetAbsOrigin(target), 600, Entity.GetTeamNum(me), 0) > 1 then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                    --[[for _, tree in ipairs(Trees.InRadius(Entity.GetAbsOrigin(target), 300)) do if tree then acorn = tree end end
                                                    if not acorn and ability1 and Ability.GetName(ability1) == "hoodwink_bushwhack" and Ability.IsReady(ability1) then
                                                        if not NPC.IsRunning(target) then between = 90 else between = NPC.GetMoveSpeed(target) end
                                                        Ability.CastPosition(spell, Entity.GetAbsOrigin(target) + Entity.GetRotation(target):GetForward():Normalized():Scaled(between))
                                                        ability.cast_pos["hoodwink_acorn_shot"] = Entity.GetAbsOrigin(target) + Entity.GetRotation(target):GetForward():Normalized():Scaled(between)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1
                                                    end]]
                                                elseif Ability.GetName(spell) == "vengefulspirit_nether_swap" then
                                                    for _, unit in ipairs(Entity.GetUnitsInRadius(me, distance, 2)) do
                                                        if unit and (Entity.IsHero(unit) or NPC.IsTower(unit)) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(unit)):Length2D() < 600 and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > 600 and Entity.GetAbsOrigin(unit):Distance(Entity.GetAbsOrigin(target)):Length2D() > 600 then
                                                            Ability.CastTarget(spell, target)
                                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                        end
                                                    end
                                                elseif Ability.GetName(spell) == "obsidian_destroyer_arcane_orb" or Ability.GetName(spell) == "silencer_glaives_of_wisdom" then
                                                    Ability.CastTarget(spell, target)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Ability.GetCastPoint(spell)
                                                elseif Ability.GetName(spell) == "tiny_toss_tree" then
                                                    if NPC.GetModifier(me, "modifier_tiny_tree_grab") and Modifier.GetStackCount(NPC.GetModifier(me, "modifier_tiny_tree_grab")) == 1 and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > NPC.GetAttackRange(target) + 300 then
                                                        Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 1000))
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "sniper_assassinate" then
                                                    if Ability.IsStolen(spell) or (NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed")) and Entity.GetAbsOrigin(target):Distance(Entity.GetAbsOrigin(me)):Length2D() > NPC.GetAttackRange(target) + 300 then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif not Ability.IsStolen(spell) and Ability.GetName(spell) == "lion_finger_of_death" then
                                                    if Entity.GetHealth(target) + NPC.GetHealthRegen(target) < Ability.GetLevelSpecialValueFor(spell, "damage") * NPC.GetMagicalArmorDamageMultiplier(target) then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "windrunner_focusfire" then
                                                    if Ability.IsStolen(spell) or NPC.IsStunned(target) or NPC.IsRooted(target) or NPC.HasModifier(target, "modifier_windrunner_gale_force") then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "earthshaker_enchant_totem" then
                                                    Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 300))
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                elseif Ability.GetName(spell) == "monkey_king_tree_dance" then
                                                    local tree_table = {}
                                                    for _, tree in ipairs(Trees.InRadius(ability.skillshotXYZ(me, target, 900), distance, true)) do
                                                        if tree and Entity.GetAbsOrigin(target):Distance(Entity.GetAbsOrigin(tree)):Length2D() > 350 then
                                                            table.insert(tree_table, tree)
                                                            if #tree_table > 0 then
                                                                table.sort(tree_table, function (a, b) return Entity.GetAbsOrigin(a):Distance(Entity.GetAbsOrigin(b)):Length2D() > Entity.GetAbsOrigin(b):Distance(Entity.GetAbsOrigin(a)):Length2D() end)
                                                            end
                                                        end
                                                    end
                                                    if ability.handle["monkey_king_primal_spring"] and Ability.IsReady(ability.handle["monkey_king_primal_spring"].spell) and tree_table[1] and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(tree_table[1])):Length2D() < distance and Entity.GetAbsOrigin(target):Distance(Entity.GetAbsOrigin(me)):Length2D() > NPC.GetAttackRange(me) + 300 then
                                                        Ability.CastTarget(spell, tree_table[1])
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(tree_table[1])):Length2D() / 600
                                                    end 
                                                elseif Ability.GetName(spell) == "death_prophet_spirit_siphon" then
                                                    local unit_table = {}
                                                    for n, unit in ipairs(Entity.GetHeroesInRadius(me, distance, 0)) do
                                                        if unit and NPC.IsHero(unit) then
                                                            if not NPC.HasModifier(unit, "modifier_death_prophet_spirit_siphon_slow") then
                                                                table.insert(unit_table, unit)
                                                                if #unit_table > 0 then
                                                                    table.sort(unit_table, function (a, b) return Entity.GetAbsOrigin(a):Distance(Entity.GetAbsOrigin(b)):Length2D() > Entity.GetAbsOrigin(b):Distance(Entity.GetAbsOrigin(a)):Length2D() end)
                                                                end
                                                            end
                                                        end
                                                    end
                                                    if unit_table[1] then
                                                        Ability.CastTarget(spell, unit_table[1])
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "winter_wyvern_winters_curse" then
                                                    local unit_table = {}
                                                    for n, unit in ipairs(Entity.GetHeroesInRadius(me, distance * 2, 0)) do
                                                        if unit and unit ~= target then
                                                            table.insert(unit_table, unit)
                                                            if #unit_table > 0 then
                                                                table.sort(unit_table, function (a, b) return NPC.GetTrueDamage(a) > NPC.GetTrueDamage(b) end)
                                                            end
                                                        end
                                                    end
                                                    if unit_table[1] and Entity.GetAbsOrigin(target):Distance(Entity.GetAbsOrigin(unit_table[1])):Length2D() < 525 then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "winter_wyvern_splinter_blast" then
                                                    local unit_table = {}
                                                    if NPC.GetAbility(me, "special_bonus_unique_winter_wyvern_2") and Ability.GetLevel(NPC.GetAbility(me, "special_bonus_unique_winter_wyvern_2")) > 0 then search = 900 else search = 500 end 
                                                    for n, unit in ipairs(Entity.GetUnitsInRadius(target, search, 2)) do
                                                        if unit and unit ~= target and (NPC.IsCreep(unit) or NPC.IsHero(unit)) then
                                                            table.insert(unit_table, unit)
                                                            if #unit_table > 0 then
                                                                table.sort(unit_table, function (a, b) return Entity.GetAbsOrigin(a):Distance(Entity.GetAbsOrigin(b)):Length2D() > Entity.GetAbsOrigin(b):Distance(Entity.GetAbsOrigin(a)):Length2D() end)
                                                            end
                                                        end
                                                    end
                                                    if unit_table[1] and Entity.GetAbsOrigin(target):Distance(Entity.GetAbsOrigin(unit_table[1])):Length2D() < search then
                                                        Ability.CastTarget(spell, unit_table[1])
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "spirit_breaker_charge_of_darkness" then
                                                    Ability.CastTarget(spell, target)
                                                    ability.channelling[me] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                elseif Ability.GetName(spell) == "spirit_breaker_nether_strike" then
                                                    if not ability0 or ability0 and Ability.SecondsSinceLastUse(ability0) > Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 60 then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "storm_spirit_electric_vortex" and not Ability.IsStolen(spell) then
                                                    if not NPC.HasModifier(me, "modifier_storm_spirit_overload") then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)], ability.sleeptime["storm_spirit_static_remnant"], ability.sleeptime["storm_spirit_ball_lightning"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35, GameRules.GetGameTime() + 0.35, GameRules.GetGameTime() + 0.35
                                                    end
                                                elseif Ability.GetName(spell) == "invoker_sun_strike" then
                                                    Ability.CastTarget(spell, me)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                elseif Ability.GetName(spell) == "tusk_walrus_kick" then
                                                    local unit = {}
                                                    for i, v in ipairs(Entity.GetUnitsInRadius(me, distance + 1200, 2)) do
                                                        if v and not Entity.IsDormant(v) and (NPC.IsTower(v) or NPC.IsHero(v) or NPC.GetUnitName(v) == "dota_fountain") and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(v)):Length2D() > 700 then
                                                            table.insert(unit, v)
                                                            if #unit > 0 then
                                                                table.sort(unit, function (a, b) return Entity.GetAbsOrigin(a):Distance(Entity.GetAbsOrigin(b)):Length2D() > Entity.GetAbsOrigin(b):Distance(Entity.GetAbsOrigin(a)):Length2D() end)
                                                            end
                                                        end
                                                    end
                                                    if  unit[1] then
                                                        Ability.CastTarget(spell, target)
                                                        Player.PrepareUnitOrders(Players.GetLocal(), 30, nil, ability.skillshotXYZ(me, unit[1], 2000), spell, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, me)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    else
                                                        ability.sleeptime["tusk_ice_shards"] = 0
                                                    end
                                                elseif Ability.GetName(spell) == "riki_blink_strike" then
                                                    if Entity.GetAbsOrigin(target):Distance(Entity.GetAbsOrigin(me)):Length2D() > NPC.GetAttackRange(me) + 250 then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "abyssal_underlord_firestorm" then
                                                    Ability.CastPosition(spell, ability.skillshotAOE(me, target,  Ability.GetLevelSpecialValueFor(spell, "radius")))
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                elseif Ability.GetName(spell) == "juggernaut_omni_slash" and not Ability.IsStolen(spell) then
                                                    local duration, bonus_damage = {3, 3.25, 3.5}, {30, 40, 50}
                                                    if not NPC.HasModifier(me, "modifier_juggernaut_omnislash") and Entity.GetHealth(target) + NPC.GetHealthRegen(target) < (NPC.GetTrueDamage(me) + bonus_damage[Ability.GetLevel(spell)]) * NPC.GetAttacksPerSecond(me) * 2 * duration[Ability.GetLevel(spell)] * NPC.GetArmorDamageMultiplier(target) then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime["juggernaut_swift_slash"], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + duration[Ability.GetLevel(spell)], GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "tinker_warp_grenade" then
                                                    if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < NPC.GetAttackRange(target) + 75 and NPC.GetTimeToFace(target, me) < 0.03 and NPC.IsAttacking(target) then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "morphling_adaptive_strike_agi" then
                                                    Ability.CastTarget(spell, target)
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                elseif Ability.GetName(spell) == "visage_soul_assumption" then
                                                    if NPC.GetModifier(me, "modifier_visage_soul_assumption") and Modifier.GetStackCount(NPC.GetModifier(me, "modifier_visage_soul_assumption")) == 6 then
                                                        Ability.CastTarget(spell, target)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                elseif Ability.GetName(spell) == "enigma_malefice" then     
                                                    for name, handle in pairs(ability.handle) do
                                                        if handle.spell and Entity.IsAbility(handle.spell) and Ability.GetName(handle.spell) == "enigma_black_hole" and (Ability.GetCooldown(handle.spell) > 0 or Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > handle.distance) then
                                                            Ability.CastTarget(spell, target)
                                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                        end
                                                    end                                      
                                                elseif Ability.GetName(spell) == "morphling_adaptive_strike_str" then
                                                elseif Ability.GetName(spell) == "morphling_replicate" then
                                                elseif Ability.GetName(spell) == "life_stealer_infest" then
                                                elseif Ability.GetName(spell) == "lion_mana_drain" then
                                                elseif Ability.GetName(spell) == "disruptor_glimpse" then
                                                else
                                                    Ability.CastTarget(spell, target)
                                                    if Ability.GetName(spell) == "bane_fiends_grip" or Ability.GetName(spell) == "lion_mana_drain" or Ability.GetName(spell) == "pudge_dismember" or Ability.GetName(spell) == "shadow_shaman_shackles" or Ability.GetName(spell) == "lich_sinister_gaze" or Ability.GetName(spell) == "pugna_life_drain" or Ability.GetName(spell) == "primal_beast_pulverize" then ability.channelling[me] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1 end
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                        end
                                    elseif (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_TOGGLE) ~= 0 then
                                        for i, v in pairs(Entity.GetUnitsInRadius(me, distance, 2)) do
                                            if v and Entity.IsAlive(v) and NPC.GetUnitName(v) == "npc_dota_wisp_spirit" and Entity.GetAbsOrigin(v):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() < 1200 then
                                                if Ability.GetName(spell) == "wisp_spirits_in" then                    
                                                    if not Ability.GetToggleState(spell) and Entity.GetAbsOrigin(v):Distance(Entity.GetAbsOrigin(me)):Length2D() < 650 and Entity.GetAbsOrigin(v):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() > 60 and Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() < 325 then
                                                        Ability.Toggle(spell)
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1
                                                    end
                                                elseif Ability.GetName(spell) == "wisp_spirits_out" then
                                                    if not Ability.GetToggleState(spell) and Entity.GetAbsOrigin(v):Distance(Entity.GetAbsOrigin(me)):Length2D() < 325 and Entity.GetAbsOrigin(v):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() > 60 and Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() > 325 then
                                                       Ability.Toggle(spell)
                                                       ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1
                                                    end
                                                end
                                            end
                                        end
                                    elseif (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
                                        if Ability.GetName(spell) == "pugna_nether_ward" then
                                            Ability.CastPosition(spell, Entity.GetAbsOrigin(me))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "windrunner_gale_force" then
                                            if Entity.GetAbsOrigin(target):Distance(Entity.GetAbsOrigin(me)):Length2D() > NPC.GetAttackRange(me) + 250 then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 950))
                                                Player.PrepareUnitOrders(Players.GetLocal(), 30, nil, Entity.GetAbsOrigin(me), spell, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, me)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.3
                                            end
                                        elseif Ability.GetName(spell) == "shredder_timber_chain" then
                                            for _, tree in ipairs(Trees.InRadius(Entity.GetAbsOrigin(me), 1450, true)) do
                                                if tree then
                                                    if (Entity.GetAbsOrigin(tree):GetX() - ability.skillshotXYZ(me, target, 950):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 950):GetX()) < 0 and (Entity.GetAbsOrigin(tree):GetY() - ability.skillshotXYZ(me, target, 950):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 950):GetY()) < 0 and math.abs((Entity.GetAbsOrigin(tree):GetX() - ability.skillshotXYZ(me, target, 950):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 950):GetX()) - (Entity.GetAbsOrigin(tree):GetY() - ability.skillshotXYZ(me, target, 950):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 950):GetY())) < 0.3 then
                                                        Ability.CastPosition(spell, Entity.GetAbsOrigin(tree))
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                end
                                            end
                                        elseif Ability.GetName(spell) == "juggernaut_healing_ward" then
                                            --soon
                                        elseif Ability.GetName(spell) == "void_spirit_aether_remnant" or Ability.GetName(spell) == "pangolier_swashbuckle" or Ability.GetName(spell) == "clinkz_burning_army" then
                                            if not NPC.IsRunning(target) then
                                                Player.PrepareUnitOrders(Players.GetLocal(), 30, nil, Entity.GetAbsOrigin(target), spell, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, me)
                                                Ability.CastPosition(spell, Entity.GetAbsOrigin(me) + ((Entity.GetAbsOrigin(target) - Entity.GetAbsOrigin(me)):Normalized():Scaled(Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() - 300)))
                                               ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1
                                            else
                                                Player.PrepareUnitOrders(Players.GetLocal(), 30, nil, Entity.GetAbsOrigin(target) + Entity.GetRotation(target):GetForward():Normalized():Scaled(NPC.GetMoveSpeed(target)), spell, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, me)
                                                Ability.CastPosition(spell, Entity.GetAbsOrigin(me) + ((Entity.GetAbsOrigin(target) - Entity.GetAbsOrigin(me)):Normalized():Scaled(Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() - 300 + NPC.GetMoveSpeed(target))))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1
                                            end
                                        elseif Ability.GetName(spell) == "broodmother_sticky_snare" then
                                            if Ability.GetCurrentCharges(spell) > 0 and (NPC.HasModifier(target, "modifier_broodmother_silken_bola") or NPC.IsStunned(target) or NPC.IsRooted(target)) then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 300))
                                                Player.PrepareUnitOrders(Players.GetLocal(), 30, nil, ability.skillshotXYZ(me, target, 2000) + Entity.GetRotation(target):GetForward():Normalized():Scaled(distance):Rotated(Angle(0,45,0)), spell, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, me)
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 4
                                            end
                                        elseif Ability.GetName(spell) == "phoenix_launch_fire_spirit" then
                                            Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 600))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 3.5
                                        elseif Ability.GetName(spell) == "phoenix_sun_ray" then
                                           if ability.skillshotXYZ(me, target, 950):Distance(Entity.GetAbsOrigin(me)):Length2D() > NPC.GetAttackRange(target) + 300 then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 950))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                           end
                                        elseif Ability.GetName(spell) == "sniper_shrapnel" then
                                            if Ability.GetCurrentCharges(spell) > 0 and not NPC.HasModifier(target, "modifier_sniper_shrapnel_slow") then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 900))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 3
                                            end
                                        elseif Ability.GetName(spell) == "void_spirit_astral_step" then
                                            if Ability.IsStolen(spell) or ability.skillshotXYZ(me, target, 950):Distance(Entity.GetAbsOrigin(me)):Length2D() > NPC.GetAttackRange(me) + 300 and Ability.GetCurrentCharges(spell) > 0 then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 1600) + (ability.skillshotXYZ(me, target, 1600) - Entity.GetAbsOrigin(me)):Normalized():Scaled(300))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.3
                                            end
                                        elseif Ability.GetName(spell) == "primal_beast_rock_throw" then
                                            if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > 550 then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 800))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "primal_beast_onslaught" then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 1000))
                                                ability.sleeptime["primal_beast_onslaught_release"], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 600, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "keeper_of_the_light_blinding_light" or Ability.GetName(spell) == "keeper_of_the_light_blinding_light" then
                                            if NPC.FindFacingNPC(target, nil, 0, NPC.GetAttackRange(target), 25) == me then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 950) + ((Entity.GetAbsOrigin(me) - ability.skillshotXYZ(me, target, 950)):Normalized():Scaled(100)))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "antimage_blink" or Ability.GetName(spell) == "queenofpain_blink" or Ability.GetName(spell) == "faceless_void_time_walk" or Ability.GetName(spell) == "windrunner_powershot" and not Ability.IsStolen(spell) then
                                            if ability.skillshotXYZ(me, target, 950):Distance(Entity.GetAbsOrigin(me)):Length2D() > NPC.GetAttackRange(me) + 300 or Ability.GetName(spell) == "faceless_void_time_walk" and (NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed")) then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 1000))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "magnataur_skewer" then
                                            local unit_table = {}
                                            for _, unit in ipairs(Entity.GetUnitsInRadius(me, distance + 1200, 2)) do
                                                if unit and (NPC.IsTower(unit) or NPC.IsHero(unit) or NPC.GetUnitName(unit) == "dota_fountain") then
                                                    table.insert(unit_table, unit)
                                                    if #unit_table > 0 then
                                                        table.sort(unit_table, function (a, b) return Entity.GetAbsOrigin(a):Distance(Entity.GetAbsOrigin(b)):Length2D() > Entity.GetAbsOrigin(b):Distance(Entity.GetAbsOrigin(a)):Length2D() end)
                                                    end
                                                end
                                            end
                                            if unit_table[1] and (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 950):GetX()) / (Entity.GetAbsOrigin(unit_table[1]):GetX() - ability.skillshotXYZ(me, target, 950):GetX()) < 0 and (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 950):GetY()) / (Entity.GetAbsOrigin(unit_table[1]):GetY() - ability.skillshotXYZ(me, target, 950):GetY()) < 0 and math.abs((Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 950):GetX()) / (Entity.GetAbsOrigin(unit_table[1]):GetX() - ability.skillshotXYZ(me, target, 950):GetX()) - (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 950):GetY()) / (Entity.GetAbsOrigin(unit_table[1]):GetY() - ability.skillshotXYZ(me, target, 950):GetY())) < 0.3 then
                                                Ability.CastPosition(spell, Entity.GetAbsOrigin(unit_table[1]))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "hoodwink_bushwhack" then
                                            if NPC.GetAbility(me, "special_bonus_unique_hoodwink_bushwhack_radius") and Ability.GetLevel(NPC.GetAbility(me, "special_bonus_unique_hoodwink_bushwhack_radius")) > 0 then hoodwink_bushwhack_radius = 400 else hoodwink_bushwhack_radius = 265 end
                                            for _, tree in ipairs(Trees.InRadius(Entity.GetAbsOrigin(me), distance)) do
                                                if tree and Entity.GetAbsOrigin(tree):Distance(ability.skillshotXYZ(me, target, 1000)):Length2D() < hoodwink_bushwhack_radius then
                                                    Ability.CastPosition(spell, Entity.GetAbsOrigin(tree) + ((ability.skillshotXYZ(me, target, 2000) - Entity.GetAbsOrigin(tree)):Normalized():Scaled(hoodwink_bushwhack_radius - math.random(3, 60))))
                                                    ability.sleeptime["hoodwink_hunters_boomerang"], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 900, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                            --[[if not ability.cast_pos["hoodwink_acorn_shot"] then
                                            else
                                                if ability.skillshotXYZ(me, target, 950):Distance(ability.cast_pos["hoodwink_acorn_shot"]):Length2D() < 300 then
                                                    Ability.CastPosition(spell, ability.cast_pos["hoodwink_acorn_shot"])
                                                end
                                            end]]
                                        elseif Ability.GetName(spell) == "tusk_ice_shards" then
                                            if NPC.GetTimeToFace(target, me) > 0.06 then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 750) + (ability.skillshotXYZ(me, target, 750) - Entity.GetAbsOrigin(me)):Normalized():Scaled(300))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "morphling_waveform" or Ability.GetName(spell) == "sandking_burrowstrike" then
                                            Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 750) + (ability.skillshotXYZ(me, target, 750) - Entity.GetAbsOrigin(me)):Normalized():Scaled(300))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "hoodwink_sharpshooter" then
                                            if Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() > NPC.GetAttackRange(me) + 300 and Entity.GetHealth(target) + NPC.GetHealthRegen(target) < Ability.GetLevelSpecialValueFor(spell, "max_damage") * NPC.GetMagicalArmorDamageMultiplier(target) then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 950))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        -- aoe cast
                                        elseif Ability.GetName(spell) == "terrorblade_reflection" then
                                            Ability.CastPosition(spell, ability.skillshotAOE(me, target, 900))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "puck_dream_coil" then
                                            if #Heroes.InRadius(ability.skillshotXYZ(me, target, 562), 562, Entity.GetTeamNum(me), 0) > 1 then
                                                Ability.CastPosition(spell, ability.skillshotAOE(me, target, 562))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "warlock_rain_of_chaos" then
                                            Ability.CastPosition(spell, ability.skillshotAOE(me, target, 900))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "kunkka_ghostship" then
                                            if NPC.HasModifier(target, "modifier_kunkka_x_marks_the_spot") or NPC.IsStunned(target) or NPC.IsRooted(target) then
                                                if ability.cast_pos["kunkka_x_marks_the_spot"] then
                                                    Ability.CastPosition(spell, ability.cast_pos["kunkka_x_marks_the_spot"])
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                else
                                                    Ability.CastPosition(spell, ability.skillshotAOE(me, target, 637.5))
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                        elseif Ability.GetName(spell) == "invoker_emp" then
                                            Ability.CastPosition(spell, ability.skillshotAOE(me, target, 1425))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "silencer_last_word" then
                                            Ability.CastPosition(spell, ability.skillshotAOE(me, target, 750))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "dark_willow_terrorize" then
                                            if #Heroes.InRadius(ability.skillshotXYZ(me, target, 600), 600, Entity.GetTeamNum(me), 0) > 1 then
                                                Ability.CastPosition(spell, ability.skillshotAOE(me, target, 600))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "keeper_of_the_light_will_o_wisp" or Ability.GetName(spell) == "brewmaster_cinder_brew" or Ability.GetName(spell) == "dark_seer_vacuum" or Ability.GetName(spell) == "crystal_maiden_crystal_nova" or Ability.GetName(spell) == "tiny_avalanche" or Ability.GetName(spell) == "enigma_black_hole" or Ability.GetName(spell) == "silencer_curse_of_the_silent" or Ability.GetName(spell) == "enigma_midnight_pulse" or Ability.GetName(spell) == "alchemist_acid_spray" or Ability.GetName(spell) == "disruptor_static_storm" or Ability.GetName(spell) == "ember_spirit_sleight_of_fist" or Ability.GetName(spell) == "death_prophet_silence" or Ability.GetName(spell) == "pugna_nether_blast" or Ability.GetName(spell) == "gyrocopter_call_down" or Ability.GetName(spell) == "abyssal_underlord_firestorm" or Ability.GetName(spell) == "abyssal_underlord_pit_of_malice" or Ability.GetName(spell) == "undying_decay" or Ability.GetName(spell) == "riki_smoke_screen" then
                                            Ability.CastPosition(spell, ability.skillshotAOE(me, target, Ability.GetLevelSpecialValueFor(spell, "radius")))
                                            if Ability.GetName(spell) == "enigma_black_hole" then ability.channelling[me] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1 end
                                            if Ability.GetName(spell) == "ember_spirit_sleight_of_fist" then ability.sleeptime["ember_spirit_fire_remnant"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5 end
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "obsidian_destroyer_sanity_eclipse" then
                                            if Ability.IsStolen(spell) or ability1 and Ability.GetName(ability1) == "obsidian_destroyer_astral_imprisonment" and (Ability.GetCooldown(ability1) > 0 or (NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed")) and Ability.GetCurrentCharges(ability1) == 0) and NPC.GetModifier(me, "modifier_obsidian_destroyer_equilibrium_buff_counter") and Modifier.GetStackCount(NPC.GetModifier(me, "modifier_obsidian_destroyer_equilibrium_buff_counter")) > 1000 then
                                                Ability.CastPosition(spell, ability.skillshotAOE(me, target, Ability.GetLevelSpecialValueFor(spell, "radius")))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5 
                                            end
                                        elseif Ability.GetName(spell) == "monkey_king_wukongs_command" then
                                            if NPC.GetAbility(me, "special_bonus_unique_monkey_king_4") and Ability.GetLevel(NPC.GetAbility(me, "special_bonus_unique_monkey_king_4")) > 0 then wukongs_radius = 1130 else wukongs_radius = 750 end
                                            if #Heroes.InRadius(ability.skillshotXYZ(me, target, wukongs_radius), 562, Entity.GetTeamNum(me), 0) > 1 and not NPC.HasModifier(me, "modifier_monkey_king_bounce_leap") then
                                                Ability.CastPosition(spell, ability.skillshotAOE(me, target, wukongs_radius * 1.5))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "dark_willow_bramble_maze" or Ability.GetName(spell) == "dark_willow_terrorize" then
                                            Ability.CastPosition(spell, ability.skillshotAOE(me, target, 500))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            
                                        elseif Ability.GetName(spell) == "faceless_void_chronosphere" then
                                            if NPC.GetAbility(me, "special_bonus_unique_faceless_void_2") and Ability.GetLevel(NPC.GetAbility(me, "special_bonus_unique_faceless_void_2")) > 0 then search_radius = Ability.GetLevelSpecialValueFor(spell, "radius") + 140 else search_radius = Ability.GetLevelSpecialValueFor(spell, "radius") end
                                            if #Heroes.InRadius(ability.skillshotXYZ(me, target, search_radius), search_radius, Entity.GetTeamNum(me), 0) > 1 then
                                                Ability.CastPosition(spell, ability.skillshotAOE(me, target, search_radius))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "earth_spirit_stone_caller" then
                                            if NPC.GetModifier(target, "modifier_earth_spirit_magnetize") and Modifier.GetDieTime(NPC.GetModifier(target, "modifier_earth_spirit_magnetize")) > 0 and Modifier.GetDieTime(NPC.GetModifier(target, "modifier_earth_spirit_magnetize")) - GameRules.GetGameTime() < 0.7 then
                                                Ability.CastPosition(spell, ability.skillshotAOE(me, target, 675))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 4
                                            end
                                            if ability0 and Ability.IsReady(ability0) and Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() > NPC.GetAttackRange(me) + 100 then
                                                Ability.CastPosition(spell, Entity.GetAbsOrigin(me) + ((ability.skillshotXYZ(me, target, 950) - Entity.GetAbsOrigin(me)):Normalized():Scaled(200)))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 4
                                            end
                                        elseif Ability.GetName(spell) == "lich_sinister_gaze" and (NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed")) then
                                            Ability.CastPosition(spell, ability.skillshotAOE(me, target,  400))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        -- aoe cast2
                                        elseif Ability.GetName(spell) == "earthshaker_fissure" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "fissure_radius")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "drow_ranger_wave_of_silence" then
                                            if Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() < NPC.GetAttackRange(target) + 100 and NPC.GetTimeToFace(target, me) < 0.03 then
                                                Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "wave_width")))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "queenofpain_sonic_wave" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "final_aoe")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "drow_ranger_multishot" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "arrow_width") * 4))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "vengefulspirit_wave_of_terror" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "wave_width")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "lina_dragon_slave" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "dragon_slave_width_initial")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "lina_light_strike_array" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "light_strike_array_aoe")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "death_prophet_carrion_swarm" or Ability.GetName(spell) == "dragon_knight_breathe_fire" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "end_radius")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "weaver_the_swarm" then
                                            if not NPC.HasState(me, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then
                                                Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "spawn_radius")))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "invoker_tornado" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "area_of_effect")))
                                            ability.sleeptime["invoker_emp"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 1200 + Ability.GetLevelSpecialValueFor(spell, "lift_duration")
                                            ability.sleeptime["invoker_chaos_meteor"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 1200 + Ability.GetLevelSpecialValueFor(spell, "lift_duration")
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "invoker_deafening_blast" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "radius_end")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "monkey_king_boundless_strike" and not Ability.IsStolen(spell) then
                                            if NPC.HasModifier(me, "modifier_monkey_king_quadruple_tap_bonuses") then
                                                Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "strike_crit_mult")))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "lion_impale" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "width")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "treant_natures_grasp" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "vine_spawn_interval")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "jakiro_dual_breath" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "end_radius")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "jakiro_ice_path" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "path_radius")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "nyx_assassin_impale" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "width")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "elder_titan_earth_splitter" then
                                            if NPC.HasModifier(target, "modifier_elder_titan_echo_stomp") then
                                                Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "crack_width")))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "venomancer_venomous_gale" or Ability.GetName(spell) == "puck_illusory_orb" then
                                            Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "radius")))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "magnataur_shockwave" then
                                            if NPC.GetItem(me, "item_ultimate_scepter") or NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed") then
                                                Ability.CastPosition(spell, ability.skillshotFront(me, target, 1800))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            else
                                                Ability.CastPosition(spell, ability.skillshotFront(me, target,Ability.GetLevelSpecialValueFor(spell, "shock_width")))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "rubick_telekinesis_land" then
                                            local enemies = {}
                                            if not ability.throw_allies then
                                                for i, v in ipairs(Entity.GetHeroesInRadius(me, 1075, 0)) do
                                                    if v and v ~= target then
                                                        table.insert(enemies, v)
                                                        if #enemies > 0 then
                                                            table.sort(enemies, function (a, b) return Entity.GetAbsOrigin(a):Distance(Entity.GetAbsOrigin(b)):Length2D() > Entity.GetAbsOrigin(b):Distance(Entity.GetAbsOrigin(a)):Length2D() end)
                                                        end
                                                    end
                                                    if enemies[1] and ability.skillshotXYZ(me, target, 2000):Distance(Entity.GetAbsOrigin(enemies[1])):Length2D() < throw_range then
                                                        if not ability.cast_pos["rubick_telekinesis"] or ability.cast_pos["rubick_telekinesis"] and Entity.GetAbsOrigin(enemies[1]):Distance(ability.cast_pos["rubick_telekinesis"]):Length2D() > 90 then
                                                            Ability.CastPosition(spell, ability.skillshotXYZ(me, enemies[1], 1800))
                                                            ability.cast_pos["rubick_telekinesis"], ability.sleeptime[Ability.GetName(spell)] = Entity.GetAbsOrigin(enemies[1]), GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                        end
                                                    end
                                                end
                                            else
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 2000))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "shredder_chakram" then
                                            Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 950))
                                            ability.sleeptime["shredder_return_chakram"], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 550, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "shredder_chakram_2" then
                                            Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 950))
                                            ability.sleeptime["shredder_return_chakram_2"], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 550, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "ancient_apparition_ice_blast" then
                                            Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 1000))
                                            ability.sleeptime["ancient_apparition_ice_blast_release"], ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 1300, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "kunkka_torrent" then
                                            if NPC.HasModifier(target, "modifier_kunkka_x_marks_the_spot") or NPC.IsStunned(target) or NPC.IsRooted(target) then
                                                if ability.cast_pos["kunkka_x_marks_the_spot"] then
                                                    Ability.CastPosition(spell, ability.cast_pos["kunkka_x_marks_the_spot"])
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                else
                                                    Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 1000))
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                        elseif Ability.GetName(spell) == "broodmother_spin_web" then
                                            if not NPC.HasModifier(me, "modifier_broodmother_spin_web") then
                                                local web = NPCs.InRadius(Entity.GetAbsOrigin(me) + Entity.GetRotation(me):GetForward():Normalized():Scaled(500), 3000, Entity.GetTeamNum(me), 2)
                                                if web[1] and NPC.GetUnitName(web[1]) == "npc_dota_broodmother_web" and Entity.GetAbsOrigin(web[1]):Distance(Entity.GetAbsOrigin(me) + Entity.GetRotation(me):GetForward():Normalized():Scaled(500)):Length2D() > 900 then
                                                    Ability.CastPosition(spell, Entity.GetAbsOrigin(me) + Entity.GetRotation(me):GetForward():Normalized():Scaled(500))
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1
                                                else
                                                    Ability.CastPosition(spell, Entity.GetAbsOrigin(me) + Entity.GetRotation(me):GetForward():Normalized():Scaled(500))
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1
                                                end
                                            end
                                        elseif Ability.GetName(spell) == "storm_spirit_ball_lightning" then
                                            if not NPC.HasModifier(me, "modifier_storm_spirit_overload") and ability0 and Ability.GetName(ability0) == "storm_spirit_static_remnant" and Ability.IsReady(ability0) then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 900))
                                                ability.sleeptime[Ability.GetName(spell)], ability.sleeptime["storm_spirit_electric_vortex"], ability.sleeptime["storm_spirit_static_remnant"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.35, GameRules.GetGameTime() + 0.35, GameRules.GetGameTime() + 0.35
                                            end
                                        elseif Ability.GetName(spell) == "meepo_earthbind" then
                                            Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 800))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 2
                                        elseif Ability.GetName(spell) == "snapfire_mortimer_kisses" then
                                            if Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > NPC.GetAttackRange(me) + 350 then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 950))
                                                ability.channelling[me] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "mars_spear" then
                                            for _, tree in ipairs(Trees.InRadius(Entity.GetAbsOrigin(me), distance)) do
                                                if tree and (Entity.GetAbsOrigin(tree):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) < 0 and (Entity.GetAbsOrigin(tree):GetY() - ability.skillshotXYZ(me, target, 2000):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 2000):GetY()) < 0 and math.abs((Entity.GetAbsOrigin(tree):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) - (Entity.GetAbsOrigin(tree):GetY() - ability.skillshotXYZ(me, target, 2000):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 2000):GetY())) < 0.3 then
                                                    Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 2000))
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                            for _, building in ipairs(Entity.GetUnitsInRadius(me, distance, 2)) do
                                                if building and (NPC.IsStructure(building) or NPC.IsTower(building)) and Entity.IsAlive(building) and Entity.GetAbsOrigin(building):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() < distance then
                                                    if (Entity.GetAbsOrigin(building):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) < 0 and (Entity.GetAbsOrigin(building):GetY() - ability.skillshotXYZ(me, target, 2000):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 2000):GetY()) < 0 and math.abs((Entity.GetAbsOrigin(building):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) - (Entity.GetAbsOrigin(building):GetY() - ability.skillshotXYZ(me, target, 2000):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 2000):GetY())) < 0.3 then
                                                        Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 2000))
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                end
                                            end
                                            if ability5 and Ability.SecondsSinceLastUse(ability5) > 0 and Ability.SecondsSinceLastUse(ability5) < 2 then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 2000))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "mars_arena_of_blood" then
                                            Ability.CastPosition(spell, Entity.GetAbsOrigin(me) + (ability.skillshotXYZ(me, target, 2000) - Entity.GetAbsOrigin(me)):Normalized():Scaled(Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 2000)):Length2D() / 2))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "lion_voodoo" then
                                            Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 2000))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "ember_spirit_fire_remnant" then
                                            if Ability.IsStolen(spell) or Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 1000)):Length2D() > NPC.GetAttackRange(me) + 400 then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 1000))
                                                if not Ability.IsStolen(spell) then ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 300 end
                                                if not NPC.GetItem(me, "item_ultimate_scepter") and not NPC.HasModifier(me, "modifier_item_ultimate_scepter_consumed") then ability.sleeptime["ember_spirit_activate_fire_remnant"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 1300 end
                                            end
                                        elseif Ability.GetName(spell) == "ember_spirit_activate_fire_remnant" then
                                            local unit_table = {}
                                            for n, unit in ipairs(Entity.GetUnitsInRadius(me, distance, 2)) do
                                                if unit and NPC.GetUnitName(unit) == "npc_dota_ember_spirit_remnant" then
                                                    table.insert(unit_table, unit)
                                                    if #unit_table > 0 then
                                                         table.sort(unit_table, function (a, b) return Entity.GetAbsOrigin(a):Distance(Entity.GetAbsOrigin(b)):Length2D() > Entity.GetAbsOrigin(b):Distance(Entity.GetAbsOrigin(a)):Length2D() end)
                                                    end
                                                end
                                            end
                                            if unit_table[1] then
                                                Ability.CastPosition(spell, Entity.GetAbsOrigin(unit_table[1]))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "sniper_concussive_grenade" or Ability.GetName(spell) == "phantom_lancer_doppelwalk" then
                                            if Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() < NPC.GetAttackRange(target) + 100 and NPC.GetTimeToFace(target, me) < 0.03 then
                                                Ability.CastPosition(spell, Entity.GetAbsOrigin(me) + ((ability.skillshotXYZ(me, target, 950) - Entity.GetAbsOrigin(me)):Normalized():Scaled(Entity.GetAbsOrigin(me):Distance(ability.skillshotXYZ(me, target, 950)):Length2D() / 2)))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "spectre_reality" then
                                            if (ability.handle["spectre_haunt_single"] and Ability.SecondsSinceLastUse(ability.handle["spectre_haunt_single"].spell) > 0 and Ability.SecondsSinceLastUse(ability.handle["spectre_haunt_single"].spell) < 5 or ability.handle["spectre_haunt"] and Ability.SecondsSinceLastUse(ability.handle["spectre_haunt"].spell) > 0 and Ability.SecondsSinceLastUse(ability.handle["spectre_haunt"].spell) < 5) and Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() > NPC.GetAttackRange(me) + 300 then
                                                Ability.CastPosition(spell, Entity.GetAbsOrigin(target))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "kunkka_tidal_wave" then
                                            for _, tree in ipairs(Trees.InRadius(Entity.GetAbsOrigin(me), 9999, true)) do
                                                if tree then
                                                    if (Entity.GetAbsOrigin(tree):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) < 0 and (Entity.GetAbsOrigin(tree):GetY() - ability.skillshotXYZ(me, target, 2000):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 2000):GetY()) < 0 and math.abs((Entity.GetAbsOrigin(tree):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) / (Entity.GetAbsOrigin(me):GetX() - ability.skillshotXYZ(me, target, 2000):GetX()) - (Entity.GetAbsOrigin(tree):GetY() - ability.skillshotXYZ(me, target, 2000):GetY()) / (Entity.GetAbsOrigin(me):GetY() - ability.skillshotXYZ(me, target, 2000):GetY())) < 1 then
                                                        Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 950) + ((Entity.GetAbsOrigin(me) - ability.skillshotXYZ(me, target, 950)):Normalized():Scaled(ability.skillshotXYZ(me, target, 950):Distance(Entity.GetAbsOrigin(me)):Length2D() + distance - 550)))
                                                        ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                    end
                                                end
                                            end
                                        elseif Ability.GetName(spell) == "techies_sticky_bomb" then
                                            Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 900))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "techies_suicide" then
                                            if NPC.GetModifier(target, "modifier_techies_sticky_bomb_slow") or NPC.GetModifier(me, "modifier_techies_reactive_tazer") and Modifier.GetDieTime(NPC.GetModifier(me, "modifier_techies_reactive_tazer")) > 0 and Modifier.GetDieTime(NPC.GetModifier(me, "modifier_techies_reactive_tazer")) - GameRules.GetGameTime() < 2 then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 900))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "techies_land_mines" then
                                            if not NPC.IsRunning(target) then angle = {90, 270} else angle = {40, 320} end
                                            if not ability.cast_pos[Ability.GetName(spell)] then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 3000) + Entity.GetRotation(target):GetForward():Normalized():Scaled(255):Rotated(Angle(0,angle[2],0)))
                                                ability.cast_pos[Ability.GetName(spell)] = ability.skillshotXYZ(me, target, 3000) + Entity.GetRotation(target):GetForward():Normalized():Scaled(255):Rotated(Angle(0,angle[1],0))
                                            else
                                                Ability.CastPosition(spell, ability.cast_pos[Ability.GetName(spell)])
                                                ability.cast_pos[Ability.GetName(spell)], ability.sleeptime[Ability.GetName(spell)] = nil, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.1
                                            end
                                        elseif Ability.GetName(spell) == "arc_warden_magnetic_field" then
                                            if not NPC.HasModifier(me, "modifier_arc_warden_magnetic_field_evasion") then
                                                Ability.CastPosition(spell, Entity.GetAbsOrigin(me))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Ability.GetLevelSpecialValueFor(spell, "duration")
                                            end
                                        elseif Ability.GetName(spell) == "arc_warden_spark_wraith" then
                                            Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 900))
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        elseif Ability.GetName(spell) == "tiny_tree_channel" then
                                            if #Trees.InRadius(Entity.GetAbsOrigin(me), 525, true) > 2 then Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 950)) end
                                        elseif  Ability.GetName(spell) == "ember_spirit_fire_remnant" or Ability.GetName(spell) == "death_prophet_spirit_siphon" or Ability.GetName(spell) == "shadow_demon_demonic_purge" then
                                            if Ability.GetCurrentCharges(spell) > 0 then
                                                Ability.CastPosition(spell, Entity.GetAbsOrigin(me))
                                                ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "pudge_meat_hook" or Ability.GetName(spell) == "rattletrap_hookshot" or Ability.GetName(spell) == "mirana_arrow" then
                                            if not ability.checkspellblocked(me, Entity.GetAbsOrigin(me), ability.skillshotXYZ(me, target, 2100), target, spell) and (Ability.GetName(spell) == "pudge_meat_hook" or Ability.GetName(spell) == "rattletrap_hookshot" or Ability.GetName(spell) == "mirana_arrow") then
                                                if Ability.GetName(spell) == "rattletrap_hookshot" then
                                                    Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 2100))
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                elseif Ability.GetName(spell) == "mirana_arrow" then
                                                    Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 650))
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                else
                                                    Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 950))
                                                    ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end
                                        elseif Ability.GetName(spell) == "monkey_king_primal_spring" then
                                            if Ability.IsActivated(spell) then
                                                Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 600))
                                                ability.cast_pos["monkey_king_primal_spring"], ability.channelling[me], ability.sleeptime[Ability.GetName(spell)]  = ability.skillshotXYZ(me, target, 600), GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1.6, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                            end
                                        elseif Ability.GetName(spell) == "legion_commander_press_the_attack" then
                                            for name, handle in pairs(ability.handle) do
                                                if handle.spell and Entity.IsAbility(handle.spell) and (string.find(Ability.GetName(handle.spell), "_blink") and Ability.IsReady(handle.spell) or Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() < NPC.GetAttackRange(me) + 100) then
                                                    Ability.CastPosition(spell, Entity.GetAbsOrigin(me))
                                                    ability.sleeptime[Ability.GetName(spell)], ability.sleeptime["legion_commander_duel"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5, GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                                end
                                            end  
                                        elseif Ability.GetName(spell) == "slark_depth_shroud" then
                                        elseif Ability.GetName(spell) == "tinker_keen_teleport" then
                                        elseif Ability.GetName(spell) == "phoenix_icarus_dive" then
                                        else
                                            Ability.CastPosition(spell, ability.skillshotXYZ(me, target, 950))
                                            if Ability.GetName(spell) == "tiny_tree_channel" or Ability.GetName(spell) == "crystal_maiden_freezing_field" or Ability.GetName(spell) == "windrunner_powershot" or Ability.GetName(spell) == "witch_doctor_death_ward" or Ability.GetName(spell) == "riki_tricks_of_the_trade" or Ability.GetName(spell) == "warlock_upheaval" or Ability.GetName(spell) == "keeper_of_the_light_illuminate" or Ability.GetName(spell) == "monkey_king_primal_spring" or Ability.GetName(spell) == "dawnbreaker_solar_guardian" or Ability.GetName(spell) == "templar_assassin_trap_teleport" then ability.channelling[me] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 1 end
                                            if Ability.GetName(spell) == "earth_spirit_rolling_boulder" then ability.sleeptime["earth_spirit_boulder_smash"] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + Entity.GetAbsOrigin(me):Distance(Entity.GetAbsOrigin(target)):Length2D() / 1000 end
                                            ability.sleeptime[Ability.GetName(spell)] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + 0.5
                                        end
                                    end
                                end
                            end
                            if (NPC.HasModifier(me, "modifier_hoodwink_sharpshooter_windup") or NPC.HasModifier(me, "modifier_primal_beast_onslaught_windup") or NPC.HasModifier(me, "modifier_phoenix_sun_ray") or NPC.HasModifier(me, "modifier_snapfire_mortimer_kisses") or NPC.HasModifier(me, "modifier_void_spirit_dissimilate_phase")) and (not ability.walking[me] or ability.walking[me] < GameRules.GetGameTime()) then
                                Player.PrepareUnitOrders(Players.GetLocal(), 1, nil, ability.skillshotXYZ(me, target, 1000), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, me, false, true)
                                ability.walking[me] = GameRules.GetGameTime() + (NetChannel.GetAvgLatency(0) + NetChannel.GetAvgLatency(1)) + (math.random(6, 9) / 10)
                            end
                        end
                    end
                end
            end
        end
    end
end

function ability.OnUnitAnimation(animation)
    --if animation.unit and not ability.printing[animation.sequenceName] then Console.Print(animation.sequenceName) ability.printing[animation.sequenceName] = animation.unit end
    if animation.unit and Heroes.GetLocal() then
        if Entity.IsSameTeam(Heroes.GetLocal(), animation.unit) and Entity.IsAlive(animation.unit) and (NPC.IsHero(animation.unit) or NPC.IsCreep(animation.unit) or NPC.GetUnitName(animation.unit) == "npc_dota_lone_druid_bear1" or NPC.GetUnitName(animation.unit) == "npc_dota_lone_druid_bear2" or NPC.GetUnitName(animation.unit) == "npc_dota_lone_druid_bear3" or NPC.GetUnitName(animation.unit) == "npc_dota_lone_druid_bear4") and (Entity.GetOwner(Heroes.GetLocal()) == Entity.GetOwner(animation.unit) or Entity.OwnedBy(animation.unit, Heroes.GetLocal())) and not NPC.HasModifier(animation.unit, "modifier_antimage_blink_illusion") and not NPC.HasModifier(animation.unit, "modifier_monkey_king_fur_army_soldier_hidden") and not NPC.HasModifier(animation.unit, "modifier_monkey_king_fur_army_soldier") and animation.activity == 1503 then
            if not ability.orbwalking[animation.unit] then
                ability.orbwalking[animation.unit] = GameRules.GetGameTime()
            end
        end
        if not ability.defender[animation.unit] and NPC.IsHero(animation.unit) and not Entity.IsSameTeam(Heroes.GetLocal(), animation.unit) then
            for _, list in pairs(
                {
                    {name = "abil2_anim", spellname = "medusa_mystic_snake"},
                    {name = "ability1_cast_anim", spellname = "shadow_demon_disruption"},
                    {name = "amp_anim", spellname = "slardar_amplify_damage"},
                    {name = "attack_omni_cast", spellname = "juggernaut_omni_slash"},
                    {name = "blink_anim", spellname = "antimage_blink"},
                    {name = "broodmother_cast1_spawn_spiderlings_anim", spellname = "broodmother_spawn_spiderlings"},
                    {name = "cast04_winters_curse_flying_low_anim", spellname = "winter_wyvern_winters_curse"},
                    {name = "cast1_fireblast_anim", spellname = "ogre_magi_fireblast"},
                    {name = "cast1_fireblast_withUltiSceptre_anim", spellname = "ogre_magi_unrefined_fireblast"},
                    {name = "cast1_hellfire_blast", spellname = "skeleton_king_hellfire_blast"},
                    {name = "cast1_malefice_anim", spellname = "enigma_malefice"},
                    {name = "cast2_blink_strike_anim", spellname = "riki_blink_strike"},
                    {name = "cast2_ignite_anim", spellname = "ogre_magi_ignite"},
                    {name = "cast2_rift_anim", spellname = "puck_waning_rift"},
                    {name = "cast4_False_Promise_anim", spellname = "oracle_false_promise"},
                    {name = "cast4_black_hole_anim", spellname = "enigma_black_hole"},
                    {name = "cast4_primal_roar_anim", spellname = "beastmaster_primal_roar"},
                    {name = "cast4_rupture_anim", spellname = "bloodseeker_rupture"},
                    {name = "cast5_Overgrowth_anim", spellname = "treant_overgrowth"},
                    {name = "cast5_coil_anim", spellname = "puck_dream_coil"},
                    {name = "cast_4_poison_nova_anim", spellname = "venomancer_poison_nova"},
                    {name = "cast_GS_anim", spellname = "silencer_global_silence"},
                    {name = "cast_LW_anim", spellname = "silencer_last_word"},
                    {name = "cast_channel_shackles_anim", spellname = "shadow_shaman_shackles"},
                    {name = "cast_dagger_ani", spellname = "spectre_spectral_dagger"},
                    {name = "cast_doom_anim", spellname = "doom_bringer_doom"},
                    {name = "cast_hoofstomp_anim", spellname = "centaur_hoof_stomp"},
                    {name = "cast_mana_void", spellname = "antimage_mana_void"},
                    {name = "cast_mana_void", spellname = "arc_warden_tempest_double"},
                    {name = "cast_tracker_anim", spellname = "bounty_hunter_track"},
                    {name = "cast_ult_anim", spellname = "necrolyte_reapers_scythe"},
                    {name = "cast_ulti_anim", spellname = 'obsidian_destroyer_sanity_eclipse'},
                    {name = "cast_voodoo_anim", spellname = "shadow_shaman_voodoo"},
                    {name = "castb_anim", spellname = "obsidian_destroyer_astral_imprisonment"},
                    {name = "chain_frost_anim", spellname = "lich_chain_frost"},
                    {name = "chaosbolt_anim", spellname = "chaos_knight_chaos_bolt"},
                    {name = "chronosphere_anim", spellname = "faceless_void_chronosphere"},
                    {name = "crush_anim", spellname = "slardar_slithereen_crush"},
                    {name = "dragon_bash", spellname = "dragon_knight_dragon_tail"},
                    {name = "echo_slam_anim", spellname = "earthshaker_echo_slam"},
                    {name = "enchant_anim", spellname = "enchantress_enchant"},
                    {name = "enfeeble_anim", spellname = "bane_enfeeble"},
                    {name = "fiends_grip_cast_anim", spellname = "bane_fiends_grip"},
                    {name = "finger_anim", spellname = "lion_finger_of_death"},
                    {name = "fissure_anim", spellname = "earthshaker_fissure"},
                    {name = "frostbite_anim", spellname = "crystal_maiden_frostbite"},
                    {name = "impale_anim", spellname = "lion_impale"},
                    {name = "impale_anim", spellname = "nyx_assassin_impale"},
                    {name = "laguna_blade_anim", spellname = "lina_laguna_blade"},
                    {name = "lasso_start_anim", spellname = "batrider_flaming_lasso"},
                    {name = "legion_commander_duel_anim", spellname = "legion_commander_duel"},
                    {name = "life drain_anim", spellname = "pugna_life_drain"},
                    {name = "light_strike_array_lhand_anim", spellname = "lina_light_strike_array"},
                    {name = "light_strike_array_rhand_anim", spellname = "lina_light_strike_array"},
                    {name = "luna_cast_anim", spellname = "luna_lucent_beam"},
                    {name = "magic_missile_anim", spellname = "vengefulspirit_magic_missile"},
                    {name = "mana_burn_anim", spellname = "nyx_assassin_mana_burn"},
                    {name = "marci_cast_grapple_alt", spellname = "marci_grapple"},
                    {name = "marci_cast_unleash", spellname = "marci_unleash"},
                    {name = "pb_cast_pummel_v3", spellname = "primal_beast_pulverize"},
                    {name = "phantom_assassin_phantomstrike_anim", spellname = "phantom_assassin_phantom_strike"},
                    {name = "polarity_anim", spellname = "magnataur_reverse_polarity"},
                    {name = "pudge_dismember_start", spellname = "pudge_dismember"},
                    {name = "queen_sonicwave_anim", spellname = "queenofpain_sonic_wave"},
                    {name = "queenofpain_blink_start_anim", spellname = "queenofpain_blink"},
                    {name = "ravage_anim", spellname = "tidehunter_ravage"},
                    {name = "rubick_cast_fadebolt_anim", spellname = "rubick_fade_bolt"},
                    {name = "rubick_cast_telekinesis_anim", spellname = "rubick_telekinesis"},
                    {name = "sand_king_epicast_anim", spellname = "sandking_epicenter"},
                    {name = "searing_chains_anim", spellname = "ember_spirit_searing_chains"},
                    {name = "shackleshot_anim", spellname = "windrunner_shackleshot"},
                    {name = "skywrath_mage_mystic_flare_cast_anim", spellname = "skywrath_mage_mystic_flare"},
                    {name = "skywrath_mage_seal_cast_anim", spellname = "skywrath_mage_ancient_seal"},
                    {name = "snapfire_blobs_cast", spellname = "snapfire_mortimer_kisses"},
                    {name = "sniper_assassinate_cast4_aggressive_anim", spellname = "sniper_assassinate"},
                    {name = "sniper_assassinate_cast4_aggressive_ulti_scepter", spellname = "sniper_assassinate"},
                    {name = "split_earth_anim", spellname = "leshrac_split_earth"},
                    {name = "storm_bolt_anim", spellname = "sven_storm_bolt"},
                    {name = "sunder", spellname = "terrorblade_sunder"},
                    {name = "timewalk_anim", spellname = "faceless_void_time_walk"},
                    {name = "ultimate_anim", spellname = "shadow_demon_demonic_purge"},
                    {name = "ultimate_anim", spellname = "spirit_breaker_nether_strike"},
                    {name = "viper_strike_anim", spellname = "viper_viper_strike"},
                    {name = "vortex_anim", spellname = "storm_spirit_electric_vortex"},
                    --{name = "zeus_cast1_arc_lightning", spellname = "zuus_arc_lightning"},
                    {name = "zeus_cast2_lightning_bolt", spellname = "zuus_lightning_bolt"},
                    {name = "cast_anim", spellname = "morphling_adaptive_strike_agi"},
                    {name = "cast_anim", spellname = "ember_spirit_fire_remnant"},
                    {name = "shieldbash_anim", spellname = "dragon_knight_dragon_tail"},
                    {name = "polarity_anim", spellname = "magnataur_reverse_polarity"}
                }
            ) do
                if list and animation.sequenceName == list.name then
                    for i = 0, 24 do
                        local enemyspell = NPC.GetAbilityByIndex(animation.unit, i)
                        if enemyspell and Ability.GetName(enemyspell) == list.spellname then
                            local distance = ability.get_distance(enemyspell, animation.unit)
                            if distance > 0 and Entity.GetAbsOrigin(Heroes.GetLocal()):Distance(Entity.GetAbsOrigin(animation.unit)):Length2D() < distance + 90 then
                                ability.defender[animation.unit] = {spell = enemyspell, unit = animation.unit, time = GameRules.GetGameTime(), castpoint = animation.castpoint}
                            end
                        end
                    end
                end
            end
        end
    end
end

function ability.safe_cast(npc, npc2)
    if NPC.HasModifier(npc, "modifier_eul_cyclone") or NPC.HasModifier(npc, "modifier_wind_waker") or NPC.HasModifier(npc2, "modifier_invulnerable") or NPC.HasModifier(npc2, "modifier_phantomlancer_dopplewalk_phase") or NPC.HasModifier(npc2, "modifier_eul_cyclone") or NPC.HasModifier(npc2, "modifier_wind_waker") or NPC.HasModifier(npc2, "modifier_ursa_enrage") or NPC.HasModifier(npc2, "modifier_troll_warlord_battle_trance") or NPC.HasModifier(npc2, "modifier_invoker_tornado") or NPC.HasModifier(npc2, "modifier_abaddon_borrowed_time") or NPC.GetAbility(npc2, "phantom_lancer_doppelwalk") and Ability.IsInAbilityPhase(NPC.GetAbility(npc2, "phantom_lancer_doppelwalk")) then return false else return true end
end

function ability.skillshotXYZ(npc, npc2, speed)
    if NPC.IsRunning(npc2) and not NPC.IsStunned(npc2) and not NPC.IsRooted(npc2) then
        return Entity.GetAbsOrigin(npc2) + Entity.GetRotation(npc2):GetForward():Normalized():Scaled(Entity.GetAbsOrigin(npc):Distance(Entity.GetAbsOrigin(npc2)):Length2D() * NPC.GetMoveSpeed(npc2) / speed)
    end
    return Entity.GetAbsOrigin(npc2)
end

function ability.skillshotAOE(npc, npc2, radius)
    local enemies = Heroes.InRadius(ability.skillshotXYZ(npc, npc2, 1200), radius, Entity.GetTeamNum(npc), 0)
    if #enemies > 1 then
        local pos = {}
        for i, v in ipairs(enemies) do
            if v then
                table.insert(pos, {x = Entity.GetAbsOrigin(v):GetX(), y = Entity.GetAbsOrigin(v):GetY()})
            end
        end
        local x, y, c = 0, 0, #pos
        for i = 1, c do
            x = x + pos[i].x
            y = y + pos[i].y
        end
        return Vector(x/c, y/c, 0)
    end
    return ability.skillshotXYZ(npc, npc2, 1000)
end

function ability.skillshotFront(npc, npc2, radius)
    local smart_cast = false
    for i = 1, math.floor((Entity.GetAbsOrigin(npc) - ability.skillshotXYZ(npc, npc2, 1200)):Length2D()) do
        for _, unit in ipairs(Heroes.InRadius(Entity.GetAbsOrigin(npc) + (ability.skillshotXYZ(npc, npc2, 1200) - Entity.GetAbsOrigin(npc)):Normalized():Scaled(i * radius), radius, Entity.GetTeamNum(npc), 0)) do
            if unit and unit ~= npc2 and Entity.IsAlive(unit) and not Entity.IsDormant(unit) then
                smart_cast = true
                return Entity.GetAbsOrigin(unit) + (ability.skillshotXYZ(npc, npc2, 1200) - Entity.GetAbsOrigin(unit)):Normalized():Scaled(Entity.GetAbsOrigin(unit):Distance(ability.skillshotXYZ(npc, npc2, 1200)):Length2D() / 2)
            end
        end
    end
    if not smart_cast then
        return ability.skillshotXYZ(npc, npc2, 1000)
    end
end

function ability.checkspellblocked(npc, pos, pos2, npc2, spell)
    for i = 1, math.floor((pos - pos2):Length2D() / 125) do
        for _, unit in ipairs(NPCs.InRadius(pos + (pos2 - pos):Normalized():Scaled(i * 125), 125, Entity.GetTeamNum(npc), 3)) do
            if unit and Entity.IsAlive(unit) and unit ~= npc and unit ~= npc2 and (NPC.IsCreep(unit) or NPC.IsHero(unit)) and (Ability.GetName(spell) == "mirana_arrow" and not Entity.IsSameTeam(npc, unit) or Ability.GetName(spell) ~= "mirana_arrow") then
                return true
            end
        end
    end
    return false
end

function ability.npc_stunned(spell, npc)
    local bufftime = 0
    for _, bufflist in pairs(
        {
            "modifier_bashed",
            "modifier_sheepstick_debuff",
            "modifier_stunned",
            "modifier_alchemist_unstable_concoction",
            "modifier_ancientapparition_coldfeet_freeze",
            "modifier_axe_berserkers_call",
            "modifier_bane_fiends_grip",
            "modifier_earthshaker_fissure_stun",
            "modifier_earth_spirit_boulder_smash",
            "modifier_enigma_black_hole_pull",
            "modifier_faceless_void_chronosphere_freeze",
            "modifier_jakiro_ice_path_stun",
            "modifier_keeper_of_the_light_mana_leak_stun",
            "modifier_kunkka_torrent",
            "modifier_legion_commander_duel",
            "modifier_lion_impale",
            "modifier_lion_voodoo",
            "modifier_magnataur_reverse_polarity",
            "modifier_medusa_stone_gaze_stone",
            "modifier_nyx_assassin_impale",
            "modifier_pudge_dismember",
            "modifier_rattletrap_hookshot",
            "modifier_rubick_telekinesis",
            "modifier_sandking_impale",
            "modifier_shadow_shaman_voodoo",
            "modifier_shadow_shaman_shackles",
            "modifier_techies_stasis_trap_stunned",
            "modifier_tidehunter_ravage",
            "modifier_windrunner_shackle_shot",
            "modifier_lone_druid_spirit_bear_entangle_effect",
            "modifier_storm_spirit_electric_vortex_pull",
            "modifier_visage_summon_familiars_stone_form_buff",
            "modifier_void_spirit_aether_remnant_pull",
            "modifier_hoodwink_bushwhack_trap",
            "modifier_terrorblade_fear"
        }
    ) do
        local buff = NPC.GetModifier(npc, bufflist)
        if buff then
            bufftime = Modifier.GetDieTime(buff)
        end
    end
    if Ability.GetDispellableType(spell) == 1 and bufftime > 0 and bufftime - GameRules.GetGameTime() > 0.35 then return false else return true end
end

function ability.get_distance(spell, npc)
    for _, lib in pairs(
        {
            {name = "ancient_apparition_ice_blast", radius = 99999},
            {name = "ancient_apparition_ice_blast_release", radius = 99999},
            {name = "antimage_counterspell", radius = 1000},
            {name = "arc_warden_tempest_double", radius = 900},
            {name = "alchemist_chemical_rage", radius = 1000},
            {name = "batrider_firefly", radius = 550},
            {name = "brewmaster_thunder_clap", radius = 400},
            {name = "brewmaster_drunken_brawler", radius = 99999},
            {name = "brewmaster_primal_split", radius = 550},
            {name = "bristleback_quill_spray", radius = 650},
            {name = "bloodseeker_bloodrage", radius = 99999},
            {name = "broodmother_insatiable_hunger", radius = 550},
            {name = "centaur_hoof_stomp", radius = 315},
            {name = "centaur_stampede", radius = 99999},
            {name = "chaos_knight_phantasm", radius = 2000},
            {name = "chen_hand_of_god", radius = 99999},
            {name = "clinkz_strafe", radius = 1000},
            {name = "clinkz_wind_walk", radius = 2000},
            {name = "crystal_maiden_freezing_field", radius = 600},
            {name = "dark_willow_shadow_realm", radius = 1150},
            {name = "dark_willow_bedlam", radius = 300},
            {name = "death_prophet_exorcism", radius = 700},
          --  {name = "doom_bringer_scorched_earth", radius = 600},
            {name = "dragon_knight_elder_dragon_form", radius = 550},
            {name = "dragon_knight_fireball", radius = 600},
            {name = "drow_ranger_trueshot", radius = 99999},
            {name = "drow_ranger_multishot", radius = 1000},
            {name = "ember_spirit_searing_chains", radius = 400},
            {name = "ember_spirit_flame_guard", radius = 400},
            {name = "earthshaker_enchant_totem", radius = 950},
            {name = "earthshaker_echo_slam", radius = 600},
            {name = "enchantress_natures_attendants", radius = 1000},
            {name = "furion_wrath_of_nature", radius = 99999},
            {name = "gyrocopter_rocket_barrage", radius = 400},
            {name = "gyrocopter_flak_cannon", radius = 1250},
            {name = "huskar_inner_fire", radius = 500},
            {name = "invoker_forge_spirit", radius = 1200},
            {name = "invoker_ice_wall", radius = 700},
            {name = "invoker_sun_strike", radius = 99999},
            {name = "juggernaut_blade_fury", radius = 1200},
            {name = "juggernaut_healing_ward", radius = 99999},
            {name = "leshrac_diabolic_edict", radius = 500},
            {name = "leshrac_pulse_nova", radius = 99999},
            {name = "life_stealer_rage", radius = 1000},
            {name = "lone_druid_spirit_bear", radius = 99999},
            {name = "lone_druid_spirit_link", radius = 550},
            {name = "lone_druid_savage_roar", radius = 325},
            {name = "lone_druid_true_form", radius = 550},
            {name = "lycan_summon_wolves", radius = 1000},
            {name = "lycan_howl", radius = 3000},
            {name = "lycan_shapeshift", radius = 550},
            {name = "magnataur_empower", radius = 99999},
            {name = "magnataur_reverse_polarity", radius = 410},
            {name = "magnataur_horn_toss", radius = 325},
            {name = "mars_spear", radius = 1000},
            {name = "mars_gods_rebuke", radius = 500},
            {name = "meepo_poof", radius = 99999},
            {name = "mirana_starfall", radius = 650},
            {name = "mirana_invis", radius = 99999},
            {name = "monkey_king_primal_spring", radius = 1000},
            {name = "monkey_king_mischief", radius = 1000},
            {name = "naga_siren_mirror_image", radius = 1000},
            {name = "nevermore_shadowraze1", radius = 450},
            {name = "nevermore_shadowraze2", radius = 700},
            {name = "nevermore_shadowraze3", radius = 950},
            {name = "nevermore_requiem", radius = 450},
            {name = "naga_siren_song_of_the_siren", radius = 1000},
            {name = "necrolyte_death_pulse", radius = 500},
            {name = "night_stalker_crippling_fear", radius = 375},
            {name = "nyx_assassin_spiked_carapace", radius = 550},
            {name = "nyx_assassin_vendetta", radius = 99999},
            {name = "obsidian_destroyer_equilibrium", radius = 550},
            {name = "omniknight_guardian_angel", radius = 1200},
            {name = "pangolier_swashbuckle", radius = 2000},
            {name = "pangolier_shield_crash", radius = 500},
            {name = "pangolier_gyroshell", radius = 660},
            {name = "pangolier_gyroshell_stop", radius = 99999},
            {name = "phoenix_icarus_dive", radius = 1400},
            {name = "phoenix_supernova", radius = 1300},
            {name = "pugna_nether_ward", radius = 1600},
            {name = "pudge_rot", radius = 1200},
            {name = "puck_waning_rift", radius = 600},
            {name = "puck_phase_shift", radius = 900},
            {name = "queenofpain_scream_of_pain", radius = 550},
            {name = "rattletrap_battery_assault", radius = 275},
            {name = "rattletrap_power_cogs", radius = 215},
            {name = "rattletrap_rocket_flare", radius = 99999},
            {name = "razor_plasma_field", radius = 700},
            {name = "razor_eye_of_the_storm", radius = 550},
            {name = "riki_tricks_of_the_trade", radius = 450},
            {name = "sandking_sand_storm", radius = 650},
            {name = "sandking_epicenter", radius = 550},
            {name = "shredder_whirling_death", radius = 300},
            {name = "shredder_return_chakram", radius = 99999},
            {name = "shredder_return_chakram_2", radius = 99999},
            {name = "silencer_global_silence", radius = 99999},
            {name = "slardar_slithereen_crush", radius = 350},
            {name = "slardar_sprint", radius = 320},
            {name = "slark_dark_pact", radius = 325},
            {name = "slark_shadow_dance", radius = 550},
            {name = "sniper_take_aim", radius = 99999},
            {name = "spectre_haunt", radius = 99999},
            {name = "spirit_breaker_bulldoze", radius = 3000},
            {name = "storm_spirit_static_remnant", radius = 260},
            {name = "storm_spirit_electric_vortex", radius = 475},
            {name = "sven_warcry", radius = 550},
            {name = "sven_gods_strength", radius = 550},
            {name = "templar_assassin_refraction", radius = 550},
            {name = "templar_assassin_meld", radius = 550},
            {name = "terrorblade_reflection", radius = 900},
            {name = "terrorblade_conjure_image", radius = 550},
            --{name = "terrorblade_metamorphosis", radius = 550},
            {name = "terrorblade_terror_wave", radius = 600},
            {name = "tidehunter_anchor_smash", radius = 375},
            {name = "tidehunter_ravage", radius = 550},
            {name = "tinker_heat_seeking_missile", radius = 2500},
            {name = "tinker_keen_teleport", radius = 99999},
            {name = "tinker_rearm", radius = 99999},
            {name = "treant_living_armor", radius = 99999},
            {name = "treant_overgrowth", radius = 800},
            {name = "troll_warlord_whirling_axes_melee", radius = 450},
            {name = "tusk_tag_team", radius = 350},
            {name = "tusk_walrus_punch", radius = 550},
            {name = "undying_flesh_golem", radius = 700},
            {name = "ursa_earthshock", radius = 385},
            {name = "ursa_overpower", radius = 550},
            {name = "ursa_enrage", radius = 550},
            {name = "venomancer_poison_nova", radius = 830},
            {name = "visage_summon_familiars", radius = 99999},
            {name = "morphling_morph_replicate", radius = 99999},
            {name = "weaver_time_lapse", radius = 1200},
            {name = "windrunner_windrun", radius = 1000},
            {name = "weaver_shukuchi", radius = 2000},
            {name = "wisp_spirits", radius = 700},
            {name = "wisp_overcharge", radius = 550},
            {name = "zuus_cloud", radius = 99999},
            {name = "zuus_thundergods_wrath", radius = 99999},
            {name = "void_spirit_aether_remnant", radius = 1450},
            {name = "void_spirit_resonant_pulse", radius = 485},
            {name = "void_spirit_dissimilate", radius = 750},
            {name = "void_spirit_astral_step", radius = 1100},
            {name = "snapfire_firesnap_cookie", radius = 1300},
            {name = "snapfire_mortimer_kisses", radius = 3000},
            {name = "snapfire_gobble_up", radius = 3000},
            {name = "hoodwink_decoy", radius = 2000},
            {name = "elder_titan_echo_stomp", radius = 2000},
            {name = "windrunner_gale_force", radius = 2000},
            {name = "rubick_telekinesis_land", radius = 2000},
            {name = "wisp_spirits_in", radius = 2000},
            {name = "wisp_spirits_out", radius = 2000},
            {name = "kunkka_return", radius = 2000},
            {name = "kunkka_torrent_storm", radius = 2000},
            {name = "phoenix_icarus_dive_stop", radius = 99999},
            {name = "phoenix_sun_ray_toggle_move", radius = 99999},
            {name = "storm_spirit_overload", radius = 1000},
            {name = "storm_spirit_ball_lightning", radius = 2000},
            {name = "meepo_petrify", radius = 2000},
            {name = "meepo_divided_we_stand", radius = 900},
            {name = "leshrac_greater_lightning_storm", radius = 450},
            {name = "snapfire_spit_creep", radius = 3000},
            {name = "spirit_breaker_charge_of_darkness", radius = 99999},
            {name = "earth_spirit_boulder_smash", radius = 2000},
            {name = "earth_spirit_geomagnetic_grip", radius = 2000},
            {name = "earth_spirit_stone_caller", radius = 2000},
            {name = "mars_arena_of_blood", radius = 700},
            {name = "grimstroke_spirit_walk", radius = 2000},
            {name = "puck_ethereal_jaunt", radius = 2000},
            {name = "keeper_of_the_light_recall", radius = 99999},
            {name = "troll_warlord_berserkers_rage", radius = 1000},
            {name = "troll_warlord_rampage", radius = 2000},
            {name = "faceless_void_time_dilation", radius = 775},
            {name = "monkey_king_wukongs_command", radius = 550},
            {name = "spectre_reality", radius = 99999},
            {name = "antimage_mana_overload", radius = 1400},
            {name = "beastmaster_call_of_the_wild_boar", radius = 550},
            {name = "zuus_static_field", radius = 2000},
            {name = "dawnbreaker_fire_wreath", radius = 360},
            {name = "dawnbreaker_converge", radius = 2400},
            {name = "spectre_haunt_single", radius = 99999},
            --{name = "dawnbreaker_solar_guardian", radius = 99999},
            {name = "phantom_assassin_fan_of_knives", radius = 550},
            {name = "primal_beast_onslaught", radius = 2000},
            {name = "primal_beast_trample", radius = 230},
            {name = "techies_reactive_tazer", radius = 900},
            {name = "dazzle_good_juju", radius = 900},
            {name = "skeleton_king_vampiric_aura", radius = 300},
            {name = "medusa_stone_gaze", radius = 600},
            {name = "visage_summon_familiars_stone_form", radius = 350},
            {name = "shadow_demon_shadow_poison_release", radius = 99999},
            {name = "tusk_launch_snowball", radius = 99999},
            {name = "hoodwink_scurry", radius = 2000},
            {name = "bloodseeker_blood_mist", radius = 1200},
            {name = "visage_gravekeepers_cloak", radius = 1200},
            {name = "primal_beast_uproar", radius = NPC.GetAttackRange(npc)},
            {name = "legion_commander_press_the_attack", radius = 1200},
            {name = "weaver_geminate_attack", radius = NPC.GetAttackRange(npc)},
            {name = "terrorblade_demon_zeal", radius = NPC.GetAttackRange(npc)},
            {name = "phantom_lancer_juxtapose", radius = NPC.GetAttackRange(npc)},
            {name = "marci_unleash", radius = NPC.GetAttackRange(npc)},
            {name = "winter_wyvern_arctic_burn", radius = NPC.GetAttackRange(npc)},
            {name = "arc_warden_magnetic_field", radius = NPC.GetAttackRange(npc)},
            {name = "hoodwink_acorn_shot", radius = Ability.GetCastRange(spell) + NPC.GetAttackRange(npc)},
            {name = "magnataur_skewer", radius = Ability.GetLevelSpecialValueFor(spell, "range")},
            {name = "antimage_blink", radius = Ability.GetLevelSpecialValueFor(spell, "blink_range")},
            {name = "queenofpain_blink", radius = Ability.GetLevelSpecialValueFor(spell, "blink_range")},
            --scepter
            {name = "night_stalker_void", new_radius = 900, upgrade = "scepter"},
            {name = "tidehunter_gush", new_radius = 2200, upgrade = "scepter"},
            {name = "ember_spirit_fire_remnant", new_radius = 3000, upgrade = "scepter"},
            {name = "sandking_burrowstrike", new_radius = 1300, upgrade = "scepter"},
            {name = "slark_pounce", radius = 700, new_radius = 1200, upgrade = "scepter"},
            {name = "luna_eclipse", radius = 675, new_radius = 2500, upgrade = "scepter"},
            {name = "viper_viper_strike", new_radius = Ability.GetCastRange(spell) + 900, upgrade = "scepter"},
            --shard
            {name = "vengefulspirit_magic_missile", new_radius = Ability.GetCastRange(spell) + 100, upgrade = "shard"},
            {name = "faceless_void_time_walk", radius = Ability.GetLevelSpecialValueFor(spell, "range"), new_radius = Ability.GetLevelSpecialValueFor(spell, "range") + 400, upgrade = "shard"},
            --talent_name
            {name = "axe_berserkers_call", radius = 300, new_radius = 400, talent_name = "special_bonus_unique_axe_2"},
            {name = "marci_companion_run", new_radius = 2125, talent_name = "special_bonus_unique_marci_lunge_range"},
            {name = "lion_impale", new_radius = Ability.GetCastRange(spell) + 800, talent_name = "special_bonus_unique_lion_2"},
            {name = "lion_voodoo", new_radius = Ability.GetCastRange(spell) + 150, talent_name = "special_bonus_unique_lion_4"},
            {name = "puck_illusory_orb", radius = 1950, new_radius = 2250, talent_name = "special_bonus_unique_puck"},
            {name = "puck_waning_rift", radius = 700, new_radius = 1200, talent_name = "special_bonus_unique_puck_6"},
            {name = "arc_warden_flux", radius = Ability.GetLevelSpecialValueFor(spell, "abilitycastrange"), new_radius = Ability.GetLevelSpecialValueFor(spell, "abilitycastrange") + 175, talent_name = "special_bonus_unique_arc_warden_5"},
            {name = "phoenix_icarus_dive", radius = Ability.GetLevelSpecialValueFor(spell, "dash_length"), new_radius = Ability.GetLevelSpecialValueFor(spell, "dash_length") + 1000, talent_name = "special_bonus_unique_phoenix_4"},
            {name = "dawnbreaker_celestial_hammer", radius = Ability.GetLevelSpecialValueFor(spell, "range"), new_radius = Ability.GetLevelSpecialValueFor(spell, "range") + 1000, talent_name = "special_bonus_unique_dawnbreaker_celestial_hammer_cast_range"},
            --items
            {name = "item_phase_boots", radius = 2000},
            {name = "item_refresher", radius = 2000},
            {name = "item_refresher_shard", radius = 2000},
            {name = "item_magic_wand", radius = 2000},
            {name = "item_magic_stick", radius = 2000},
            {name = "item_smoke_of_deceit", radius = 1200},
            {name = "item_dust", radius = 1050},
            {name = "item_faerie_fire", radius = 1000},
            {name = "item_enchanted_mango", radius = 1000},
            {name = "item_bottle", radius = 2000},
            {name = "item_manta", radius = 1000},
            {name = "item_ghost", radius = 1000},
            {name = "item_stormcrafter", radius = 1000},
            {name = "item_essence_ring", radius = 1000},
            {name = "item_trickster_cloak", radius = 1000},
            {name = "item_black_king_bar", radius = 1000},
            {name = "item_radiance", radius = 1000},
            {name = "item_armlet", radius = 1000},
            {name = "item_blade_mail", radius = 1000},
            {name = "item_power_treads", radius = 1000},
            {name = "item_soul_ring", radius = 2500},
            {name = "item_mask_of_madness", radius = 2000},
            {name = "item_silver_edge", radius = 2000},
            {name = "item_invis_sword", radius = 2000},
            {name = "item_demonicon", radius = 1000},
            {name = "item_spider_legs", radius = 1000},
            {name = "item_mjollnir", radius = 1000},
            {name = "item_shivas_guard", radius = 650},
            {name = "item_ex_machina", radius = 1000},
            {name = "item_force_field", radius = 1000},
            {name = "item_revenants_brooch", radius = 1000},
            {name = "item_guardian_greaves", radius = 1000},
            {name = "item_boots_of_bearing", radius = 1000},
            {name = "item_glimmer_cape", radius = 1000},
            {name = "item_trickster_cloak", radius = 1000},
            {name = "item_seer_stone", radius = 99999}
        }
    ) do
        if lib then
            if Entity.IsAbility(spell) and Ability.GetName(spell) == lib.name then
                if lib.upgrade == "scepter" and (NPC.GetItem(npc, "item_ultimate_scepter") or NPC.HasModifier(npc, "modifier_item_ultimate_scepter_consumed")) then
                    return lib.new_radius
                elseif lib.upgrade == "shard" and NPC.HasModifier(npc, "modifier_item_aghanims_shard") then
                    return lib.new_radius
                elseif lib.talent_name ~= nil and NPC.GetAbility(npc, lib.talent_name) and Ability.GetLevel(NPC.GetAbility(npc, lib.talent_name)) > 0 then
                    return lib.new_radius
                elseif lib.radius ~= nil then
                    return lib.radius
                end
            end
        end
    end
    return Ability.GetCastRange(spell)
end

function ability.OnStartSound(sound)
    if sound.source and sound.source ~= Heroes.GetLocal() then
        if sound.name == "Hero_EmberSpirit.FireRemnant.Cast" then
            ability.calling["npc_dota_hero_ember_spirit"]  = "ember_spirit_fire_remnant"
        elseif sound.name == "Hero_VoidSpirit.AetherRemnant.Cast" then
            ability.calling["npc_dota_hero_void_spirit"] = "void_spirit_aether_remnant"
        elseif sound.name == "Hero_VoidSpirit.Pulse.Cast" then
            ability.calling["npc_dota_hero_void_spirit"] = "void_spirit_resonant_pulse"
        elseif sound.name == "Hero_VoidSpirit.AstralStep.Start" then
            ability.calling["npc_dota_hero_void_spirit"] = "void_spirit_astral_step"
        elseif sound.name == "Hero_Tinker.Rearm" then
            ability.calling["npc_dota_hero_tinker"] = "tinker_rearm"
        elseif sound.name == "Hero_Phoenix.SuperNova.Explode" then
            ability.calling["npc_dota_hero_phoenix"] = "phoenix_supernova"
        elseif sound.name == "Hero_Sniper.ShrapnelShatter" then
            ability.calling["npc_dota_hero_sniper"] = "sniper_shrapnel"
        elseif sound.name == "Hero_NyxAssassin.Vendetta" then
            ability.calling["npc_dota_hero_nyx_assassin"] = "nyx_assassin_vendetta"
        elseif sound.name == "Hero_Ancient_Apparition.IceBlast.Target" then
            ability.calling["npc_dota_hero_ancient_apparition"] = "ancient_apparition_ice_blast"
        elseif sound.name == "Hero_StormSpirit.BallLightning" then
            ability.calling["npc_dota_hero_storm_spirit"] = "storm_spirit_ball_lightning"
        elseif sound.name == "Hero_Wisp.Spirits.Cast" then
            ability.calling["npc_dota_hero_wisp"] = "wisp_spirits_in"
        elseif sound.name == "Hero_Brewmaster.PrimalSplit.Spawn" then
            ability.calling["npc_dota_hero_brewmaster"] = "brewmaster_primal_split"
        elseif sound.name == "Hero_Morphling.Waveform" then
            ability.calling["npc_dota_hero_morphling"] = "morphling_waveform"
        elseif sound.name == "Hero_Hoodwink.AcornShot.Cast" then
            ability.calling["npc_dota_hero_hoodwink"] = "hoodwink_acorn_shot"
        elseif sound.name == "Hero_Hoodwink.Scurry.Cast" then
            ability.calling["npc_dota_hero_hoodwink"] = "hoodwink_scurry"
        elseif sound.name == "Hero_Phoenix.FireSpirits.Launch" then
            ability.calling["npc_dota_hero_phoenix"] = "phoenix_launch_fire_spirit"
        end
    end
end

function ability.OnParticleCreate(particle)
    if particle.name == "brewmaster_drunken_stance_earth" then
        ability.calling[NPC.GetUnitName(particle.entity)] = "stance_earth"
    elseif particle.name == "brewmaster_drunken_stance_fire" then
        ability.calling[NPC.GetUnitName(particle.entity)] = "stance_fire"
    elseif particle.name == "brewmaster_drunken_stance_storm" then
        ability.calling[NPC.GetUnitName(particle.entity)] = "stance_storm"
    elseif particle.name == "brewmaster_drunken_stance_void" then
        ability.calling[NPC.GetUnitName(particle.entity)] = "stance_void"
    elseif particle.name == "weaver_shukuchi_damage" then
        ability.calling[NPC.GetUnitName(particle.entity)] = "damaged"
    end
end

return ability
