type 
	int=longint;
	edge=record v,next:int;w:int64 end;
var
	g:array[0..6010] of edge;
	head:array[0..3010] of int;
	lea,cnt:array[0..3010] of int64;
	n,m,sz,i,u,v,w:int;ans:int64;

procedure add(u,v:int;w:int64);
begin
	inc(sz);
	g[sz].v:=v;g[sz].w:=w;
	g[sz].next:=head[u];head[u]:=sz;
end;

procedure dfs(u,p:int);
var i,v:int;
begin
	lea[u]:=0;cnt[u]:=1;
	i:=head[u];
	while i<>0 do begin
		v:=g[i].v;
		if v<>p then begin
			dfs(v,u);
			inc(cnt[u],cnt[v]);
			inc(lea[u],lea[v]);
		end;
		i:=g[i].next;
	end;
	if lea[u]=0 then lea[u]:=1;
end;

procedure dp(u,p:int);
var i,v:int;
begin
	i:=head[u];
	while i<>0 do begin
		v:=g[i].v;
		if v<>p then begin
			inc(ans,g[i].w*(cnt[v]*(lea[1]-lea[v])+
				lea[v]*(cnt[1]-cnt[v])));
			dp(v,u);
		end;
		i:=g[i].next;
	end;
end;

begin
	assign(input,'senso.in');reset(input);
	assign(output,'senso.out');rewrite(output);
	read(n,m);
	for i:=1 to m do begin
		read(w,u,v);
		add(u,v,w);add(v,u,w);
	end;
	dfs(1,0);
	//for i:=1 to n do writeln(i,'>',cnt[i],' ',lea[i]);
	ans:=0;dp(1,0);write(ans);
	close(input);close(output);
end.
