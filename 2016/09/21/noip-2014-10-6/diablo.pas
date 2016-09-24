uses math;
type int=longint;
var 
	p,c:array[0..110] of int;
	w:array[0..110,0..51] of int;
	f:array[0..110,0..1010] of int;
	g:array[0..110] of int;
	n,m,i,j,k,ans:int;

begin
	assign(input,'diablo.in');reset(input);
	assign(output,'diablo.out');rewrite(output);
	read(n,m);
	for i:=1 to n do begin
		read(c[i],p[i]);
		for j:=1 to p[i] do read(w[i,j]);
	end;
	f[0,0]:=0;
	for i:=1 to n do
		for j:=0 to m do
			for k:=0 to min(j div c[i],p[i]) do
				f[i,j]:=max(f[i,j],f[i-1,j-k*c[i]]+w[i,k]);
	ans:=0;
	for i:=1 to m do
		if f[n,i]>ans then begin
			ans:=f[n,i];j:=i;
		end;
	for i:=n downto 1 do
		for k:=0 to min(j div c[i],p[i]) do
			if f[i,j]=f[i-1,j-k*c[i]]+w[i,k] then begin
				g[i]:=k;j:=j-k*c[i];break;
			end;
	writeln(ans);
	for i:=1 to n do writeln(g[i]);
	close(input);close(output);
end.
