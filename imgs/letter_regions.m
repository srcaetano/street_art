letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqsrtuvwxyz1234567890!@#$%&*()-_+=[]{};:.,<>?/\\|\"'ÁÉÍÓÚÀÂÊÔÃÇáéíóúàâêôãç";

[a,b,c] = imread('Stencil_std_24.png');
[H W CHN] = size(a);

x = [1; 1];
lx = [];
sc = sum(c,1)>0; %a = (a>0)|(c>0);
k=0;
k_double = strfind(letters,'"');
while x(1)<=length(sc)
	k=k+1;
	while sc(x(1)) == 0
		x(1) = x(1)+1;
	end
	x(2) = x(1);
	
	while sc(x(2)) > 0
		x(2) = x(2)+1;
		if x(2) > length(sc)
			break;
		end
	end
	if k==k_double
		while sc(x(2)) == 0
			x(2) = x(2)+1;
		end
		while sc(x(2)) > 0
			x(2) = x(2)+1;
			if x(2) > length(sc)
				break;
			end
		end
	end
	x(2) = x(2)-1;
	lx = [lx x];
	%c(:,x(1):x(2))
	x(1) = x(2)+1;
end
%length(lx)
s=lx(1,2:end)-lx(2,1:end-1)-1;
space_width = round(mean(s));
lx(2,1:end-1) = lx(2,1:end-1) + (s-space_width).*(s>space_width);
%length(lx)
l_start = lx(1,:)-1;
l_width = lx(2,:)-lx(1,:)+1;
if 1
	printf('l_start = {')
	printf('%d,',l_start)
	printf('}\n')
	printf('l_width = {')
	printf('%d,',l_width)
	printf('}\n')
else
	pos_acentos = strfind(letters,'ÁÉÍÓÚÀÂÊÔÃÇáéíóúàâêôãç');
	l = 1:(pos_acentos-1);
	printf('l_start = {')
	printf('%d,',lx(1,l)-1)
	printf('}\n')
	printf('l_width = {')
	printf('%d,',lx(2,l)-lx(1,l)+1)
	printf('}\n')
	l = pos_acentos:length(lx);
	printf('a_start = {')
	printf('%d,',lx(1,l)-1)
	printf('}\n')
	printf('a_width = {')
	printf('%d,',lx(2,l)-lx(1,l)+1)
	printf('}\n')
end