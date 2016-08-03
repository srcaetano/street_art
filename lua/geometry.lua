dofile("text.lua")
dofile("Stencil_std_text.lua") 
--dofile("Interstate_text.lua")

local canvas_background = img_folder .. 'canvas_full_background' .. img_ext

function plotFullCircle(r, RGBA)
	local x = -r
	local y = 0
	local err = 2-2*r
	local xm = r
	local ym = r
	--local circle_canvas = blank_canvas(2*r,2*r) --canvas:new(2*r,2*r)
	local circle_canvas = canvas:new(canvas_background)
	circle_canvas:attrCrop(0,0,2*r,2*r)
	circle_canvas:attrColor(RGBA[1],RGBA[2],RGBA[3],RGBA[4])
	while x < 0 do
		if y>0 then
			circle_canvas:drawRect('fill',xm+x, ym-y, 2*(-x), 2*y)
			circle_canvas:drawRect('fill',xm-y, ym+x, 2*y, 2*(-x))
		end
		r = err
		if r <= y then -- e_xy+e_y < 0
			y=y+1
			err = err+y*2+1
		end
		if r > x or err > y then -- e_xy+e_x > 0 or no 2nd y-step
			x=x+1
			err = err+x*2+1
		end
	end
	return circle_canvas
end

function plotRoundedRect(width, height, r, RGBA)
	local circle_canvas = plotFullCircle(r, RGBA)
	--local round_rect_canvas = blank_canvas(width, height)--canvas:new(width, height)
	local round_rect_canvas = canvas:new(canvas_background)
	round_rect_canvas:attrCrop(0,0,width, height)
	round_rect_canvas:attrColor(RGBA[1],RGBA[2],RGBA[3],RGBA[4]) 
	round_rect_canvas:compose(0,        0,         circle_canvas)
	round_rect_canvas:compose(width-2*r,0,         circle_canvas)
	round_rect_canvas:compose(0,        height-2*r,circle_canvas)
	round_rect_canvas:compose(width-2*r,height-2*r,circle_canvas)
	round_rect_canvas:drawRect('fill',r, 0, width-2*r,height)
	round_rect_canvas:drawRect('fill',0, r, width,    height-2*r)
	return round_rect_canvas
end

function textDimensions(separate_text, border, font)
	local dim = {}
	dim.max_x,dim.max_y = 0,0
	dim.dx = {}
	dim.dy = {}
--	if #font == 2 then
--		canvas:attrFont(font[1],font[2])
--	elseif #font == 3 then
--		canvas:attrFont(font[1],font[2],font[3])
--	end
	for j=1,#separate_text do
		dim.dx[j],dim.dy[j] = measureText(separate_text[j]) -- Change text call
		--dim.dx[j],dim.dy[j] = canvas:measureText(separate_text[j])
		dim.max_x = math.max(dim.max_x, dim.dx[j])
		dim.max_y = dim.max_y + dim.dy[j]
	end
	dim.low_WH = border*3 --math.floor(math.min(dim.max_x,dim.max_y)*0.14+0.5)
	dim.rectR = dim.low_WH
	dim.rectW = dim.max_x+2*(dim.low_WH+border)
	dim.rectH = dim.max_y+2*(dim.low_WH+border)
	return dim
end

function hyphenatedText(text, font, width)
	local separate_text = separateText(text)
	local hyphenated_text = {}
	local reduction = ''
	local reduced_text = ''
	local dx = 0
	local dy = 0
	local silab = {}
	local silab_size = #silab
--	if #font == 2 then
--		canvas:attrFont(font[1],font[2])
--	elseif #font == 3 then
--		canvas:attrFont(font[1],font[2],font[3])
--	end
	j = 1
	k = 0
	while j<=#separate_text do
		dx, dy = measureText(separate_text[j]) -- Change text call
		--dx, dy = canvas:measureText(separate_text[j])
		if dx < width then
			table.insert(hyphenated_text, separate_text[j])
		else
			silab = separarSilabasTexto(separate_text[j])
			silab_size = #silab
			dx = width+1
			reduction = ''
			while dx > width and silab_size>0 do
				reduction = silab[silab_size] .. reduction
				reduced_text = separate_text[j]:sub(1,-1-(reduction:len()))
				if silab[silab_size] ~= ' ' then
					if silab_size>1 and silab[silab_size-1] ~=' ' then
						reduced_text = reduced_text .. '-'
					end
				--else
				end
				dx,dy = measureText(reduced_text) -- Change text call
				--dx,dy = canvas:measureText(reduced_text)
				silab_size = silab_size-1
				--print(silab_size .. ' ' .. dx .. ' ' .. width .. ' ' .. reduced_text .. '||' .. reduction)
			end
			if silab_size==0 then table.insert(hyphenated_text, separate_text[j])
			else
				table.insert(hyphenated_text, reduced_text)
				if silab[silab_size-1]==' ' then reduction = '  ' .. reduction
				else reduction = '   ' .. reduction end
				table.insert(separate_text,j+1,reduction)
				--if j==#separate_text then separate_text[j+1] = reduction
				--else separate_text[j+1] = reduction .. separate_text[j+1] end
			end
		end
		j=j+1
	end
	return hyphenated_text
end


function nodeDimensions(cur_level_data)
	if cur_level_data.img_crumb ~= 'no_crumb' then
		j = 1
		n = img_sizes[j].name
		while n~=(cur_level_data.img_crumb) do
			j = j+1
			n = img_sizes[j].name
		end
		cur_level_data.crumbW = img_sizes[j].W
		cur_level_data.crumbH = img_sizes[j].H
	end
end

