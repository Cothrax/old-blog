uses math;
type int=longint;
const inf=1000000000;
var 
	a:array[0..310,0..310] of int;
	mn:array[0..310] of int;
	s:array[0..310,0..1] of int;
	ans:array[0..100010] of int;
	n,m,i,j,k:longint;

procedure cal();
var t,i:int;
begin
	t:=0;s[0,1]:=0;
	for i:=1 to n do begin
		while (t>0) and (s[t,0]>mn[i]) do begin
			inc(ans[s[t,0]],(s[t,1]-s[t-1,1])*(i-s[t,1]));
			dec(t);
		end;
		inc(t);s[t,0]:=mn[i];s[t,1]:=i;
	end;
	while t>0 do begin
		inc(ans[s[t,0]],(s[t,1]-s[t-1,1])*(n+1-s[t,1]));
		dec(t);
	end;
end;

begin
	assign(input,'submatrix.in');reset(input);
	assign(output,'submatrix.out');rewrite(output);
	read(n,m);
	for i:=1 to n do
		for j:=1 to m do read(a[i,j]);
	for i:=1 to m do begin
		filldword(mn,sizeof(mn) div 4,inf);
		for j:=i to m do begin
			for k:=1 to n do
				mn[k]:=min(mn[k],a[k,j]);
			cal();
		end;
	end;
	for i:=1 to m*n do writeln(ans[i]);
	close(input);close(output);
end.
