-- To play laser sword sounds, set this to true.
-- To disable sounds, set it to anything else.
local use_sound = true



local players = {}

minetest.register_on_joinplayer(function(player)
	player_name = player:get_player_name()
	players[player_name] = {soundToggle = 0}
end)

minetest.register_on_leaveplayer(function(player)
	player_name = player:get_player_name()
	players[player_name] = nil
end)

-- sound handle
local handle

if use_sound == true then
	minetest.register_globalstep(function(dtime)
		--Loop through all connected players
		for player_name,player_info in pairs(players) do
			local player = minetest.get_player_by_name(player_name)
			if player ~= nil then
				-- if user is wielding laser_mod weapon
				if string.find(player:get_wielded_item():get_name(), "laser_mod") then
					-- if user is pressing left mouse button
					if player:get_player_control()["LMB"] == true then
						if players[player_name]["soundToggle"] == 0 then
							players[player_name]["soundToggle"] = 1
							local player_pos = player:getpos()
							-- play sound at player's location so others nearby can hear
							handle = minetest.sound_play("laser_mod", {pos = player_pos})
							-- stop sound after 0.4 seconds
							minetest.after(0.4, function()
								minetest.sound_stop(handle)
								if players[player_name] then
								    players[player_name]["soundToggle"] = 0
								end
							end)
						end
					end
				end
			end
		end
	end)
end
			


-- tool capabilities
local tc = {
	full_punch_interval = 3.0,
	max_drop_level=1,
	groupcaps={
		cracky={times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=15, maxlevel=3},
		crumbly={times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=15, maxlevel=3},
		choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=15, maxlevel=3},
		snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=15, maxlevel=3}
	},
	damage_groups = {fleshy=8},
}

minetest.register_tool("laser_mod:red_sword", {
	description = "Red Laser Sword",
	inventory_image = "red_sword.png",
	tool_capabilities = tc
})

minetest.register_tool("laser_mod:green_sword", {
	description = "Green Laser Sword",
	inventory_image = "green_sword.png",
	tool_capabilities = tc
})

minetest.register_tool("laser_mod:blue_sword", {
	description = "Blue Laser Sword",
	inventory_image = "blue_sword.png",
	tool_capabilities = tc
})

minetest.register_tool("laser_mod:yellow_sword", {
	description = "Yellow Laser Sword",
	inventory_image = "yellow_sword.png",
	tool_capabilities = tc
})

minetest.register_craft({
	output = 'laser_mod:red_sword',
	recipe = {
		{'default:glass'},
		{'dye:red'},
		{'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'laser_mod:green_sword',
	recipe = {
		{'default:glass'},
		{'dye:green'},
		{'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'laser_mod:blue_sword',
	recipe = {
		{'default:glass'},
		{'dye:blue'},
		{'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'laser_mod:yellow_sword',
	recipe = {
		{'default:glass'},
		{'dye:yellow'},
		{'default:mese_crystal'},
	}
})

