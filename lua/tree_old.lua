qrencode = dofile("qrencode.lua")
dofile("geometry.lua")

--[[
@doc Function to create a new node in the tree. Each
node is a table containing 2 or 4 fields:

	media: media to be shown (text, image file name or URL)
	media_type: the media type ('txt' for text, 'img' for an image,
					'url' for a URL to make a specific search)
	focus: the value of the currently chosen branch of the node
	branches: a table containing sub-nodes, or branches

'focus' and 'branches' are optional. If one of these variables is not 
given, the current node will not have branches.
]]
function create_node(media, media_type, focus, branches)
	if not(focus) or not(branches) then
		return {media=media, media_type=media_type}
	else
		return {media=media, media_type=media_type, focus=focus, branches=branches}
	end
end

function read_node(tree_menu)
	local tree_node=tree_menu.root
	local i = tree_menu.level
	while i>1 and tree_node.focus~=nil do
		tree_node = tree_node.branches[tree_node.focus]
		i=i-1
	end
	return tree_node
end

function read_branches(tree_node, border, box_font)
	local branches = {}
	for i=1,#(tree_node.branches) do
		branches[i] = {}
		branches[i].media_type = tree_node.branches[i].media_type
		cur_media = tree_node.branches[i].media
		if branches[i].media_type == 'img' then
			branches[i].img_ysel = canvas:new(img_folder .. cur_media .. '_FOCUS' .. img_ext)
			branches[i].img_nsel = canvas:new(img_folder .. cur_media .. img_ext)
			branches[i].media = cur_media
		elseif branches[i].media_type == 'txt' then
			branches[i].text = cur_media
		elseif branches[i].media_type == 'url' then
			branches[i].url = cur_media
		elseif branches[i].media_type == 'qrcode' then
			local ok = nil
			ok,branches[i].qr_code_t=qrencode.qrcode(cur_media)
			branches[i].square_side = math.floor(200/(#(branches[i].qr_code_t))+0.5)
			branches[i].qrcode_border = 3*branches[i].square_side
		end
	end
	return branches
end