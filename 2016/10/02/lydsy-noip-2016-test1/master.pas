uses math;
type int=longint;
var 
	a,b:ansistring;
	n,m,i,j,k,p,c,ans:int;
	f:array[0..1,0..310,0..310] of int;

begin
	//assign(input,'master.in');reset(input);
	//assign(output,'master.out');rewrite(output);
	readln(n,m);readln(a);readln(b);
	ans:=0;
	for i:=1 to n do
		for j:=1 to n do begin
			if a[i]=b[j] then f[0,i,j]:=f[0,i-1,j-1]+1
			else f[0,i,j]:=0;
			ans:=max(ans,f[0,i,j]);
		end;
	for k:=1 to m do begin
		c:=k and 1;p:=c xor 1;
		fillchar(f[c],sizeof(f[c]),0);
		for i:=1 to n do
			for j:=1 to n do begin
				f[c,i,j]:=f[p,i-1,j-1]+1;
				if a[i]=b[j] then 
					f[c,i,j]:=max(f[c,i,j],f[c,i-1,j-1]+1);
				ans:=max(ans,f[c,i,j]);
			end;
	end;
	write(ans);
	//close(input);close(output);
end.
