dofile("tree.lua")

--function create_node(media, media_type, focus, branches)
--	if not(focus) or not(branches) then
--		return {media=media, media_type=media_type}
--	else
--		return {media=media, media_type=media_type, focus=focus, branches=branches}
--	end
--end

function sortByField(t,field_name)
	for i=1,#t do
		for j = #t,(i+1),-1 do
			if t[j][field_name] < t[j-1][field_name] then
				local dummy = t[j]
				t[j] = t[j-1]
				t[j-1] = dummy
			end
		end
	end
end

function find_field_value(t, field_name, field_value)
	for j = 1,#t do
		if t[j][field_name]==field_value then return j end
	end
	return 0
end

function htmlToTable(html_body, html_delimiters)
	local est_info = {}
	i = {1,1}
	j = {1,1}
	k = html_body:find(html_delimiters[1].str_start,j[2],true)
	while k~=nil do
		local cur_search = {}
		for k=1,#html_delimiters do
			local cur_delim = html_delimiters[k]
			i[1],j[1] = html_body:find(cur_delim.str_start,j[2]+1,true)
			i[2],j[2] = html_body:find(cur_delim.str_end,  j[1],true)
			cur_search[cur_delim.field_name] = html_body:sub(j[1]+1,i[2]-1)
		end
		table.insert(est_info, cur_search)
		k = html_body:find(html_delimiters[1].str_start,j[2]+1,true)
	end
	return est_info
end

function tableValuePrefix(t, field_name, prefix_value)
	for j=1,#t do
		t[j][field_name] = prefix_value .. t[j][field_name]
	end
end

function tableValueSuffix(t, field_name, suffix_value)
	for j=1,#t do
		t[j][field_name] = t[j][field_name] .. suffix_value
	end
end

function tableValueSubs(t, field_name, field_inputs, field_outputs)
	for j=1,#t do
		for k = 1,#field_inputs do
			if t[j][field_name] == field_inputs[k] then
				t[j][field_name] = field_outputs[k]
			end
		end
	end
end

