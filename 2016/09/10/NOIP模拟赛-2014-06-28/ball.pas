uses math;
const eps=0.00000000001;
type 
	int=longint;
	edge=record f,t,next:int end;
var 
	g:array[0..200010] of edge;
	head,match:array[0..4010] of int;
	used:array[0..4010] of boolean;
	n,l,r,mid,ans:int;

procedure add(f,t:int);
var m:int;
begin
	inc(head[0]);m:=head[0];
	g[m].f:=f;g[m].t:=t;
	g[m].next:=head[f];head[f]:=m;
end;

function dfs(v:int):boolean;
var i,u:int;
begin
	i:=head[v];
	while i<>0 do begin
		u:=g[i].t;
		if not used[u] then begin
			used[u]:=true;
			if (match[u]=0) or dfs(match[u]) then begin
				match[u]:=v;match[v]:=u;
				exit(true);
			end;
		end;
		i:=g[i].next;
	end;
	exit(false);
end;

function check(x:int):boolean;
var i,j,cnt:int;
begin
	fillchar(head,sizeof(head),0);
	for i:=1 to x do
		for j:=i+1 to x do
			if abs(sqrt(i+j)-round(sqrt(i+j)))<eps then begin
				add(i,j+x);add(j+x,i);
			end;
	fillchar(match,sizeof(match),0);cnt:=0;
	for i:=1 to 2*x do
		if match[i]=0 then begin
			fillchar(used,sizeof(used),false);
			if dfs(i) then inc(cnt);
		end;
	if x-cnt<=n then check:=true else check:=false;
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
	
