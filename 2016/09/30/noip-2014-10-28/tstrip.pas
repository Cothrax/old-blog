type 
	int=longint;
	edge=record f,t,w,next:int end;
	arr=array[0..110] of int;
	graph=array[0..10010] of edge;
const inf=100000000;
var
	g,gt:graph;head,ht,q,cnt,d:arr;
	flag:array[0..110] of boolean;
	t,n,m,i,x,y,w,l,r,ans,mid:int;

procedure add(var g:graph;var head:arr;f,t,w:int);
var sz:int;
begin
	inc(head[0]);sz:=head[0];
	g[sz].f:=f;g[sz].t:=t;g[sz].w:=w;
	g[sz].next:=head[f];head[f]:=sz;
end;

procedure bfs(g:graph;head:arr;s:int);
var 
	i,v,u,h,t:int;
	used:array[0..110] of boolean;
begin
	fillchar(used,sizeof(used),false);
	h:=1;t:=2;q[h]:=s;used[s]:=true;
	while h<>t do begin
		v:=q[h];inc(h);if h>110 then h:=0;
		i:=head[v];
		while i<>0 do begin
			u:=g[i].t;
			if not used[u] then begin
				used[u]:=true;
				q[t]:=u;
				inc(t);if t>110 then t:=0;
			end;
			i:=g[i].next;
		end;
	end;
	for i:=1 to n do flag[i]:=flag[i] and used[i];
end;

function jud(x:int):boolean;
var h,t,i,v,u:int;
begin
	fillchar(flag,sizeof(flag),false);
	filldword(d,sizeof(d) div 4,inf);
	fillchar(cnt,sizeof(cnt),0);
	h:=1;t:=2;q[h]:=1;d[1]:=0;
	flag[1]:=true;cnt[1]:=1;
	while h<>t do begin
		v:=q[h];flag[v]:=false;
		inc(h);if h>110 then h:=0;
		i:=head[v];
		while i<>0 do begin
			u:=g[i].t;
			if d[u]>d[v]+g[i].w+x then begin
				d[u]:=d[v]+g[i].w+x;
				if not flag[u] then begin
					flag[u]:=true;inc(cnt[u]);
					if cnt[u]>n then exit(false);
					q[t]:=u;inc(t);if t>110 then t:=0;
				end;
			end;
			i:=g[i].next;
		end;
	end;
	jud:=(d[n]>=0);
end;

begin
	assign(input,'tstrip.in');reset(input);
	assign(output,'tstrip.out');rewrite(output);
	read(t);
	repeat
		fillchar(head,sizeof(head),0);
		fillchar(ht,sizeof(ht),0);
		read(n,m);
		for i:=1 to m do begin
			read(x,y,w);
			add(g,head,x,y,w);add(gt,ht,y,x,w);
		end;
		fillchar(flag,sizeof(flag),true);
		bfs(g,head,1);bfs(gt,ht,n);
		fillchar(head,sizeof(head),0);
		for i:=1 to m do
			if flag[g[i].f] and flag[g[i].t] then 
				add(g,head,g[i].f,g[i].t,g[i].w);
		l:=-inf;r:=inf;ans:=inf;
		while l<=r do begin
			mid:=(l+r) div 2;
			if jud(mid) then begin ans:=d[n];r:=mid-1 end
			else l:=mid+1;
		end;
		if ans=inf then writeln(-1) else writeln(ans);
		dec(t);
	until t=0;
	close(input);close(output);
end.
