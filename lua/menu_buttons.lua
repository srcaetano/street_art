app_tree = {level=1, root=create_node('root', 'root', 'no_crumb', 1,{
	create_node('2a_botao_Satao','img','9_Foto_Satao',1,{
		create_node('6_botao_Perfil','img','9_Foto_Satao',1,{
			create_node('Lalala','txt','9_Foto_Satao'),
			create_node('Lorem ipsum lorem ipsum lorem ipsum','txt','9_Foto_Satao'),
			create_node('Lorem ipsum lorem ipsum lorem ipsum','txt','9_Foto_Satao')}),
		create_node('7_botao_Galeria','img','9_Foto_Satao',1,{
			create_node('1 Lorem ipsum lorem ipsum lorem ipsum','txt','9_Foto_Satao'),
			create_node('2 Lorem ipsum lorem ipsum lorem ipsum','txt','9_Foto_Satao')})
			}
		),
	create_node('2a_botao_Toys','img','10_Foto_Toys',1,{
		create_node('6_botao_Perfil','img','10_Foto_Toys',1,{
			create_node('(a) Lorem ipsum lorem ipsum lorem ipsum','txt','10_Foto_Toys'),
			create_node('(b) Lorem ipsum lorem ipsum lorem ipsum','txt','10_Foto_Toys')}),
		create_node('7_botao_Galeria','img','10_Foto_Toys',1,{
			create_node('(1) Lorem ipsum lorem ipsum lorem ipsum','txt','10_Foto_Toys'),
			create_node('(2) Lorem ipsum lorem ipsum lorem ipsum','txt','10_Foto_Toys')})}),
	create_node('2b_botao_Siren','img','11_Foto_Siren',1,{
		create_node('6_botao_Perfil','img','11_Foto_Siren',1,{
			create_node('(a) Lorem ipsum lorem ipsum lorem ipsum','txt','11_Foto_Siren'),
			create_node('(b) Lorem ipsum lorem ipsum lorem ipsum','txt','11_Foto_Siren')}),
		create_node('7_botao_Galeria','img','11_Foto_Siren',1,{
			create_node('(1) Lorem ipsum lorem ipsum lorem ipsum','txt','11_Foto_Siren'),
			create_node('(2) Lorem ipsum lorem ipsum lorem ipsum','txt','11_Foto_Siren')})}),
	create_node('2b_botao_Omik','img','12_Foto_Omik',1,{
		create_node('6_botao_Perfil','img','12_Foto_Omik',1,{
			create_node('(a) Lorem ipsum lorem ipsum lorem ipsum','txt','12_Foto_Omik'),
			create_node('(b) Lorem ipsum lorem ipsum lorem ipsum','txt','12_Foto_Omik')}),
		create_node('7_botao_Galeria','img','12_Foto_Omik',1,{
			create_node('(1) Lorem ipsum lorem ipsum lorem ipsum','txt','12_Foto_Omik'),
			create_node('(2) Lorem ipsum lorem ipsum lorem ipsum','txt','12_Foto_Omik')})})
	})
}

img_sizes = {
			{name="2a_botao_Satao",W=253,H=108},
			{name="2a_botao_Toys",W=253,H=107},
			{name="2b_botao_Omik",W=253,H=107},
			{name="2b_botao_Siren",W=253,H=108},
			{name="6_botao_Perfil",W=253,H=108},
			{name="7_botao_Galeria",W=253,H=107},
			{name="8_botao_Links",W=253,H=107},
			{name="9_Foto_Satao",W=206,H=573},
			{name="10_Foto_Toys",W=206,H=565},
			{name="11_Foto_Siren",W=206,H=565},
			{name="12_Foto_Omik",W=206,H=565},
			}


