uses math;
const 
	eps=0.00000000001;
	inf=1000000000;
type 
	int=longint;
	edge=record f,t,c,next:int end;
var 
	g:array[0..200010] of edge;
	head,flag:array[0..4020] of int;
	n,l,r,cur,mid,ans:int;

procedure add(f,t,c:int);
	procedure adde(f,t,c:int);
	var m:int;
	begin
		m:=head[0];
		g[m].f:=f;g[m].t:=t;g[m].c:=c;
		g[m].next:=head[f];head[f]:=m;
		inc(head[0]);
	end;
begin
	adde(f,t,c);adde(t,f,0);
end;

function dfs(s,t,f:int):int;
var u,i,d:int;
begin
	if s=t then exit(f);
	dfs:=0;
	flag[s]:=cur;
	i:=head[s];
	while i<>0 do begin
		u:=g[i].t;
		if (flag[u]<cur) and (g[i].c>0) then begin
			d:=dfs(u,t,min(f-dfs,g[i].c));
			if d>0 then begin
				dec(g[i].c,d);
				inc(g[i xor 1].c,d);
				inc(dfs,d);
			end;
		end;
		i:=g[i].next;
	end;
end;

function maxflow(s,t:int):int;
var f:int;
begin
	maxflow:=0;
	fillchar(flag,sizeof(flag),0);cur:=0;
	while true do begin
		inc(cur);
		f:=dfs(s,t,inf);
		if f=0 then exit(maxflow);
		inc(maxflow,f);
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
	
