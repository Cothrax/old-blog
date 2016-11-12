uses math;
type int=longint;
var 
	mat:array[0..1010,0..110] of int;
	n,m,i,j:int;ans:double;

procedure dfs(x,cnt:int;sum:int64);
var i:int;cur:int64;
begin
	if x=n+1 then begin
		ans:=max(ans,sum/int64(cnt));exit;
	end;
	cur:=0;
	for i:=1 to m do begin
		inc(cur,mat[x,i]);
		dfs(x+1,cnt+i,sum+cur);
	end;
end;

begin
	assign(input,'gold.in');reset(input);
	assign(output,'gold.ans');rewrite(output);
	read(n,m);
	for i:=1 to n do
		for j:=1 to m do read(mat[i,j]);
	ans:=0;
	dfs(1,0,0);
	write(ans:0:4);
	close(input);close(output);
end.