function branchesDimensions(cur_level_data)
	local cur_branch = {}
	for i = 1,#cur_level_data.branches do
		cur_branch = cur_level_data.branches[i]
		if cur_branch.media_type=='img' then
			j = 1
			n = img_sizes[j].name
			local cur_media = cur_branch.media
			while n~=cur_media do
				j = j+1
				n = img_sizes[j].name
			end
			cur_branch.W = img_sizes[j].W
			cur_branch.H = img_sizes[j].H
			--cur_branch.W, cur_branch.H =
				--cur_branch.img_ysel:attrSize()
		elseif cur_branch.media_type=='txt' then
			--cur_branch.separate_text = separateText(cur_branch.text)
			cur_branch.separate_text = hyphenatedText(cur_branch.text,
				cur_level_data.box_font, cur_level_data.W-cur_level_data.border*8)
			cur_branch.dim = textDimensions(
				cur_branch.separate_text, cur_level_data.border, cur_level_data.box_font)
			cur_branch.H = cur_branch.dim.rectH
			cur_branch.W = cur_branch.dim.rectW
		elseif cur_branch.media_type=='qrcode' then
			qr_code_length = (#(cur_branch.qr_code_t))*cur_branch.square_side+2*cur_branch.qrcode_border
			cur_branch.H = qr_code_length
			cur_branch.W = qr_code_length
		end
	end
	if (#cur_level_data.branches)>1 then
		local max_W = cur_level_data.branches[1].W
		for i = 2,#cur_level_data.branches do
			cur_branch = cur_level_data.branches[i]
			if cur_branch.media_type~='txt' then
				return
			end
			if cur_branch.W > max_W then
				max_W = cur_branch.W
			end
		end
		for i = 1,#cur_level_data.branches do
			if cur_branch.media_type=='txt' then
				cur_branch.W = max_W
			end
		end
	end
	--return cur_level_data
end

function textBox(branch, alignment, border, RGBA_text, RGBA_rRect, RGBA_rRect_border)
	local center_x = branch.W/2
	local center_y = branch.H/2
	local rectX = center_x - branch.W/2
	local rectY = center_y - branch.H/2
	--local text_box_canvas = blank_canvas(branch.W,branch.H) --canvas:new(branch.W,branch.H)
	local text_box_canvas = canvas:new(canvas_background)
	text_box_canvas:attrCrop(0,0,branch.W,branch.H)
	if border>0 then
		text_box_canvas:compose(0,0, plotRoundedRect(branch.W, branch.H,
			branch.dim.rectR, RGBA_rRect_border))
		text_box_canvas:compose(border,border,
			plotRoundedRect(branch.W-2*border, branch.H-2*border,
			branch.dim.rectR, RGBA_rRect))
	else
		text_box_canvas:compose(0,0, plotRoundedRect(branch.W, branch.H,
			branch.dim.rectR, RGBA_rRect))
	end
	local y0 = 0
	for j = 1,#branch.dim.dy do
		y0 = y0+branch.dim.dy[j]
	end
	y0 = y0/2
	--canvas:attrColor(RGBA_text[1],RGBA_text[2],RGBA_text[3],RGBA_text[4])
	if alignment=='center' then
		for j=1,#branch.separate_text do
			text_box_canvas:compose(center_x-branch.dim.dx[j]/2,center_y - y0,
				drawText(branch.separate_text[j]))
			--drawText(center_x-branch.dim.dx[j]/2,center_y - y0,
			--	branch.separate_text[j])
			y0 = y0-branch.dim.dy[j]
		end
	elseif alignment=='left' then
		local x0 = center_x - branch.dim.max_x/2
		for j=1,#branch.separate_text do
			text_box_canvas:compose(x0,center_y - y0,
				drawText(branch.separate_text[j]))
			--drawText(x0,center_y - y0,branch.separate_text[j]) -- Change text call
			y0 = y0-branch.dim.dy[j]
		end
	end
	return text_box_canvas
end

function showQRCode(qr_code_t, square_side, border_side)
	local qr_code_length = (#qr_code_t)*square_side+2*border_side
	--local qrcode_canvas = blank_canvas(qr_code_length,qr_code_length) --canvas:new(qr_code_length,qr_code_length)
	local qrcode_canvas = canvas:new(canvas_background)
	qrcode_canvas:attrCrop(0,0,qr_code_length,qr_code_length)
	local x_center = math.floor(qr_code_length/2)
	local y_center = math.floor(qr_code_length/2)
	
	local x0 = x_center - math.floor((#qr_code_t)/2)*square_side
	local y0 = y_center - math.floor((#qr_code_t)/2)*square_side
	x0 = math.floor(x0+0.5)
	y0 = math.floor(y0+0.5)
	local y = y0
	local x = x0
	qrcode_canvas:attrColor(255,255,255,255)
	qrcode_canvas:drawRect('fill', x0-border_side, y0-border_side,
		(#qr_code_t)*square_side + 2*border_side,
		(#qr_code_t)*square_side + 2*border_side)
	for j = 1,#qr_code_t do
		local x = x0
		for k = 1,#(qr_code_t[j]) do
			if qr_code_t[j][k]<0 then
				qrcode_canvas:drawRect('fill',x,y,square_side,square_side)
			end
			x = x + square_side
		end
		y = y + square_side
	end
	y = y0
	qrcode_canvas:attrColor(1,1,1,255)
	for j = 1,#qr_code_t do
		x = x0
		for k = 1,#(qr_code_t[j]) do
			if qr_code_t[j][k]>0 then
				qrcode_canvas:drawRect('fill',x,y,square_side,square_side)
			end
			x = x + square_side
		end
		y = y + square_side
	end
	return qrcode_canvas
end