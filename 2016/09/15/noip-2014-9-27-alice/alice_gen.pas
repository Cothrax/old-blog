uses math;
type int=longint;
var 
	g:array[0..41,0..41] of boolean;
	a,s:array[0..41] of int;
	n,m,i,j,x,y:int;

procedure flip(x:int);
var i:int;
begin
	s[x]:=s[x] xor 1;
	a[x]:=a[x] xor 1;
	for i:=1 to n do
		if g[x,i] then a[i]:=a[i] xor 1;
end;
	
begin
	assign(output,'alice.in');rewrite(output);
	randomize;
	n:=random(40)+1;m:=min(n*2,random(400));
	for i:=1 to n do a[i]:=1;
	for i:=1 to m do begin
		x:=random(n)+1;y:=random(n)+1;
		g[x,y]:=true;g[y,x]:=true;
	end;
	m:=0;
	for i:=1 to n do g[i,i]:=false;
	for i:=1 to n do
		for j:=i+1 to n do 
			if g[i,j] then inc(m);
	writeln(n,' ',m);
	for i:=1 to 100 do flip(random(n)+1);
	for i:=1 to n do write(a[i],' ');writeln;
	for i:=1 to n do
		for j:=i+1 to n do
			if g[i,j] then writeln(i,' ',j);
	close(output);
	assign(output,'');rewrite(output);
	m:=0;
	for i:=1 to n do if s[i]=1 then inc(m);
	writeln(m);
	for i:=1 to n do if s[i]=1 then write(i,' ');writeln;
	close(output);
end.
