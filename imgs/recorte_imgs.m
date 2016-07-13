clc; close all; clear;

t=[];
for j = 7
	switch j
		case 1
			n = '2a_botao_Satao';
			x0 = 43;
			y0 = 38;
		case 2
			n = '2a_botao_Toys';
			x0 = 59;
			y0 = 42;
		case 3
			n = '2b_botao_Omik';
			x0 = 58;
			y0 = 42;
		case 4
			n = '2b_botao_Siren';
			x0 = 45;
			y0 = 43;
		case 5
			n = '6_botao_Perfil';
			x0 = 40;
			y0 = 45;
		case 6
			n = '7_botao_Galeria';
			x0 = 27;
			y0 = 45;
		case 7
			n = '8_botao_Links';
			x0 = 50;
			y0 = 43;
	end
	[a1,b1,c1]=imread([n '_branco.png']);
	[a3,b3,c3]=imread([n '_Ativo.png']);
	a2 = zeros(size(a3,1),size(a3,2));
	c2 = a2;
	a2(y0+[1:size(a1,1)],x0+[1:size(a1,2)]) = a1(:,:,1);
	c2(y0+[1:size(a1,1)],x0+[1:size(a1,2)]) = c1(:,:);
	imwrite(a2,[n '.png'],'Alpha',c2);
	imwrite(a3(:,:,1),[n '_FOCUS.png'],'Alpha',c3);
	system(['open ' n '.png']);
	system(['open ' n '_FOCUS.png']);
	t=[t '{name="' n '",W=' num2str(size(a2,2)) ',H=' num2str(size(a2,1)) '},' 10];
end
disp(t)
