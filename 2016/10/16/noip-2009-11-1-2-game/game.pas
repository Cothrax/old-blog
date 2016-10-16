type int=longint;
var 
	p:array[0..1010] of boolean;
	a:array[0..1010] of int;
	f:array[0..1010] of int64;
	n,m,i,j,k:int;ans:int64;

begin
	assign(input,'game.in');reset(input);
	assign(output,'game.out');rewrite(output);
	read(n);m:=0;
	for i:=2 to n do
		if not p[i] then begin
			inc(m);a[m]:=i;
			j:=i*2;
			while j<=n do begin
				p[j]:=true;inc(j,i);
			end;
		end;
	f[0]:=1;
	//j-k*a[i]>=0 -> k<=j/a[i]
	for i:=1 to m do
		for j:=n downto 1 do begin
			k:=a[i];
			while k<=j do begin
				inc(f[j],f[j-k]);k:=k*a[i];
			end;
		end;
	ans:=0;
	for i:=0 to n do inc(ans,f[i]);
	write(ans);
	close(input);close(output);
end.
