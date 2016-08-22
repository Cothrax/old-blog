uses math;
type int=longint;
var	
	n,i,p,d,ans:int;
	t:array[0..200010] of int;
	flag:array[0..200010] of boolean;

procedure dfs(v:int);
begin
	flag[v]:=true;
	if flag[t[v]] then p:=t[v]
	else dfs(t[v]);
	if p=v then ans:=min(ans,d+1);
	inc(d);
end;

begin
	read(n);
	for i:=1 to n do read(t[i]);
	ans:=maxlongint;
	fillchar(flag,sizeof(flag),false);
	for i:=1 to n do begin
		d:=0;p:=0;
		if not flag[i] then dfs(i);
	end;
	write(ans);
end.