--[[app_tree = {level=1, root=create_node('root', 'root', 1,{
	create_node('BTN_1','img',1,{
		create_node('BTN_1_1','img',1,{
			create_node('BTN_1_1_11','img', 1,{create_node('Movie about diabetes','txt'),
												create_node('http://gingadf.com.br/globalitv/Diabetes_narrativa_ingles.mp4','qrcode')}),
			create_node('BTN_1_1_1','img', 1,{create_node(':: Thirst\n:: Excessive night urination\n:: Leg pain\n:: Fatigue\n:: Paralysis\n:: Weakness\n:: Weight gain','txt')}),
			create_node('BTN_1_1_10','img',1,{create_node(':: Fasting blood sugar test\n:: Oral glucose tolerance test (glycemic curve test)','txt')}),
			create_node('BTN_1_1_3','img', 1,{create_node(':: Law 11347\n   Free medicine distribution\n:: Law 7713\n   Income tax exemption','txt')}),
			create_node('BTN_1_1_2','img', 1,{create_node(':: Metformin hydrochloride (500 mg)\n:: Extended action metformin hydrochloride (500 mg)\n:: Metformin hydrochloride (800 mg)\n:: Glibenclamide (5 mg)\n:: NPH human insulin (100 UI/mL)\n:: Regular human insulin (100 UI/mL)','txt')}),
			create_node('BTN_1_1_4','img', 1,{create_node('Belém:\n   :: Hospital Saúde da Mulher\n   :: Instituto da Mulher','txt')}),
			create_node('BTN_1_1_5','img', 1,{
				create_node('Micro_regioes/Para_microrregiao_Belem','img',1,{
					create_node('Ananindeua',  'txt', 1,{create_node(':: Hospital Metropolitano de Urgência e Emergência\n:: UDI','txt')}),
					create_node('Belém',       'txt', 1,{create_node(':: CCI Nefro\n:: Clínica do Rim\n:: Hospital D. Luiz I\n:: Hospital Ophir Loyola\n:: Hospital Ordem Terceira\n:: Hospital Universitário João de Barros Barreto\n:: Nefroclinica\n:: Santa Casa de Misericórdia do Pará','txt')}),
					create_node('Marituba',    'txt', 1,{create_node(':: Hospital da Divina Providencia','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Altamira','img',1,{
					create_node('Altamira',    'txt', 1,{create_node(':: Hospital Regional Público da Transamazônica','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Bragantina','img',1,{
					create_node('Bragança',    'txt', 1,{create_node(':: Hospital Santo Antonio Maria Zacarias','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Castanhal','img',1,{
					create_node('Castanhal',   'txt', 1,{create_node(':: CNC Clínica de Nefrologia de Castanhal','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Maraba','img',1,{
					create_node('Marabá',      'txt', 1,{create_node(':: Clínica de Doenças Renais do Carajás CDR','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Paragominas','img',1,{
					create_node('Ulianópolis', 'txt', 1,{create_node(':: Hospital São Francisco','txt')})
				}),
				create_node('Micro_regioes/Para_microrregiao_Redencao','img',1,{
					create_node('Redenção',    'txt', 1,{create_node(':: Hospital Regional Público do Araguaia','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Santarem','img',1,{
					create_node('Santarém',    'txt', 1,{create_node(':: Hospital Municipal de Santarém\n:: Hospital Regional do Baixo Amazonas do Pará Dr Waldemar Penna','txt')}),
				})
			}),
			create_node('BTN_1_1_8','img', 1,{create_node('Belém: Assistance Program for the Diabetic and the Hypertense at Hospital Universitário João de Barros Barreto (HUJBB)','txt')}),
			create_node('BTN_1_1_9','img', 1,{create_node('November 14: World Diabetes Day','txt'),
												create_node('http://www.idf.org/wdd-index','qrcode')})}
		),
		create_node('BTN_1_2','img',1,{
			create_node('BTN_1_1_1','img', 1,{create_node(':: Headaches\n:: Vomit\n:: Shortness of breath\n:: Agitation\n:: Blurred vision','txt')}),
			create_node('BTN_1_1_10','img', 1,{create_node(':: Indirect blood pressure measurement\n:: Ambulatory blood pressure measurement\n:: Home blood pressure measurement\n:: Self blood pressure measurement','txt')}),
			create_node('BTN_1_2_4','img', 1,{create_node(':: Regularly measure blood pressure\n:: Practice physical activities\n:: Maintain proper weight\n:: Adopt healthy eating\n:: Consume more fruits and vegetables\n:: Reduce salt consumption\n:: Avoid alcohol and cigarettes','txt')}),
			create_node('BTN_1_1_3','img', 1,{create_node(':: Law 11347\n   Free medicine distribution\n:: Law 7713\n   Income tax exemption','txt')}),
			create_node('BTN_1_1_2','img', 1,{create_node(':: Captopril (25 mg)\n:: Enalapril maleate (10 mg)\n:: Propanolol hydrochloride (40 mg)\n:: Atenolol (25 mg)\n:: Hydrochlorothiazide (25 mg)\n:: Losartan potassium (50 mg)','txt')}),
			create_node('BTN_1_1_8','img', 1,{create_node('Belém: Assistance Program for the Diabetic and the Hypertense at Hospital Universitário João de Barros Barreto (HUJBB)','txt')}),
			create_node('BTN_1_1_9','img', 1,{create_node(':: May 17: World Hypertension Day\n:: April 26: National Day for Prevention and Fight Against Hypertension','txt')})}
		),
		create_node('BTN_1_3','img',1,{
			create_node('BTN_1_1_1','img', 1,{create_node(':: Shortness of breath\n:: Difficulty breathing\n:: Tight feeling in the chest\n:: Wheezing\n:: Coughing','txt')}),
			create_node('BTN_1_1_10','img', 1,{create_node(':: Symptom analysis\n:: Spirometry exam\n:: Chest x-ray','txt')}),
			create_node('BTN_1_3_4','img', 1,{create_node(':: Avoid rugs, carpets and curtains\n:: Keep environment hygiene\n:: Use anti-allergic bedding\n:: Adopt healthy eating\n:: Drink plenty of water\n:: Avoid close contact with animals\n:: Avoid sweeping - use a damp cloth or a vacuum cleaner\n:: Avoid smoke and other strong smells','txt')}),
			create_node('BTN_1_1_3','img', 1,{create_node(':: Law 11347\n   Free medicine distribution\n:: Law 7713\n   Income tax exemption','txt')}),
			create_node('BTN_1_1_2','img', 1,{create_node(':: Ipratropium bromide\n:: Beclomethasone dipropionate\n:: Salbutamol sulphate','txt')}),
			create_node('BTN_1_3_6','img', 1,{
				create_node('Micro_regioes/Para_microrregiao_Belem','img',1,{
					create_node('Ananindeua',           'txt', 1,{create_node(':: Hospital Metropolitano de Urgência e Emergência','txt')}),
					create_node('Belém',                'txt', 1,{create_node(':: Centro de Saúde do Outeiro\n:: Hospital D Luiz I\n:: Hospital Ordem Terceira\n:: Hospital Samaritano\n:: Hospital Universitário Bettina Ferro de Souza\n:: Hospital Universitário Joao de Barros Barreto\n:: J M Direito Alvares\n:: Sarah Pará\n:: Unidade Municipal de Saúde do Tapaná','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Altamira','img',1,{
					create_node('Medicilândia',         'txt', 1,{create_node(':: Unidade Mista de Saúde de Medicilândia','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Bragantina','img',1,{
					create_node('Capanema',             'txt', 1,{create_node(':: Saúde Center Hospital e Maternidade\n:: Unidade de Pronto Atendimento Josiel Rodrigues Martins','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Cameta','img',1,{
					create_node('Cametá',               'txt', 1,{create_node(':: Clínica Master Diagnósticos\n:: Hospital Regional de Cameta','txt')}),
					create_node('Oeiras do Pará',       'txt', 1,{create_node(':: Hospital Municipal de Oeiras do Pará','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Conceicao_do_Araguaia','img',1,{
					create_node('Floresta do Araguaia', 'txt', 1,{create_node(':: Hospital Municipal de Floresta do Araguaia','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Furos_de_Breves','img',1,{
					create_node('Anajás',               'txt', 1,{create_node(':: Hospital Municipal de Anajás','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Guama','img',1,{
					create_node('Mãe do Rio',           'txt', 1,{create_node(':: Unidade Saúde da Família de Mãe do Rio','txt')}),
					create_node('Viseu',                'txt', 1,{create_node(':: Hospital Das Bem Aventuranças HBA','txt')})
				}),
				create_node('Micro_regioes/Para_microrregiao_Maraba','img',1,{
					create_node('Marabá',               'txt', 1,{create_node(':: Hospital Regional do Sudeste do Pará Dr. Geraldo Veloso','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Obidos','img',1,{
					create_node('Oriximiná',            'txt', 1,{create_node(':: Hospital Municipal de Oriximina','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Paragominas','img',1,{
					create_node('Paragominas',          'txt', 1,{create_node(':: Hospital Municipal de Paragominas\n:: Hospital Regional Público do Leste do Pará\n:: UPA Paragominas Solange Maria do Nascimento Melo','txt')}),
					create_node('Ulianópolis',          'txt', 1,{create_node(':: Hospital São Francisco','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Parauapebas','img',1,{
					create_node('Parauapebas',          'txt', 1,{create_node(':: Hospital Municipal Dr. Teófilo Soares de Almeida Filho ','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Redencao','img',1,{
					create_node('Pau D\'arco',          'txt', 1,{create_node(':: Hospital Municipal Enfermeira Antônia Pinheiro Cavalcante','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Salgado','img',1,{
					create_node('Curuçá',               'txt', 1,{create_node(':: Consulab','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Santarem','img',1,{
					create_node('Alenquer',             'txt', 1,{create_node(':: Hospital Santo Antônio','txt')}),
					create_node('Santarém',             'txt', 1,{create_node(':: Hospital e Maternidade Sagrada Família\n:: Hospital Municipal de Santarém\n:: Hospital Regional do Baixo Amazonas do Pará Dr. Waldemar Penna','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Sao_Felix_do_Xingu','img',1,{
					create_node('São Félix do Xingu',   'txt', 1,{create_node(':: Hospital e Maternidade São Lucas','txt')}),
				}),
				create_node('Micro_regioes/Para_microrregiao_Tucurui','img',1,{
					create_node('Tucuruí',              'txt', 1,{create_node(':: Imimi','txt')}),
				})
			}),
			create_node('BTN_1_1_9','img', 1,{create_node(':: Law 8398 - asthma prevention in the municipal health network\n:: June 21: National Asthma Combat Day','txt')})}
		)}),
	create_node('BTN_2','img',1,{
		create_node('BTN_2_1','img',1,{
			create_node('BTN_2_1_1','img',1,{create_node('cnes2.datasus.gov.br/Mod_Ind_Leitos_Listar.asp?VCod_Leito=43&VTipo_Leito=4&VListar=1&VEstado=15&VMun=&VComp=','url')}),
			create_node('BTN_2_1_2','img',1,{create_node('cnes2.datasus.gov.br/Mod_Ind_Leitos_Listar.asp?VCod_Leito=10&VTipo_Leito=4&VListar=1&VEstado=15&VMun=&VComp=','url')}),
			create_node('BTN_2_1_3','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Especialidades_Listar.asp?VTipo=139&VListar=1&VEstado=15&VMun=&VComp=&VTerc=&VServico=&VClassificacao=&VAmbu=&VAmbuSUS=&VHosp=&VHospSus=','url')}),
			create_node('BTN_2_1_4','img',1,{create_node('cnes2.datasus.gov.br/Mod_Ind_Habilitacoes_Listar.asp?VTipo=1402&VListar=1&VEstado=15&VMun=&VComp=&VContador=1&VTitulo=H','url')}),
			create_node('BTN_2_1_5','img',1,{
				create_node('BTN_2_1_5_1','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Leitos_Listar.asp?VCod_Leito=80&VTipo_Leito=3&VListar=1&VEstado=15&VMun=&VComp=','url')}),
				create_node('BTN_2_1_5_2','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Leitos_Listar.asp?VCod_Leito=81&VTipo_Leito=3&VListar=1&VEstado=15&VMun=&VComp=','url')}),
				create_node('BTN_2_1_5_3','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Leitos_Listar.asp?VCod_Leito=82&VTipo_Leito=3&VListar=1&VEstado=15&VMun=&VComp=','url')})
			})}
		),
		create_node('BTN_2_2','img',1,{
			create_node('BTN_2_2_1','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Habilitacoes_Listar.asp?VTipo=1404&VListar=1&VEstado=15&VMun=&VComp=&VContador=11&VTitulo=H','url')}),
			create_node('BTN_2_2_2','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Leitos_Listar.asp?VCod_Leito=45&VTipo_Leito=5&VListar=1&VEstado=15&VMun=&VComp=','url')}),
			create_node('BTN_2_2_3','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Leitos_Listar.asp?VCod_Leito=68&VTipo_Leito=5&VListar=1&VEstado=15&VMun=&VComp=','url')}),
			create_node('BTN_2_2_4','img',1,{
				create_node('BTN_2_1_5_1','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Leitos_Listar.asp?VCod_Leito=77&VTipo_Leito=3&VListar=1&VEstado=15&VMun=&VComp=','url')}),
				create_node('BTN_2_1_5_2','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Leitos_Listar.asp?VCod_Leito=78&VTipo_Leito=3&VListar=1&VEstado=15&VMun=&VComp=','url')}),
				create_node('BTN_2_1_5_3','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Leitos_Listar.asp?VCod_Leito=79&VTipo_Leito=3&VListar=1&VEstado=15&VMun=&VComp=','url')})
			})}
		),
		create_node('BTN_2_3','img',1,{
			create_node('BTN_2_3_1','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Especialidades_Listar.asp?VTipo=127&VListar=1&VEstado=15&VMun=&VComp=&VTerc=&VServico=&VClassificacao=&VAmbu=&VAmbuSUS=&VHosp=&VHospSus=','url')}),
			create_node('BTN_2_3_2','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Habilitacoes_Listar.asp?VTipo=0202&VListar=1&VEstado=15&VMun=&VComp=&VContador=19&VTitulo=H','url')})}
		),
	}),
	create_node('BTN_3','img',1,{
		create_node('BTN_3_1','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Especialidades_Listar.asp?VTipo=149&VListar=1&VEstado=15&VMun=&VComp=&VTerc=&VServico=&VClassificacao=&VAmbu=&VAmbuSUS=&VHosp=&VHospSus=','url')}),
		create_node('BTN_3_2','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Especialidades_Listar.asp?VTipo=125&VListar=1&VEstado=15&VMun=&VComp=&VTerc=&VServico=&VClassificacao=&VAmbu=&VAmbuSUS=&VHosp=&VHospSus=','url')}),
		create_node('BTN_3_3','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Especialidades_Listar.asp?VTipo=103&VListar=1&VEstado=15&VMun=&VComp=&VTerc=&VServico=&VClassificacao=&VAmbu=&VAmbuSUS=&VHosp=&VHospSus=','url')}),
		create_node('BTN_3_4','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Especialidades_Listar.asp?VTipo=113&VListar=1&VEstado=15&VMun=&VComp=&VTerc=&VServico=&VClassificacao=&VAmbu=&VAmbuSUS=&VHosp=&VHospSus=','url')}),
		create_node('BTN_3_5','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Especialidades_Listar.asp?VTipo=115&VListar=1&VEstado=15&VMun=&VComp=&VTerc=&VServico=&VClassificacao=&VAmbu=&VAmbuSUS=&VHosp=&VHospSus=','url')}),
		create_node('BTN_3_6','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Habilitacoes_Listar.asp?VTipo=6001&VListar=1&VEstado=15&VMun=&VComp=&VContador=11&VTitulo=F','url')}),
		create_node('BTN_3_7','img',1,{create_node('http://cnes2.datasus.gov.br/Mod_Ind_Especialidades_Listar.asp?VTipo=134&VListar=1&VEstado=15&VMun=&VComp=&VTerc=&VServico=&VClassificacao=&VAmbu=&VAmbuSUS=&VHosp=&VHospSus=','url')})})
	})
}

img_sizes = {
			{name="APP_LOGO",W=244,H=147},
			{name="ARROW_DOWN",W=40,H=56},
			{name="ARROW_LEFT",W=56,H=40},
			{name="ARROW_RIGHT",W=56,H=40},
			{name="ARROW_UP",W=40,H=56},
			{name="BTN_1",W=158,H=123},
			{name="BTN_1_1",W=158,H=123},
			{name="BTN_1_1_11",W=123,H=123},
			{name="BTN_1_1_1",W=123,H=123},
			{name="BTN_1_1_10",W=123,H=123},
			{name="BTN_1_1_2",W=123,H=123},
			{name="BTN_1_1_3",W=123,H=123},
			{name="BTN_1_1_4",W=123,H=123},
			{name="BTN_1_1_5",W=123,H=123},
			{name="BTN_1_1_6",W=123,H=123},
			{name="BTN_1_1_7",W=123,H=123},
			{name="BTN_1_1_8",W=123,H=123},
			{name="BTN_1_1_9",W=123,H=123},
			{name="BTN_1_2",W=158,H=123},
			{name="BTN_1_2_1",W=123,H=123},
			{name="BTN_1_2_2",W=123,H=123},
			{name="BTN_1_2_4",W=123,H=123},
			{name="BTN_1_2_5",W=123,H=123},
			{name="BTN_1_3",W=158,H=123},
			{name="BTN_1_3_4",W=123,H=123},
			{name="BTN_1_3_6",W=123,H=123},
			{name="BTN_2",W=158,H=123},
			{name="BTN_2_1",W=158,H=123},
			{name="BTN_2_1_1",W=123,H=123},
			{name="BTN_2_1_2",W=123,H=123},
			{name="BTN_2_1_3",W=123,H=123},
			{name="BTN_2_1_4",W=123,H=123},
			{name="BTN_2_1_5",W=123,H=123},
			{name="BTN_2_1_5_1",W=123,H=123},
			{name="BTN_2_1_5_2",W=123,H=123},
			{name="BTN_2_1_5_3",W=123,H=123},
			{name="BTN_2_2",W=158,H=123},
			{name="BTN_2_2_1",W=123,H=123},
			{name="BTN_2_2_2",W=123,H=123},
			{name="BTN_2_2_3",W=123,H=123},
			{name="BTN_2_2_4",W=123,H=123},
			{name="BTN_2_3",W=158,H=123},
			{name="BTN_2_3_1",W=123,H=123},
			{name="BTN_2_3_2",W=123,H=123},
			{name="BTN_3",W=158,H=123},
			{name="BTN_3_1",W=123,H=123},
			{name="BTN_3_2",W=123,H=123},
			{name="BTN_3_3",W=123,H=123},
			{name="BTN_3_4",W=123,H=123},
			{name="BTN_3_5",W=123,H=123},
			{name="BTN_3_6",W=123,H=123},
			{name="BTN_3_7",W=123,H=123},
			{name="BTN_MENU",W=138,H=48},
			{name="BTN_MOVIE",W=138,H=48},
			{name="BTN_STOP",W=138,H=48},
			{name="BTN_movie1",W=123,H=123},
			{name="BTN_movie2",W=123,H=123},
			{name="BTN_movie3",W=123,H=123},
			{name="BTN_movie4",W=123,H=123},
			{name="BTN_movie5",W=123,H=123},
			{name="BTN_movie6",W=123,H=123},
			{name="Micro_regioes/Para_microrregiao_Almeirim", W=140,H=101},
			{name="Micro_regioes/Para_microrregiao_Altamira", W=326,H=169},
			{name="Micro_regioes/Para_microrregiao_Arari", W=355,H=169},
			{name="Micro_regioes/Para_microrregiao_Belem", W=323,H=135},
			{name="Micro_regioes/Para_microrregiao_Bragantina", W=356,H=271},
			{name="Micro_regioes/Para_microrregiao_Cameta", W=291,H=169},
			{name="Micro_regioes/Para_microrregiao_Castanhal", W=308,H=135},
			{name="Micro_regioes/Para_microrregiao_Conceicao_do_Araguaia", W=243,H=169},
			{name="Micro_regioes/Para_microrregiao_Furos_de_Breves", W=322,H=135},
			{name="Micro_regioes/Para_microrregiao_Guama", W=392,H=271},
			{name="Micro_regioes/Para_microrregiao_Itaituba", W=252,H=169},
			{name="Micro_regioes/Para_microrregiao_Maraba", W=248,H=203},
			{name="Micro_regioes/Para_microrregiao_Obidos", W=196,H=135},
			{name="Micro_regioes/Para_microrregiao_Paragominas", W=370,H=169},
			{name="Micro_regioes/Para_microrregiao_Parauapebas", W=372,H=135},
			{name="Micro_regioes/Para_microrregiao_Portel", W=173,H=101},
			{name="Micro_regioes/Para_microrregiao_Redencao", W=333,H=169},
			{name="Micro_regioes/Para_microrregiao_Salgado", W=390,H=237},
			{name="Micro_regioes/Para_microrregiao_Santarem", W=301,H=169},
			{name="Micro_regioes/Para_microrregiao_Sao_Felix_do_Xingu", W=354,H=135},
			{name="Micro_regioes/Para_microrregiao_TomeAcu", W=274,H=135},
			{name="Micro_regioes/Para_microrregiao_Tucurui", W=302,H=135},
			}
]]