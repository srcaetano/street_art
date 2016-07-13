cur_socket = require("socket")

function get_website(url)
	-- @doc If url starts with 'http://', remove it
	if url:sub(1,7) == 'http://' then
		url = url:sub(8)
	end
	
	-- @doc Separate host's name from the name of the file to be received
	local slash_pos = url:find('/')
	local cur_page = url:sub(slash_pos)
	local cur_host = url:sub(1,slash_pos-1)
	
	-- @ doc Compose the HTTP 1.0 request, with user-agent and host name
	local cur_http_request = 'GET ' .. cur_page .. ' HTTP/1.0\nUser-Agent: NCLuaHTTP/0.9.9\nHost: ' .. cur_host .. '\n\n'
	
	--print('')
	--print(cur_http_request)
	
	----Define timeout for waiting internet connection
	local master_tcp = socket.tcp()
	master_tcp:settimeout(10)
	
	-- @doc Open HTTP/TCP connection to host
	local socket_conn = socket.connect(cur_host,80)
	if socket_conn==nil then return '' end
	-- @doc Ask to GET page
	local socket_req = socket_conn:send(cur_http_request)
	if socket_req==nil then socket_conn:close() return '' end
	-- @doc Read page
	local socket_page = socket_conn:receive('*a')
	--[[r = socket_conn:receive('*l') socket_page = '' while r do socket_page = socket_page .. r .. '\n' r = socket_conn:receive('*l') end]]
	if socket_page==nil then socket_conn:close() return '' end
	-- @doc Close HTTP/TCP connection to host
	socket_conn:close()
	-- @doc Return received page
	return socket_page
end