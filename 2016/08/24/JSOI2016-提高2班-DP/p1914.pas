uses math;
type int=longint;
const inf=100000000;
var 
	n,m,r,c,i,j,ans:int;
	mat:array[0..17,0..17] of int;
	s:array[0..17] of int;

function cal(a,b:int):int;
var i:int;
begin
	if min(a,b)=0 then exit(0);
	cal:=0;
	for i:=1 to r do
		inc(cal,abs(mat[s[i],a]-mat[s[i],b]));
end;

procedure dp();
var 
	i,j,k,tmp:int;
	f:array[0..17,0..17] of int;
	v:array[0..17] of int;
begin
	fillchar(v,sizeof(v),0);
	for i:=1 to m do begin
		v[i]:=0;
		for j:=2 to r do
			inc(v[i],abs(mat[s[j],i]-mat[s[j-1],i]));
	end;
	filldword(f,sizeof(f) div 4,inf);
	f[0,0]:=0;
	for i:=1 to c do
		for j:=i to m do
			for k:=0 to j-1 do
				f[i,j]:=min(f[i,j],f[i-1,k]+cal(j,k)+v[j]);
	tmp:=inf;
	for i:=1 to n do tmp:=min(tmp,f[c,i]);
	ans:=min(tmp,ans);
end;

procedure dfs(i,j:int);
begin
	if j>r then exit;
	if i=n+1 then begin
		if j=r then dp();
		exit;
	end;
	s[j+1]:=i;
	dfs(i+1,j+1);
	dfs(i+1,j);
end;

begin
	read(n,m,r,c);
	for i:=1 to n do
		for j:=1 to n do read(mat[i,j]);
	ans:=inf;
	dfs(1,0);
	write(ans);
end.
