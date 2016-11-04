uses math;
type int=longint;ll=int64;
const md=123456789;mx=5000;
var
	f,s,g:array[-1..mx*2+10] of int;
	n,i,j:int;

begin
	assign(input,'raviel.in');reset(input);
	assign(output,'raviel.out');rewrite(output);
	read(n);f[1]:=1;s[0]:=0;
	for i:=2 to n do f[i]:=(f[i-1]+f[i-2]) mod md;
	for i:=1 to n do s[i]:=(s[i-1]+f[i]) mod md;
	for i:=1 to n-1 do g[i]:=ll(s[n-2-i]+1)*ll(f[i-1]) mod md;
	f[-1]:=1;
	for i:=1 to n-1 do
		for j:=1 to n-1 do
			g[i+j]:=(ll(g[i+j])+(ll(f[i-2])*ll(f[j-1])mod md)*
				ll(s[n-1-max(i,j)]))mod md;
	for i:=1 to n*2 do write(g[i],' ');
	close(input);close(output);
end.
