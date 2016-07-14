local l_start = {0,19,38,56,75,93,110,129,149,163,180,201,217,239,258,277,296,315,335,352,370,389,407,429,448,466,482,501,520,538,557,575,592,611,632,645,663,683,700,721,740,759,778,797,814,834,852,871,889,912,930,948,967,982,999,1016,1034,1051,1069,1085,1102,1120,1138,1150,1173,1189,1205,1226,1247,1260,1273,1287,1300,1316,1333,1350,1361,1374,1385,1399,1411,1424,1437,1449,1465,1482,1497,1510,1523,1534,1546,1555,1574,1592,1606,1625,1643,1662,1681,1698,1716,1735,1753,1772,1790,1803,1822,1841,1859,1878,1896,1914,1933,}
local l_width = {13,13,12,13,12,11,13,14,8,11,15,11,16,13,13,13,13,14,11,12,13,13,17,13,12,10,13,13,12,13,12,11,13,15,7,12,14,11,15,13,13,13,13,11,14,12,13,13,17,12,12,13,9,11,11,12,11,12,10,11,12,12,6,17,10,11,16,15,7,7,8,7,10,11,11,5,7,6,8,6,7,7,6,10,11,9,8,7,5,6,3,13,12,8,13,13,14,13,11,13,14,12,13,12,7,13,13,13,14,12,13,13,11,}
local l_height = 22
local line_distance = 3
local letter_distance = 1
local space_width = 5
local tab_distance = 3*space_width
local font_img_file = 'Stencil_std_24'

function measureText(text)
	local letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqsrtuvwxyz1234567890!@#$%&*()-_+=[]{};:.,<>?/\\|\"'"
	local acentos = "ÁÉÍÓÚÀÂÊÔÃÇáéíóúàâêôãç"
	
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
		
	for i = 2,acentos:len(),2 do
		letras = letras .. acentos:sub(i,i)
	end
	
	local img_file = canvas:new(img_folder .. font_img_file .. img_ext)
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