minetest.clear_craft({ output = "screwdriver2:screwdriver" })

local groups = minetest.registered_items["screwdriver2:screwdriver"].groups
groups.not_in_creative_inventory = 1

minetest.override_item("screwdriver2:screwdriver", {
	groups = groups,
})

minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
	if puncher and puncher:is_player() then
		if puncher:get_wielded_item():get_name() == "" then
			local key = puncher:get_player_control()
            if key.left and key.right then
                screwdriver.use(itemstack, puncher, pointed_thing, false)
                return false
            end
		end
	end
end)

local old_on_place = minetest.registered_items[""].on_place

minetest.override_item("", {
	on_place = function(itemstack, placer, pointed_thing)
		local key = placer:get_player_control()
		if key.left and key.right then
			screwdriver.use(itemstack, placer, pointed_thing, true)
		else
			return old_on_place(itemstack, placer, pointed_thing)
		end
	end,
})
