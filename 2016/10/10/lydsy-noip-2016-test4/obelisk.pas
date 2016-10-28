type int=longint;
const mx=1 shl 17-1;inf:int64=1000000007;
var
	g:array[0..20,0..20] of int;
	num,b,a:array[0..mx] of int;
	f:array[0..mx] of int64;
	bin:array[0..400] of int64;
	n,m,t,i,j,k,l,u,v,r:int;
begin
	assign(input,'obelisk.in');reset(input);
	assign(output,'obelisk.out');rewrite(output);
	read(n,m);t:=1 shl n-1;
	for i:=1 to m do begin
		read(u,v);g[u,v]:=1;
	end;
	bin[0]:=1;num[0]:=-1;f[0]:=1;
	for i:=1 to sqr(n) do bin[i]:=bin[i-1]*2 mod inf;
	for i:=1 to t doa num[i]:=num[i and(i-1)]*(-1);
	for i:=0 to t-1 do begin
		j:=i;
		while j>0 do begin
			k:=round(ln(j and (-j))/ln(2))+1;
			for l:=1 to n do inc(a[bin[l-1]],g[k,l]);
			j:=j and(j-1);
		end;
		r:=t xor i;j:=r;b[0]:=0;
		repeat
			j:=(j-1)and r;k:=j xor r;
			b[k]:=b[k and(k-1)]+a[k and(-k)];
			f[i or k]:=(f[i or k]+num[k]*bin[b[k]]*f[i])mod inf;
		until j=0;
		for l:=1 to n do a[bin[l-1]]:=0;
	end;
	write(f[t]);
	close(input);close(output);
end.
