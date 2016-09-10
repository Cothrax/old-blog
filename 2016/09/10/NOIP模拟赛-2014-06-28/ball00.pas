uses math;
const 
	eps=0.00000000001;
	inf=1000000000;
type 
	int=longint;
	edge=record t,c,rev,next:int end;
var 
	g:array[0..200010] of edge;
	head,d,iter,q:array[0..4020] of int;
	n,l,r,mid,ans:int;

procedure add(f,t,c:int);
	procedure adde(f,t,c:int);
	var m:int;
	begin
		m:=head[0];
		g[m].t:=t;g[m].c:=c;
		g[m].next:=head[f];head[f]:=m;
		inc(head[0]);
	end;
begin adde(f,t,c);adde(t,f,0) end;

function bfs(s,t0:int):boolean;
var 
	h,t,i,v,u:int;
begin
	fillchar(d,sizeof(d),255);
	h:=0;t:=1;q[h]:=s;d[s]:=0;
	while h<>t do begin
		v:=q[h];i:=head[v];
		while i<>0 do begin
			u:=g[i].t;
			if (g[i].c>0) and (d[u]=-1) then begin
				d[u]:=d[v]+1;
				q[t]:=u;
				inc(t);if t>4020 then t:=0;
			end;
			i:=g[i].next;
		end;	
		inc(h);if h>4020 then h:=0;
	end;
	bfs:=d[t0]<>-1;
end;

function dfs(v,t,f:int):int;
var u,i,tmp:int;
begin
	if v=t then exit(f);
	dfs:=0;i:=iter[v];
	while i<>0 do begin
		u:=g[i].t;
		if (g[i].c>0) and (d[u]=d[v]+1) then begin
			tmp:=dfs(u,t,min(g[i].c,f-dfs));
			dec(g[i].c,tmp);
			if g[i].c>0 then iter[v]:=i;
			inc(g[i xor 1].c,tmp);
			inc(dfs,tmp);
		end;
		i:=g[i].next;
	end;
	if dfs=0 then d[i]:=-1;
end;

function maxflow(s,t:int):int;
var i:int;
begin
	maxflow:=0;
	while bfs(s,t) do begin
		for i:=1 to t do iter[i]:=head[i];
		inc(maxflow,dfs(s,t,inf));
	end;
end;

function check(x:int):boolean;
var i,j:int;
begin
	fillchar(head,sizeof(head),0);
	for i:=1 to x do
		for j:=i+1 to x do
			if abs(sqrt(i+j)-round(sqrt(i+j)))<eps then
				add(i,j+x,1);
	for i:=1 to x do add(2*x+1,i,1);
	for i:=1 to x do add(i+x,2*x+2,1);
	if x-maxflow(2*x+1,2*x+2)<=n then check:=true 
	else check:=false;
end;

begin
	assign(input,'ball.in');reset(input);
	assign(output,'ball.out');rewrite(output);
	read(n);
	l:=1;r:=2000;
	while l<=r do begin
		mid:=(l+r) shr 1;
		if check(mid) then begin ans:=mid;l:=mid+1 end
		else r:=mid-1;
	end;
	write(ans);
	close(input);close(output);
end.
	
