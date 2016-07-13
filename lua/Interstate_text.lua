function measureText(text)
	local letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqsrtuvwxyz1234567890!@#$%&*()-_+=[]{};:.,<>?/\\|\"'"
	local acentos = "ÁÉÍÓÚÀÂÊÔÃÇáéíóúàâêôãç"
	local l_start = {0,14,27,42,56,69,81,95,110,119,133,147,159,176,190,204,218,232,246,259,272,286,300,316,329,343,356,369,382,395,408,421,432,445,458,466,477,490,499,516,529,543,556,569,582,592,604,617,629,645,658,671,683,694,707,720,734,747,760,774,787,801,814,824,840,856,869,891,905,919,929,940,950,962,976,990,1001,1012,1024,1036,1046,1055,1065,1074,1086,1096,1109,1120,1133,1143,1157,1167,1181,1194,1203,1218,1232,1245,1260,1272,1286,1300,1313,1327,1340,1349,1362,1375,1388,1401,1414,1427,1440,}
	local l_width = {9,8,10,9,8,7,9,10,4,9,9,7,12,9,9,9,9,9,8,8,9,9,12,9,10,8,8,8,8,8,9,6,8,8,4,6,8,4,12,8,9,8,8,8,6,7,8,8,12,9,9,8,6,8,9,9,8,9,9,8,9,8,5,11,11,9,18,10,9,6,6,6,8,9,9,6,6,7,7,5,4,5,4,7,6,9,8,8,5,9,5,9,8,6,10,9,9,10,7,9,9,9,9,8,6,8,8,8,8,8,9,9,8,}
	local l_height = 27
	local line_distance = 3
	local letter_distance = 1
	local space_width = 5
	local tab_distance = 3*space_width

	for i = 2,acentos:len(),2 do
		letras = letras .. acentos:sub(i,i)
	end
	
	local max_x = 0
	local max_y = 0
	local x_pos = 0
	local c = ''
	i = 0
	for j=1,text:len() do
		i=i+1
		c = text:sub(i,i)
		k = letras:find(c, 1, true)
		if k == nil then
			if c == ' ' then
				x_pos = x_pos + space_width
			elseif c == '\n' then
				max_y = max_y + l_height + line_distance
				if x_pos > max_x then max_x = x_pos end
				x_pos = 0
			elseif c == '\t' then
				x_pos = x_pos + tab_distance
			end
		else
			x_pos = x_pos + l_width[k] + letter_distance
		end
	end
	max_y = max_y + l_height + line_distance
	if x_pos > max_x then max_x = x_pos end
	return max_x, max_y
end

function drawText(text)
	local letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqsrtuvwxyz1234567890!@#$%&*()-_+=[]{};:.,<>?/\\|\"'"
	local acentos = "ÁÉÍÓÚÀÂÊÔÃÇáéíóúàâêôãç"
	local l_start = {0,14,27,42,56,69,81,95,110,119,133,147,159,176,190,204,218,232,246,259,272,286,300,316,329,343,356,369,382,395,408,421,432,445,458,466,477,490,499,516,529,543,556,569,582,592,604,617,629,645,658,671,683,694,707,720,734,747,760,774,787,801,814,824,840,856,869,891,905,919,929,940,950,962,976,990,1001,1012,1024,1036,1046,1055,1065,1074,1086,1096,1109,1120,1133,1143,1157,1167,1181,1194,1203,1218,1232,1245,1260,1272,1286,1300,1313,1327,1340,1349,1362,1375,1388,1401,1414,1427,1440,}
	local l_width = {9,8,10,9,8,7,9,10,4,9,9,7,12,9,9,9,9,9,8,8,9,9,12,9,10,8,8,8,8,8,9,6,8,8,4,6,8,4,12,8,9,8,8,8,6,7,8,8,12,9,9,8,6,8,9,9,8,9,9,8,9,8,5,11,11,9,18,10,9,6,6,6,8,9,9,6,6,7,7,5,4,5,4,7,6,9,8,8,5,9,5,9,8,6,10,9,9,10,7,9,9,9,9,8,6,8,8,8,8,8,9,9,8,}
	local l_height = 27
	local line_distance = 3
	local letter_distance = 1
	local space_width = 5
	local tab_distance = 3*space_width

	for i = 2,acentos:len(),2 do
		letras = letras .. acentos:sub(i,i)
	end
	local img_file = canvas:new(img_folder .. 'Interstate_bold_compressed_24' .. img_ext)
	local text_W,text_H = measureText(text)
	local text_canvas = canvas:new(img_folder .. 'canvas_full_background' .. img_ext)
	text_canvas:attrCrop(0,0,text_W,text_H)
	local x_pos = 0
	local y_pos = 0
	local c = ''
	i = 0
	for j=1,text:len() do
		i=i+1
		c = text:sub(i,i)
		k = letras:find(c, 1, true)
		if k == nil then
			if c == ' ' then
				x_pos = x_pos + space_width
			elseif c == '\n' then
				y_pos = y_pos + l_height + line_distance
				x_pos = 0
			elseif c == '\t' then
				x_pos = x_pos + tab_distance
			end
		else
			img_file:attrCrop(l_start[k],0,l_width[k],l_height)
			text_canvas:compose(x_pos,y_pos,img_file)
			x_pos = x_pos + l_width[k] + letter_distance
		end
	end
	return text_canvas
end