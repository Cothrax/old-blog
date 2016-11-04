type int=longint;ll=int64;
const
	md=123456789;mx=5000;
	nxt:array[0..2] of int=(1,2,0);
var
	f,g:array[0..2,-2..mx*2+10] of int;
	n,i,j,k,i0,i1,i2:int;

begin
	assign(input,'raviel.in');reset(input);
	assign(output,'raviel.ans');rewrite(output);
	read(n);
	i0:=2;i1:=1;i2:=0;
	for i:=1 to n-2 do begin
		i0:=nxt[i0];i1:=nxt[i1];i2:=nxt[i2];
		for j:=1 to i do f[i0,j]:=0;
		//calc f[i0]
		for j:=1 to i do
			f[i0,j]:=(f[i1,j-1]+f[i2,j-2])mod md;
		f[i0,1]:=(f[i0,1]+1)mod md;
		//calc g[i0]
		for j:=1 to i*2 do
			g[i0,j]:=(f[i1,j-2]+f[i2,j-1]+g[i1,j]+g[i2,j])mod md;
		for j:=1 to i*2 do
			for k:=1 to i*2-j do
				g[i0,j+k+3]:=(ll(g[i0,j+k+3])+
					ll(f[i1,j])*ll(f[i2,k]))mod md;
	end;
	for j:=1 to 2*n do g[i0,j]:=(g[i0,j]+f[i0,j-1])mod md;
	for i:=1 to 2*n do write(g[i0,i],' ');
	close(input);close(output);
end.
