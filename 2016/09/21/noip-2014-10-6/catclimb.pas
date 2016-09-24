uses math;
type int=longint;
var
	a,f:array[0..20] of int;
	n,i,cnt,ans:int;w:int;

procedure dfs(x:int);
var i:int;
begin
	if cnt>=ans then exit;
	if x=n+1 then begin ans:=min(ans,cnt);exit end;
	for i:=1 to cnt do
		if a[x]+f[i]<=w then begin
			inc(f[i],a[x]);
			dfs(x+1);
			dec(f[i],a[x]);
		end;
	inc(cnt);inc(f[cnt],a[x]);
	dfs(x+1);
	dec(f[cnt],a[x]);dec(cnt);
end;

begin
	assign(input,'catclimb.in');reset(input);
	assign(output,'catclimb.out');rewrite(output);
	read(n,w);
	for i:=1 to n do read(a[i]);
	ans:=maxlongint;
	dfs(1);
	write(ans);
	close(input);close(output);
end.
