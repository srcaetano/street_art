img_folder = '../imgs/'
img_ext = '.png'

dofile("tree.lua")
dofile("menu_buttons.lua")
dofile("luasocket_get_website.lua")
dofile("html_parsing.lua")

run_menu = false
level_data  = {}
steps = 0
dx = 0
dy = 0

internet_connection_available = true
is_moving = false

fullW = 1280
fullH = 720

crumb_xs = fullW*6/100
crumb_ys = fullH*20/100
crumbW   = fullW*18/100
crumbH   = fullH*73/100

info_xs = fullW*90/100-crumbW
info_ys = fullH*75/100
infoW   = crumbW
infoH   = crumbH

button_xs = info_xs*1.05
button_ys = info_ys

lua_xs = crumb_xs+crumbW --330
lua_ys = crumb_ys
luaW   = info_xs-lua_xs
luaH   = crumbH

t_ms    = 20

canvas_orientation = "VERTICAL"
--canvas_orientation = "HORIZONTAL"


local background_img = canvas:new(img_folder .. '4_Fundo_1280x720' .. img_ext)

function clear_canvas(x, y, W, H)
	canvas:attrClip(x,y,W,H)
	canvas:attrColor(0,0,0,0)
	canvas:clear(x,y,W,H)
end

function reset_canvas(x, y, W, H)
	clear_canvas(x,y,W,H)
	canvas:compose(0, 0, background_img) --canvas:new(img_folder .. '4_Fundo_1280x720' .. img_ext))
	canvas:attrClip(lua_xs, lua_ys, luaW, luaH)
end