function tableToNodes(t, node_value, branches_values, sub_branches_values, sub_branch_type)
	local search_tree = {}
	local cur_branch = ''
	local cur_media  = ''
	local cur_sub_branch = {}
	if #t > 0 then
		if node_value:len()==0 then
			for k=1,#t do
				cur_branch = ''
				for j=1,#branches_values do
					cur_branch = cur_branch .. t[k][branches_values[j]]
				end
				if #sub_branches_values > 0 then
					table.insert(search_tree,create_node(cur_branch,'txt'))
					if sub_branch_type=='qrcode' then
						for j=1,#sub_branches_values do
							cur_media = t[k][sub_branches_values[j] ]
							jj = cur_media:find('!',1,true)
							table.insert(search_tree, create_node(cur_media:sub(1,jj-1), 'txt'))
							table.insert(search_tree, create_node(cur_media:sub(jj+1,-1), 'qrcode'))
						end
					else
						for j=1,#sub_branches_values do
							table.insert(search_tree, create_node(t[k][sub_branches_values[j] ], sub_branch_type))
						end
					end
					--cur_sub_branch = {}
					--for j=1,#sub_branches_values do
					--	table.insert(cur_sub_branch, create_node(t[k][sub_branches_values[j] ], sub_branch_type))
					--end
					--search_tree = {create_node(cur_branch,'txt',1,cur_sub_branch)}
				else
					search_tree = {create_node(cur_branch,'txt')}
				end
			end
		else
			local search_tree_before_micro_regions = {}
			sortByField(t,node_value)
			for k=1,#t do
				kk = find_field_value(search_tree_before_micro_regions, 'media', t[k][node_value])
				if kk == 0 then
					table.insert(search_tree_before_micro_regions,create_node(t[k][node_value],'txt',1,{}))
					kk = #search_tree_before_micro_regions
				end
				cur_branch = ''
				for j=1,#branches_values do
					cur_branch = cur_branch .. t[k][branches_values[j]]
				end
				if #sub_branches_values > 0 then
					cur_sub_branch = {}
					for j=1,#sub_branches_values do
						table.insert(cur_sub_branch, create_node(t[k][sub_branches_values[j] ], sub_branch_type))
					end
					table.insert(search_tree_before_micro_regions[kk].branches,
						create_node(cur_branch,'txt',1,cur_sub_branch))
				else
					table.insert(search_tree_before_micro_regions[kk].branches,create_node(cur_branch,'txt'))
				end
			end
			local municipios_por_microregiao = {{"Micro_regioes/Para_microrregiao_Almeirim","ALMEIRIM","PORTO DE MOZ"},
												{"Micro_regioes/Para_microrregiao_Santarem","ALENQUER","BELTERRA","CURUA","MOJUI DOS CAMPOS","MONTE ALEGRE","PLACAS","PRAINHA","SANTAREM"},
												{"Micro_regioes/Para_microrregiao_Obidos","FARO","JURUTI","OBIDOS","ORIXIMINA","TERRA SANTA"},
												{"Micro_regioes/Para_microrregiao_Belem","ANANINDEUA","BARCARENA","BELEM","BENEVIDES","MARITUBA","SANTA BARBARA DO PARA"},
												{"Micro_regioes/Para_microrregiao_Castanhal","BUJARU","CASTANHAL","INHANGAPI","SANTA ISABEL DO PARA","SANTO ANTONIO DO TAUA"},
												{"Micro_regioes/Para_microrregiao_Arari","CACHOEIRA DO ARARI","CHAVES","MUANA","PONTA DE PEDRAS","SALVATERRA","SANTA CRUZ DO ARARI","SOURE"},
												{"Micro_regioes/Para_microrregiao_Furos_de_Breves","AFUA","ANAJAS","BREVES","CURRALINHO","SAO SEBASTIAO DA BOA VISTA"},
												{"Micro_regioes/Para_microrregiao_Portel","BAGRE","GURUPA","MELGACO","PORTEL"},
												{"Micro_regioes/Para_microrregiao_Salgado","COLARES","CURUCA","MAGALHAES BARATA","MARACANA","MARAPANIM","SALINOPOLIS","SAO CAETANO DE ODIVELAS","SAO JOAO DA PONTA","SAO JOAO DE PIRABAS","TERRA ALTA","VIGIA"},
												{"Micro_regioes/Para_microrregiao_Bragantina","AUGUSTO CORREA","BONITO","BRAGANCA","CAPANEMA","IGARAPE ACU","NOVA TIMBOTEUA","PEIXE BOI","PRIMAVERA","QUATIPURU","SANTA MARIA DO PARA","SANTAREM NOVO","SAO FRANCISCO DO PARA","TRACUATEUA"},
												{"Micro_regioes/Para_microrregiao_Cameta","ABAETETUBA","BAIAO","CAMETA","IGARAPE MIRI","LIMOEIRO DO AJURU","MOCAJUBA","OEIRAS DO PARA"},
												{"Micro_regioes/Para_microrregiao_Guama","AURORA DO PARA","CACHOEIRA DO PIRIA","CAPITAO POCO","GARRAFAO DO NORTE","IPIXUNA DO PARA","IRITUIA","MAE DO RIO","NOVA ESPERANCA DO PIRIA","OUREM","SANTA LUZIA DO PARA","SAO DOMINGOS DO CAPIM","SAO MIGUEL DO GUAMA","VISEU"},
												{"Micro_regioes/Para_microrregiao_TomeAcu","ACARA","CONCORDIA DO PARA","MOJU","TAILANDIA","TOME ACU"},
												{"Micro_regioes/Para_microrregiao_Conceicao_do_Araguaia","CONCEICAO DO ARAGUAIA","FLORESTA DO ARAGUAIA","SANTA MARIA DAS BARREIRAS","SANTANA DO ARAGUAIA"},
												{"Micro_regioes/Para_microrregiao_Maraba","BREJO GRANDE DO ARAGUAIA","MARABA","PALESTINA DO PARA","SAO DOMINGOS DO ARAGUAIA","SAO JOAO DO ARAGUAIA"},
												{"Micro_regioes/Para_microrregiao_Paragominas","ABEL FIGUEIREDO","BOM JESUS DO TOCANTINS","DOM ELISEU","GOIANESIA DO PARA","PARAGOMINAS","RONDON DO PARA","ULIANOPOLIS"},
												{"Micro_regioes/Para_microrregiao_Parauapebas","AGUA AZUL DO NORTE","CANAA DOS CARAJAS","CURIONOPOLIS","ELDORADO DOS CARAJAS","PARAUAPEBAS"},
												{"Micro_regioes/Para_microrregiao_Redencao","PAU D'ARCO","PICARRA","REDENCAO","RIO MARIA","SAPUCAIA","SAO GERALDO DO ARAGUAIA","XINGUARA"},
												{"Micro_regioes/Para_microrregiao_Sao_Felix_do_Xingu","BANNACH","CUMARU DO NORTE","OURILANDIA DO NORTE","SAO FELIX DO XINGU","TUCUMA"},
												{"Micro_regioes/Para_microrregiao_Tucurui","BREU BRANCO","ITUPIRANGA","JACUNDA","NOVA IPIXUNA","NOVO REPARTIMENTO","TUCURUI"},
												{"Micro_regioes/Para_microrregiao_Altamira","ALTAMIRA","ANAPU","BRASIL NOVO","MEDICILANDIA","PACAJA","SENADOR JOSE PORFIRIO","URUARA","VITORIA DO XINGU"},
												{"Micro_regioes/Para_microrregiao_Itaituba","AVEIRO","ITAITUBA","JACAREACANGA","NOVO PROGRESSO","RUROPOLIS","TRAIRAO"}
												};
			local found_micro_regions = {{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}}
			for j=1,#search_tree_before_micro_regions do
				k = #municipios_por_microregiao
				while k>0 do
					kk = #municipios_por_microregiao[k]
					while kk > 1 do
						if search_tree_before_micro_regions[j].media == municipios_por_microregiao[k][kk] then
							table.insert(found_micro_regions[k],j)
							kk = 1
							k  = 0
						end
						kk = kk-1
					end
					k = k-1
				end
			end
			for j=1,#found_micro_regions do
				if #found_micro_regions[j]>0 then
					table.insert(search_tree, create_node(municipios_por_microregiao[j][1],'img',1,{}))
					kk = #search_tree
					for k = 1,#found_micro_regions[j] do
						table.insert(search_tree[kk].branches,search_tree_before_micro_regions[found_micro_regions[j][k]])
					end
				end
			end
		end
	else
		search_tree = {create_node('No information available','txt')}
	end
	return search_tree
