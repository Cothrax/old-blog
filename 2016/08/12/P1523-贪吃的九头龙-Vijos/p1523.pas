uses math;
const inf=10000000;
type 
	edge=record t,w,next:longint end;
	node=record br,ch,w:longint end;
var 
	n,m,k,i,f0,t0,w0:longint;
	g:array[0..610] of edge;
	tr:array[0..310] of node;
	f:array[0..310,0..310,0..1] of longint;
	head:array[0..310] of longint;

procedure add(f0,t0,w0:longint);
var m:longint;
begin
	inc(head[0]);m:=head[0];
	g[m].t:=t0;g[m].w:=w0;
	g[m].next:=head[f0];head[f0]:=m;
end;

procedure dfs(v,p:longint);
var i,u:longint;
begin
	i:=head[v];
	while i<>0 do begin
		u:=g[i].t;
		if p<>u then begin
			tr[u].br:=tr[v].ch;
			tr[v].ch:=u;
			tr[u].w:=g[i].w;
			dfs(u,v);
		end;
		i:=g[i].next;
	end;
end;

//v的子树，大头吃j棵，父节点是k吃的（0大头，1小头）
function dp(v,j,k:longint):longint;
var t,tmp:longint;
begin
	if v=0 then begin
		if j=0 then exit(0) else exit(inf)
	end;
	if f[v,j,k]>=0 then exit(f[v,j,k]);
	f[v,j,k]:=inf;
	//大头吃i
	for t:=1 to j do begin
		tmp:=dp(tr[v].ch,t-1,0)+dp(tr[v].br,j-t,k);
		if k=0 then inc(tmp,tr[v].w);
		f[v,j,k]:=min(f[v,j,k],tmp);
	end;
	//小头吃i
	for t:=0 to j do begin
		tmp:=dp(tr[v].ch,t,1)+dp(tr[v].br,j-t,k);
		if (k=1) and (m=2) then inc(tmp,tr[v].w);
		f[v,j,k]:=min(f[v,j,k],tmp);
	end;
	dp:=f[v,j,k];
end;

begin
	read(n,m,k);
	if m+k>n then begin write(-1);halt end;
	//先用邻接表存多叉
	for i:=1 to n-1 do begin
		read(f0,t0,w0);
		add(f0,t0,w0);add(t0,f0,w0);
	end;
	//深搜一遍，多叉转二叉
	tr[1].w:=0;dfs(1,0);
	//记忆化
	fillchar(f,sizeof(f),255);
	write(dp(tr[1].ch,k-1,0));
end.

