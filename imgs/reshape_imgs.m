
imgs = {'2a_botao_Satao', '2a_botao_Toys', '2b_botao_Omik', '2b_botao_Siren', ...
		'6_botao_Perfil', '7_botao_Galeria', '8_botao_Links', ...
		'2a_botao_Satao_FOCUS', '2a_botao_Toys_FOCUS', '2b_botao_Omik_FOCUS', ...
		'2b_botao_Siren_FOCUS', '6_botao_Perfil_FOCUS', '7_botao_Galeria_FOCUS', ...
		'8_botao_Links_FOCUS'};

for j = 1:length(imgs)
	system(['convert ' imgs{j} '.png -resize 67% ' imgs{j} '.png']);
end

imgs = {'9_Foto_Satao', '10_Foto_Toys', '11_Foto_Siren', '12_Foto_Omik'};

for j = 1:length(imgs)
	system(['convert ' imgs{j} '.png -resize 80% ' imgs{j} '.png']);
end
