
--- 测试数据
module(..., package.seeall)

local data = {}
local d = {}

----------------------------------- 模拟关卡数据 --------------------------
data.current_ly_id = 1 -- 关卡层级
data.current_lv_id = 1 -- 关卡id

d.level_config = {
	layer_1 = {
		normal_level = {
			level_1 = {state = 1,star = 0},
			level_2 = {state = 0,star = 0},
			level_3 = {state = 0,star = 0},
			level_4 = {state = 0,star = 0},
			level_5 = {state = 0,star = 0},
			level_6 = {state = 0,star = 0},
			level_7 = {state = 0,star = 0},
			level_8 = {state = 0,star = 0},
			level_9 = {state = 0,star = 0},
			level_10 = {state = 0,star = 0},
			level_11 = {state = 0,star = 0},
			level_12 = {state = 0,star = 0},
			level_13 = {state = 0,star = 0},
			level_14 = {state = 0,star = 0},
			level_15 = {state = 0,star = 0}
			},
		boss_level = {
			level_1 = {state = 0,star = 0}
		}
	},
	layer_2 = {
		normal_level = {
			level_1 = {state = 0,star = 0},
			level_2 = {state = 0,star = 0},
			level_3 = {state = 0,star = 0},
			level_4 = {state = 0,star = 0},
			level_5 = {state = 0,star = 0},
			level_6 = {state = 0,star = 0},
			level_7 = {state = 0,star = 0},
			level_8 = {state = 0,star = 0},
			level_9 = {state = 0,star = 0},
			level_10 = {state = 0,star = 0},
			level_11 = {state = 0,star = 0},
			level_12 = {state = 0,star = 0},
			level_13 = {state = 0,star = 0},
			level_14 = {state = 0,star = 0},
			level_15 = {state = 0,star = 0}
			},
		boss_level = {
			level_1 = {state = 0,star = 0}
		}
	},
	layer_3 = {
		normal_level = {
			level_1 = {state = 0,star = 0},
			level_2 = {state = 0,star = 0},
			level_3 = {state = 0,star = 0},
			level_4 = {state = 0,star = 0},
			level_5 = {state = 0,star = 0},
			level_6 = {state = 0,star = 0},
			level_7 = {state = 0,star = 0},
			level_8 = {state = 0,star = 0},
			level_9 = {state = 0,star = 0},
			level_10 = {state = 0,star = 0},
			level_11 = {state = 0,star = 0},
			level_12 = {state = 0,star = 0},
			level_13 = {state = 0,star = 0},
			level_14 = {state = 0,star = 0},
			level_15 = {state = 0,star = 0}
			},
		boss_level = {
			level_1 = {state = 0,star = 0}
		}
	},
	layer_4 = {
		normal_level = {
			level_1 = {state = 0,star = 0},
			level_2 = {state = 0,star = 0},
			level_3 = {state = 0,star = 0},
			level_4 = {state = 0,star = 0},
			level_5 = {state = 0,star = 0},
			level_6 = {state = 0,star = 0},
			level_7 = {state = 0,star = 0},
			level_8 = {state = 0,star = 0},
			level_9 = {state = 0,star = 0},
			level_10 = {state = 0,star = 0},
			level_11 = {state = 0,star = 0},
			level_12 = {state = 0,star = 0},
			level_13 = {state = 0,star = 0},
			level_14 = {state = 0,star = 0},
			level_15 = {state = 0,star = 0}
			},
		boss_level = {
			level_1 = {state = 0,star = 0}
		}
	}
	-- layer_5 = {},
	-- layer_6 = {},
	-- layer_7 = {},
	-- layer_8 = {},
	-- layer_9 = {},
	-- layer_10 = {},
	-- layer_11 = {}
}

function data.get_level_config()
	return d.level_config
end

function data.level_config(key)
	return d.level_config[tostring(key)]
end

function data.level_config(key)
	local s = d.level_config[tostring(key)]
	if s then
		return s
	else
		d.level_config[tostring(key)] = {state = 0,star = 0}
	end
	local s = d.level_config[tostring(key)]
	return s
end

return data