end

function htmlOptions(url)
	local htmlTA = {}
	if url:find('Mod_Ind_Leitos_Listar.asp') then
		htmlTA.url = url
		htmlTA.delims = {}
		htmlTA.delims[1] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "CNES"}
		htmlTA.delims[2] = {str_start="VCo_Unidade=", str_end="&VListar=", field_name = "Estab_Num"}
		htmlTA.delims[3] = {str_start='">', str_end='</a>', field_name = "Estabelecimento"}
		htmlTA.delims[4] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "Municipio"}
		htmlTA.delims[5] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "Existentes"}
		htmlTA.delims[6] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "SUS"}
		htmlTA.prefix = {}
		htmlTA.prefix[1] = {f_name="Estab_Num",add='http://cnes2.datasus.gov.br/Exibe_Ficha_Estabelecimento.asp?VCo_Unidade='}
		htmlTA.suffix = {}
		htmlTA.suffix[1] = {f_name="Estab_Num",add='&VListar=1&VEstado=15&VMun='}
		htmlTA.suffix[2] = {f_name="Estabelecimento",add='\n'}
		htmlTA.suffix[3] = {f_name="Existentes",add=' beds\n'}
		htmlTA.suffix[4] = {f_name="SUS",add=' from SUS'}
		htmlTA.subs = {}
		htmlTA.node_ind = "Municipio"
		htmlTA.branch_ind = {"Estabelecimento","Existentes","SUS"}
		htmlTA.sub_branch_ind = {"Estab_Num"}
		htmlTA.sub_branch_type = 'url'
		return htmlTA
	elseif url:find('Mod_Ind_Habilitacoes_Listar.asp') then
		htmlTA.url = url
		htmlTA.delims = {}
		htmlTA.delims[1]  = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "UF"}
		htmlTA.delims[2]  = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "CNES"}
		htmlTA.delims[3]  = {str_start="VCo_Unidade=", str_end="&VListar=", field_name = "Estab_Num"}
		htmlTA.delims[4]  = {str_start='">', str_end='</a>', field_name = "Estabelecimento"}
		htmlTA.delims[5]  = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "Competencia_inicial"}
		htmlTA.delims[6]  = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "Competencia_final"}
		htmlTA.delims[7]  = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "Leitos_SUS"}
		htmlTA.delims[8]  = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "CNPJ_Proprio"}
		htmlTA.delims[9]  = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "CNPJ_Mantenedora"}
		htmlTA.delims[10] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "Municipio"}
		htmlTA.prefix = {}
		htmlTA.prefix[1] = {f_name="Estab_Num",add='http://cnes2.datasus.gov.br/Exibe_Ficha_Estabelecimento.asp?VCo_Unidade='}
		htmlTA.suffix = {}
		htmlTA.suffix[1] = {f_name="Estab_Num",add='&VListar=1&VEstado=15&VMun='}
		htmlTA.suffix[2] = {f_name="Estabelecimento",add='\n'}
		htmlTA.suffix[3] = {f_name="Leitos_SUS",add=' SUS beds'}
		htmlTA.subs = {}
		htmlTA.node_ind = "Municipio"
		htmlTA.branch_ind = {"Estabelecimento","Leitos_SUS"}
		htmlTA.sub_branch_ind = {"Estab_Num"}
		htmlTA.sub_branch_type = 'url'
		return htmlTA
	elseif url:find('Mod_Ind_Especialidades_Listar.asp') then
		htmlTA.url = url
		htmlTA.delims = {}
		htmlTA.delims[1] = {str_start="VCo_Unidade=", str_end="&VListar=", field_name = "Estab_Num"}
		htmlTA.delims[2] = {str_start='">', str_end='\r', field_name = "Estabelecimento"}
		htmlTA.delims[3] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "CNPJ"}
		htmlTA.delims[4] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "CNPJ_Mantenedora"}
		htmlTA.delims[5] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "Municipio"}
		htmlTA.prefix = {}
		htmlTA.prefix[1] = {f_name="Estab_Num",add='http://cnes2.datasus.gov.br/Exibe_Ficha_Estabelecimento.asp?VCo_Unidade='}
		htmlTA.suffix = {}
		htmlTA.suffix[1] = {f_name="Estab_Num",add='&VListar=1&VEstado=15&VMun='}
		htmlTA.subs = {}
		htmlTA.node_ind = "Municipio"
		htmlTA.branch_ind = {"Estabelecimento"}
		htmlTA.sub_branch_ind = {"Estab_Num"}
		htmlTA.sub_branch_type = 'url'
		return htmlTA
	elseif url:find('Mod_Ind_Equipamentos_Listar.asp') then
		htmlTA.url = url
		htmlTA.delims = {}
		htmlTA.delims[1] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "CNES"}
		htmlTA.delims[2] = {str_start="VCo_Unidade=", str_end="&VListar=", field_name = "Estab_Num"}
		htmlTA.delims[3] = {str_start='">', str_end='</a>', field_name = "Estabelecimento"}
		htmlTA.delims[4] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "Municipio"}
		htmlTA.delims[5] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "Existentes"}
		htmlTA.delims[6] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "Em_uso"}
		htmlTA.delims[7] = {str_start="<font size='1' color='#003366' face='verdana,arial'>", str_end="</font>", field_name = "SUS"}
		htmlTA.prefix = {}
		htmlTA.prefix[1] = {f_name="Estab_Num",add='http://cnes2.datasus.gov.br/Exibe_Ficha_Estabelecimento.asp?VCo_Unidade='}
		htmlTA.suffix = {}
		htmlTA.suffix[1] = {f_name="Estab_Num",add='&VListar=1&VEstado=15&VMun='}
		htmlTA.suffix[2] = {f_name="Estabelecimento",add='\n'}
		htmlTA.suffix[3] = {f_name="Existentes",add=' machines\n'}
		htmlTA.suffix[4] = {f_name="Em_uso",add=' active\n'}
		htmlTA.subs = {}
		htmlTA.subs[1] = {f_name="SUS",inputs={'S','N'}, outputs={'Supports SUS.','Does not support SUS.'}}
		htmlTA.node_ind = "Municipio"
		htmlTA.branch_ind = {"Estabelecimento","Existentes","Em_uso","SUS"}
		htmlTA.sub_branch_ind = {"Estab_Num"}
		htmlTA.sub_branch_type = 'url'
		return htmlTA
	elseif url:find('Exibe_Ficha_Estabelecimento.asp') then
		htmlTA.url = url
		htmlTA.delims = {}
		htmlTA.delims[1] = {str_start='<Input type=hidden name="Cod_Unidade" value="', str_end='">', field_name = 'Full_Site'}
		htmlTA.delims[2] = {str_start='onClick="Mostrar(\'', str_end='\')">', field_name = 'Geo'}
        htmlTA.delims[3]  = {str_start='<td colspan=3><font size=1 face=Verdana,arial color=#003366>', str_end="</font></td>", field_name = "Nome"}
        htmlTA.delims[4]  = {str_start='<td colspan=3><font size=1 face=Verdana,arial color=#003366>', str_end="</font></td>", field_name = "Nome_Empresarial"}
		htmlTA.delims[5]  = {str_start='<td colspan=3><font size=1 face=Verdana,arial color=#003366>', str_end="</font></td>", field_name = "Logradouro"}
		htmlTA.delims[6]  = {str_start="<td colspan=1><font size=1 face=Verdana,arial color=#003366>", str_end="</font></td>", field_name = "Numero"}
		htmlTA.delims[7]  = {str_start="<td colspan=1><font size=1 face=Verdana,arial color=#003366>", str_end="</font></td>", field_name = "Telefone"}
		htmlTA.delims[8]  = {str_start="<td><font size=1 face=Verdana,arial color=#003366>", str_end="</font></td>", field_name = "Complemento"}
		htmlTA.delims[9]  = {str_start="<td><font size=1 face=Verdana,arial color=#003366>", str_end="</font></td>", field_name = "Bairro"}
		htmlTA.delims[10] = {str_start="<td><font size=1 face=Verdana,arial color=#003366>", str_end="</font></td>", field_name = "CEP"}
		htmlTA.delims[11] = {str_start="<font color='#003366' face=verdana,arial size=1>", str_end=" - IBGE", field_name = "Municipio"}
		htmlTA.prefix = {}
		htmlTA.prefix[1] = {f_name="Full_Site",add='Website!http://cnes2.datasus.gov.br/Cabecalho_Reduzido_Competencia.asp?VCod_Unidade='}
		htmlTA.prefix[2] = {f_name="Geo",add='Map!http://cnes2.datasus.gov.br/geo.asp?VUnidade='}
		htmlTA.prefix[3] = {f_name="Telefone",add='Tel.: '}
		htmlTA.prefix[4] = {f_name="CEP",add='CEP: '}
		htmlTA.prefix[5] = {f_name="Bairro",add='Bairro: '}
		htmlTA.suffix = {}
		htmlTA.suffix[1] = {f_name="Nome",add='\n'}
		htmlTA.suffix[2] = {f_name="Logradouro",add=', '}
		htmlTA.suffix[3] = {f_name="Numero",add='\n'}
		htmlTA.suffix[4] = {f_name="Telefone",add='\n'}
		htmlTA.suffix[5] = {f_name="Bairro",add=', '}
		--htmlTA.suffix[6] = {f_name="CEP",add='\n'}
		htmlTA.suffix[6] = {f_name="Municipio",add='\n'}
		htmlTA.subs = {}
		htmlTA.node_ind = ""
		htmlTA.branch_ind = {"Nome","Logradouro","Numero","Bairro","Municipio","Telefone","CEP"}
		htmlTA.sub_branch_ind = {"Full_Site","Geo"}
		htmlTA.sub_branch_type = 'qrcode'
		return htmlTA
	end
end