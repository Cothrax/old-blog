uses math;
type int=longint;
var 
	f:array[0..1,0..410,0..410] of int;
	l,u:array[0..410,0..410] of int;
	a:array[0..410,0..410] of char;
	n,m,i,p,c,j,k,t1,t2,ans:int;

begin
	assign(input,'stol.in');reset(input);
	assign(output,'stol.out');rewrite(output);
	readln(n,m);
	for i:=1 to n do begin
		for j:=1 to m do read(a[i,j]);
		readln;
	end;
	for i:=1 to n do
		for j:=1 to m do
			if a[i,j]='X' then begin
				l[i,j]:=0;u[i,j]:=0;
			end else begin
				l[i,j]:=l[i,j-1]+1;
				u[i,j]:=u[i-1,j]+1;
			end;
	ans:=0;
	for i:=1 to n do begin
		c:=i and 1;p:=c xor 1;
		fillchar(f[c],sizeof(f[c]),0);
		for j:=1 to m do
			for k:=1 to u[i,j] do begin
				t1:=f[c,j-1,k]+1;
				t2:=min(f[p,j,k-1],l[i,j]);
				f[c,j,k]:=max(t1,t2);
				ans:=max(ans,f[c,j,k]*2+k*2);
			end;
	end;
	write(ans-1);
	close(input);close(output);
end.
