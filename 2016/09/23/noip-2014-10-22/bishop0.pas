uses math;
type 
	int=longint;
	arr=array[0..10,-10..20] of boolean;
var
	f:arr;
	n,m,i,j,r,cnt,ans:int;

procedure dfs();forward;

procedure deal(x,y:int);
var i,r0:int;tmp:arr;
begin
	r0:=r;tmp:=f;inc(cnt);
	for i:=1 to n do begin
		if f[i,y-x+i] then dec(r);
		if (i<>x) and f[i,y+x-i] then dec(r);
		f[i,y-x+i]:=false;
		f[i,y+x-i]:=false;
	end;
	dfs();f:=tmp;r:=r0;dec(cnt);
end;

procedure dfs();
var i,j:int;
begin
	{writeln(cnt,' ',r);
	for i:=1 to n do begin
		for j:=1 to m do 
			if f[i,j] then write('1 ') else write('0 ');
		writeln;
	end;writeln;}
	ans:=max(ans,cnt);
	if r+cnt<=ans then exit;
	for i:=1 to n do
		for j:=1 to m do
			if f[i,j] then deal(i,j);
end;

begin
	read(m,n);
	fillchar(f,sizeof(f),false);
	for i:=1 to n do
		for j:=1 to m do f[i,j]:=true;
	ans:=0;cnt:=0;r:=n*m;
	dfs();
	write(ans);
end.