function draw_canvas(cur_level_data)
	if canvas_orientation == "HORIZONTAL" then
		local cur_y = cur_level_data.y
		for i=1,#cur_level_data.branches do 
			if cur_y + cur_level_data.branches[i].H > 0 and cur_y < cur_level_data.H then
				if cur_level_data.branches[i].media_type=='img' then
					if i==cur_level_data.focus then
						canvas:compose(cur_level_data.x-cur_level_data.branches[i].W/2 + lua_xs,
							cur_y + lua_ys, cur_level_data.branches[i].img_ysel)
					else
						canvas:compose(cur_level_data.x-cur_level_data.branches[i].W/2 + lua_xs,
							cur_y + lua_ys, cur_level_data.branches[i].img_nsel)
					end
				elseif cur_level_data.branches[i].media_type=='txt' then
					if i==cur_level_data.focus then
						canvas:compose(cur_level_data.x-cur_level_data.branches[i].W/2 + lua_xs, cur_y + lua_ys,
							cur_level_data.branches[i].cur_canvas_focus)
					else
						canvas:compose(cur_level_data.x-cur_level_data.branches[i].W/2 + lua_xs, cur_y + lua_ys,
							cur_level_data.branches[i].cur_canvas_no_focus)
					end
				elseif cur_level_data.branches[i].media_type=='qrcode' then
					canvas:compose(cur_level_data.x-cur_level_data.branches[i].W/2 + lua_xs, cur_y + lua_ys,
							cur_level_data.branches[i].cur_canvas)
				end
			end
			cur_y = cur_y+cur_level_data.branches[i].H+cur_level_data.y_gap
		end
		canvas:attrClip(0, 0, fullW, fullH)
		--lua_xs = lua_xs + luaW + 1
		--canvas:attrColor(0,0,0,0)
		--canvas:drawRect('fill',lua_xs,cur_level_data.H-140+lua_ys,200,200)
		
		canvas:compose(button_xs, button_ys,  cur_level_data.arrow_back)
		if cur_level_data.focus>1 then
			--canvas:compose(49+button_xs, button_ys-140,  cur_level_data.arrow_up)
			canvas:compose(button_xs, button_ys, cur_level_data.arrow_up)
		end
		if cur_level_data.focus<(#cur_level_data.branches) then
			--canvas:compose(49+button_xs, button_ys-56, cur_level_data.arrow_down)
			canvas:compose(button_xs, button_ys, cur_level_data.arrow_down)
		end
		if cur_level_data.level>1 then
			--canvas:compose(1+button_xs, button_ys-90,  cur_level_data.arrow_left)
			canvas:compose(button_xs, button_ys, cur_level_data.arrow_left)
		end
		if cur_level_data.has_branches then
			--canvas:compose(81+button_xs, button_ys-90, cur_level_data.arrow_right)
			canvas:compose(button_xs, button_ys, cur_level_data.arrow_right)
		end
		--lua_xs = lua_xs - luaW - 1
		canvas:attrClip(lua_xs, lua_ys, luaW, luaH)
		canvas:flush()
	end
	if canvas_orientation == "VERTICAL" then
		local cur_x = cur_level_data.x
		for i=1,#cur_level_data.branches do 
			if cur_x + cur_level_data.branches[i].W > 0 and cur_x < cur_level_data.W then
				if cur_level_data.branches[i].media_type=='img' then
					if i==cur_level_data.focus then
						canvas:compose(cur_x + lua_xs,
							cur_level_data.y-cur_level_data.branches[i].H/2 + lua_ys,
							cur_level_data.branches[i].img_ysel)
					else
						canvas:compose(cur_x + lua_xs,
							cur_level_data.y-cur_level_data.branches[i].H/2 + lua_ys,
							cur_level_data.branches[i].img_nsel)
					end
				elseif cur_level_data.branches[i].media_type=='txt' then
					if i==cur_level_data.focus then
						canvas:compose(cur_x + lua_xs,
							cur_level_data.y-cur_level_data.branches[i].H/2 + lua_ys,
							cur_level_data.branches[i].cur_canvas_focus)
					else
						canvas:compose(cur_x + lua_xs,
							cur_level_data.y-cur_level_data.branches[i].H/2 + lua_ys,
							cur_level_data.branches[i].cur_canvas_no_focus)
					end
				elseif cur_level_data.branches[i].media_type=='qrcode' then
					canvas:compose(cur_x + lua_xs,
							cur_level_data.y-cur_level_data.branches[i].H/2 + lua_ys,
							cur_level_data.branches[i].cur_canvas)
				end
			end
			cur_x = cur_x+cur_level_data.branches[i].W+cur_level_data.x_gap
		end
		canvas:attrClip(0, 0, fullW, fullH)
		canvas:compose(button_xs, button_ys,  cur_level_data.arrow_back)
		if cur_level_data.focus>1 then
			canvas:compose(button_xs, button_ys, cur_level_data.arrow_left)
		end
		if cur_level_data.focus<(#cur_level_data.branches) then
			canvas:compose(button_xs, button_ys, cur_level_data.arrow_right)
		end
		if cur_level_data.level>1 then
			canvas:compose(button_xs, button_ys, cur_level_data.arrow_down)
		end
		if cur_level_data.has_branches then
			canvas:compose(button_xs, button_ys, cur_level_data.arrow_up)
		end
		canvas:attrClip(lua_xs, lua_ys, luaW, luaH)
		canvas:flush()
	end
end

function draw_breadcrumb(cur_level_data)
	if cur_level_data.img_crumb == 'no_crumb' then
		reset_canvas(0,0,fullW,fullH)
		return
	end
	canvas:attrClip(0, 0, fullW, fullH)
	canvas:compose(crumb_xs+(crumbW-cur_level_data.crumbW)/2,
					crumb_ys+(crumbH-cur_level_data.crumbH)/2,
					cur_level_data.crumb_canvas)
	canvas:attrClip(lua_xs, lua_ys, luaW, luaH)
	canvas:flush()
end

function animate_canvas(cur_level_data, anim_dir)
	local max_d, max_s = {0,0}
	
	if anim_dir=="DOWN" or anim_dir=="UP" then
		max_d = 11
		max_s = 10
		--local total_y = cur_level_data.branches[cur_level_data.focus].H+cur_level_data.y_gap
		local total_y = 0
		if canvas_orientation == "HORIZONTAL" then
			if anim_dir=="UP" then total_y = cur_level_data.branches[cur_level_data.focus-1].H+cur_level_data.y_gap
			else total_y = cur_level_data.branches[cur_level_data.focus].H+cur_level_data.y_gap end
		end
		if canvas_orientation == "VERTICAL" then
			for j = 1,#(cur_level_data.branches) do
				total_y = math.max(total_y,cur_level_data.branches[j].H+cur_level_data.y_gap)
			end
		end
		steps = 1
		dy = total_y/steps+0.5
		while math.floor(dy+0.5)>max_d and steps < max_s do
			steps = steps+1
			dy = total_y/steps+0.5
		end
		if anim_dir=="UP" then dy = -dy end
		level_data = cur_level_data
		is_moving = true
		animate_canvas_vertically()
	elseif anim_dir=="LEFT" or anim_dir=="RIGHT" then
		max_d = 11
		max_s = 14
		local total_x = 0
		if canvas_orientation == "HORIZONTAL" then
			for j = 1,#(cur_level_data.branches) do
				total_x = math.max(total_x,cur_level_data.branches[j].W+cur_level_data.x_gap)
			end
		end
		if canvas_orientation == "VERTICAL" then
			if anim_dir=="LEFT" then total_x = cur_level_data.branches[cur_level_data.focus-1].W+cur_level_data.x_gap
			else total_x = cur_level_data.branches[cur_level_data.focus].W+cur_level_data.x_gap end
		end
		--total_x = total_x + cur_level_data.x_gap
		steps = 1
		dx = total_x/steps+0.5
		while math.floor(dx+0.5)>max_d and steps < max_s do
			steps = steps+1
			dx = total_x/steps+0.5
		end
		if anim_dir=="LEFT" then dx = -dx end
		level_data = cur_level_data
		is_moving = true
		animate_canvas_horizontally()
	end
end

function animate_canvas_vertically()
	if steps>0 then
		steps = steps - 1
		level_data.y = level_data.y+dy
		reset_canvas(lua_xs, lua_ys, fullW, fullH)
		--clear_canvas(level_data.W, level_data.H)
		--draw_breadcrumb(level_data)
		draw_canvas(level_data)
		event.timer(t_ms,animate_canvas_vertically)
	else
		is_moving = false
		if canvas_orientation == "VERTICAL" then
			local tree_node = read_node(app_tree)
			tree_node.focus = level_data.focus
			if dy<0 then -- ANIMATION DOWN
				app_tree.level = app_tree.level+1
			else -- ANIMATION UP
				app_tree.level = app_tree.level-1
			end
			level_data = {}
			level_data = read_level_data(app_tree)
			reset_canvas(lua_xs, lua_ys, fullW, fullH)
			--clear_canvas(level_data.W, level_data.H)
			draw_breadcrumb(level_data)
			draw_canvas(level_data)
		end
	end
end

function animate_canvas_horizontally()
	if steps>0 then
		steps = steps - 1
		level_data.x = level_data.x+dx
		reset_canvas(lua_xs, lua_ys, fullW, fullH)
		--clear_canvas(level_data.W, level_data.H)
		--draw_breadcrumb(level_data)
		draw_canvas(level_data)
		event.timer(t_ms,animate_canvas_horizontally)
	else
		is_moving = false
		if canvas_orientation == "HORIZONTAL" then
			local tree_node = read_node(app_tree)
			tree_node.focus = level_data.focus
			if dx>0 then -- ANIMATION TO THE RIGHT
				app_tree.level = app_tree.level-1
			else -- ANIMATION TO THE LEFT
				app_tree.level = app_tree.level+1
			end
			level_data = {}
			level_data = read_level_data(app_tree)
			reset_canvas(lua_xs, lua_ys, fullW, fullH)
			--clear_canvas(level_data.W, level_data.H)
			draw_breadcrumb(level_data)
			draw_canvas(level_data)
		end
	end
end

function htmlCallback(header, body, htmlTableAnalysis)
	local search_tree = {}
	if body=='' then
		internet_connection_available = false
		search_tree = {create_node(':: No internet connection available','txt')}
	else
		local est_info = htmlToTable(body, htmlTableAnalysis.delims)
		for j = 1,#htmlTableAnalysis.prefix do
			local html_prefix = htmlTableAnalysis.prefix[j]
			tableValuePrefix(est_info, html_prefix.f_name, html_prefix.add)
		end
		for j = 1,#htmlTableAnalysis.suffix do
			local html_suffix = htmlTableAnalysis.suffix[j]
			tableValueSuffix(est_info, html_suffix.f_name, html_suffix.add)
		end
		for j = 1,#htmlTableAnalysis.subs do
			local html_subs = htmlTableAnalysis.subs[j]
			tableValueSubs(est_info, html_subs.f_name, html_subs.inputs, html_subs.outputs)
		end
		search_tree = tableToNodes(est_info,
									htmlTableAnalysis.node_ind, 
									htmlTableAnalysis.branch_ind,
									htmlTableAnalysis.sub_branch_ind,
									htmlTableAnalysis.sub_branch_type)
	end
	return search_tree
end

--function htmlProcessing(url)
--	return htmlCallback('',get_website(url),htmlOptions(url))
--	-- --http.request(htmlTableAnalysis.url, htmlCallback)
--	--header_body = get_website(htmlTableAnalysis.url)
--	--return htmlCallback('',header_body)
--end

function read_level_data(tree_data)
	local cur_level_data = {}
	local tree_node = {}
	
	tree_node = read_node(tree_data)
	
	cur_level_data.W = luaW -- Defined in menu_buttons.lua
	cur_level_data.H = luaH -- Defined in menu_buttons.lua
	-- These variables were defined to avoid using the function canvas:attrSize(),
	-- which is poorly defined in several Ginga NCL implementations:
	-- cur_level_data.W, cur_level_data.H = canvas:attrSize()
	
	cur_level_data.media_type = tree_node.media_type
	cur_level_data.arrow_down  = canvas:new(img_folder .. 'ARROW_DOWN' .. img_ext)
	cur_level_data.arrow_up    = canvas:new(img_folder .. 'ARROW_UP' .. img_ext)
	cur_level_data.arrow_left  = canvas:new(img_folder .. 'ARROW_LEFT' .. img_ext)
	cur_level_data.arrow_right = canvas:new(img_folder .. 'ARROW_RIGHT' .. img_ext)
	cur_level_data.arrow_back  = canvas:new(img_folder .. 'ARROW_BACK' .. img_ext)
	
	cur_level_data.box_font   = {'Tiresias',22,'bold'}
	cur_level_data.border = 5
	cur_level_data.branches = read_branches(tree_node, cur_level_data.border, cur_level_data.box_font)      --cur_level_data.img_nsel, cur_level_data.img_ysel, cur_level_data.text = read_branches(tree_node)
	
	cur_level_data.branch_num = #(cur_level_data.branches)
	if cur_level_data.branch_num > 0 and cur_level_data.branches[1].media_type=='url' then
		if internet_connection_available then
			local cur_url = cur_level_data.branches[1].url
			reset_canvas(lua_xs, lua_ys, fullW,fullH)
			canvas:compose(math.floor(lua_xs+(luaW-158)/2),math.floor(lua_ys+(luaH-123)/2),
				canvas:new(img_folder .. 'BTN_DOWNLOADING_DATA' .. img_ext))
			canvas:flush()
			--is_downloading = true
			tree_node.branches = htmlCallback('',get_website(cur_url),htmlOptions(cur_url))
		else
			tree_node.branches = {create_node(':: No internet connection available','txt')}
		end
		cur_level_data.branches = read_branches(tree_node, cur_level_data.border, cur_level_data.box_font)
		cur_level_data.branch_num = #(cur_level_data.branches)
		--current_level_index = {tree_data.level, tree_node.focus}
	end
	cur_level_data.level = tree_data.level
	cur_level_data.focus = tree_node.focus
	
	cur_level_data.img_crumb = tree_node.img_crumb
	cur_level_data.crumb_canvas = tree_node.crumb_canvas
	nodeDimensions(cur_level_data)
	
	branchesDimensions(cur_level_data)
	for cur_br = 1,cur_level_data.branch_num do
		local cur_branch = cur_level_data.branches[cur_br]
		cur_branch.cur_canvas_no_focus = nil
		cur_branch.cur_canvas_focus = nil
		cur_branch.cur_canvas = nil
		if cur_branch.media_type=='txt' then
			cur_branch.cur_canvas_no_focus = textBox(cur_branch, 'left', cur_level_data.border,
				{255,255,255,255}, {90,90,90,255}, {161,161,161,255})
			cur_branch.cur_canvas_focus    = textBox(cur_branch, 'left', cur_level_data.border,
				{50,50,50,255}, {255,255,255,255}, {90,90,90,255})
		elseif cur_branch.media_type=='qrcode' then
			cur_branch.cur_canvas = showQRCode(cur_branch.qr_code_t,
				cur_branch.square_side, cur_branch.qrcode_border)
		end
	end
	if tree_node.focus~=nil then
		cur_level_data.has_branches = tree_node.branches[1].focus~=nil
	else
		cur_level_data.has_branches = false
	end
	
	if canvas_orientation == "HORIZONTAL" then
		local num_btns = 1
		local min_gap = 5 --50
		cur_level_data.x_gap = 0
		cur_level_data.y_gap = cur_level_data.H
		for j=1,#cur_level_data.branches do
			cur_level_data.x_gap = math.max(cur_level_data.x_gap,cur_level_data.branches[j].W)
			if cur_level_data.y_gap > cur_level_data.branches[j].H + (num_btns+1)*min_gap then
				cur_level_data.y_gap = cur_level_data.y_gap - cur_level_data.branches[j].H
				num_btns = num_btns + 1
			end
		end
		cur_level_data.y_gap = cur_level_data.y_gap/num_btns
		cur_level_data.x_gap = (cur_level_data.W-cur_level_data.x_gap)/2
		cur_level_data.y = cur_level_data.y_gap
		for j=2,cur_level_data.focus do
			cur_level_data.y = cur_level_data.y - cur_level_data.branches[j-1].H - cur_level_data.y_gap
		end
		cur_level_data.x = cur_level_data.W/2
	end
	if canvas_orientation == "VERTICAL" then
		local num_btns = 1
		local min_gap = 5 --50
		cur_level_data.y_gap = 0
		cur_level_data.x_gap = cur_level_data.W
		for j=1,#cur_level_data.branches do
			cur_level_data.y_gap = math.max(cur_level_data.y_gap,cur_level_data.branches[j].H)
			if cur_level_data.x_gap > cur_level_data.branches[j].W + (num_btns+1)*min_gap then
				cur_level_data.x_gap = cur_level_data.x_gap - cur_level_data.branches[j].W
				num_btns = num_btns + 1
			end
		end
		cur_level_data.x_gap = cur_level_data.x_gap/num_btns
		cur_level_data.y_gap = (cur_level_data.H-cur_level_data.y_gap)/2
		cur_level_data.x = cur_level_data.x_gap
		for j=2,cur_level_data.focus do
			cur_level_data.x = cur_level_data.x - cur_level_data.branches[j-1].W - cur_level_data.x_gap
		end
		cur_level_data.y = cur_level_data.H/2
	end
	
	return cur_level_data
end

function main_menu_handler(evt_key)
	if is_moving == true then return end
	if canvas_orientation == "HORIZONTAL" then
		if evt_key == 'CURSOR_DOWN' then
			if level_data.focus<(#level_data.branches) then
				level_data.focus = level_data.focus+1
				animate_canvas(level_data,"UP")
			end
		elseif evt_key == 'CURSOR_UP' then
			if level_data.focus>1 then
				level_data.focus = level_data.focus-1
				animate_canvas(level_data,"DOWN")
			end
		elseif evt_key == 'CURSOR_RIGHT' or evt_key == 'ENTER' or evt_key == 'OK' then
			if level_data.has_branches then
				animate_canvas(level_data,"LEFT")
			end
		elseif evt_key == 'CURSOR_LEFT' then
			if level_data.level>1 then
				animate_canvas(level_data,"RIGHT")
			end
		end
	end
	if canvas_orientation == "VERTICAL" then
		if evt_key == 'CURSOR_RIGHT' then
			if level_data.focus<(#level_data.branches) then
				level_data.focus = level_data.focus+1
				animate_canvas(level_data,"LEFT")
			end
		elseif evt_key == 'CURSOR_LEFT' then
			if level_data.focus>1 then
				level_data.focus = level_data.focus-1
				animate_canvas(level_data,"RIGHT")
			end
		elseif evt_key == 'CURSOR_UP' or evt_key == 'ENTER' or evt_key == 'OK' then
			if level_data.has_branches then
				animate_canvas(level_data,"UP")
			end
		elseif evt_key == 'CURSOR_DOWN' then
			if level_data.level>1 then
				animate_canvas(level_data,"DOWN")
			end
		end
	end
end

function Start_App()
	local img_names_start = {'1_botao_Interativo'}
	local img_xs_start = {1280*3/4-162/2}
	local img_ys_start = {720/4-162/2}
	
	for j = 1,#img_names_start do
		canvas:compose(img_xs_start[j], img_ys_start[j],
			canvas:new(img_folder .. img_names_start[j] .. img_ext))
	end
	canvas:flush()
	run_menu = false
	app_tree.level = 1
	app_tree.root.focus = 1
end

function Start_Menu()
	reset_canvas(0, 0, fullW, fullH)
	--local img_names_menu = {'APP_LOGO_small', 'BTN_STOP'}
	--local img_xs_menu = {278,269}
	--local img_ys_menu = {72,576}
	--for j = 1,#img_names_menu do
	--	canvas:compose(img_xs_menu[j], img_ys_menu[j],
	--		canvas:new(img_folder .. img_names_menu[j] .. img_ext))
	--end
	canvas:attrClip(lua_xs, lua_ys, luaW, luaH)
	level_data = read_level_data(app_tree)
	draw_breadcrumb(level_data)
	draw_canvas(level_data)
	run_menu = true
end

function menu_lua_event_handler(evt)	
	if run_menu then
		if evt.class == 'key' and evt.type == 'press' then
			--if is_downloading==true then return end
			if evt.key == 'RED' then
				canvas:attrClip(0, 0, fullW, fullH)
				clear_canvas(0, 0, fullW, fullH)
				Start_App()
				--event.post {class  = 'ncl', type = 'presentation', action = 'stop'}
			else
				main_menu_handler(evt.key)
			end
		end
	else
		if((evt.class == 'ncl') and (evt.type == 'presentation')) and (evt.action == 'start') then
			Start_App()
		end
		if evt.class == 'key' and evt.type == 'press' then
			if evt.key == 'GREEN' or evt.key == 'CURSOR_LEFT' or evt.key == 'CURSOR_RIGHT' or evt.key == 'CURSOR_UP' or evt.key == 'CURSOR_DOWN' or evt.key =='OK' or evt.key =='ENTER' then
				Start_Menu()
			end
		end
	end
end

event.register(menu_lua_event_handler)