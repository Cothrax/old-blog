uses math;
type 
	int=longint;
	edge=record v,nxt:int end;
var
	g:array[0..1000010] of edge;
	head,s,dfn,low,scc,siz,f:array[0..500010] of int;
	ins{,vis}:array[0..500010] of boolean;
	sz,n,m,k,i,t,u,v,cc,tim,cnt,ans:int;

procedure add(u,v:int);
begin
	inc(sz);g[sz].v:=v;
	g[sz].nxt:=head[u];head[u]:=sz;
end;

procedure tarjan(u:int);
var i,v:int;
begin
	inc(tim);dfn[u]:=tim;low[u]:=tim;
	inc(t);s[t]:=u;ins[u]:=true;
	i:=head[u];
	while i<>0 do begin
		v:=g[i].v;
		if dfn[v]=0 then begin
			tarjan(v);low[u]:=min(low[v],low[u]);
		end else if ins[v] then
			low[u]:=min(low[u],dfn[v]);		
		i:=g[i].nxt;
	end;
	if dfn[u]=low[u] then begin
		inc(cc);siz[cc]:=0;
		while s[t+1]<>u do begin
			scc[s[t]]:=cc;ins[s[t]]:=false;
			inc(siz[cc]);dec(t);
		end;
	end;
end;

procedure dfs(u:int);
var v,i,j:int;
begin
	inc(t);s[t]:=u;ins[u]:=true;
	i:=head[u];
	while i<>0 do begin
		v:=g[i].v;
		if scc[v]=k then begin
			if ins[v] then begin
				inc(cnt);j:=t;
				while s[j+1]<>v do 
					begin inc(f[s[j]]);dec(j) end;
			end else dfs(v);
		end;
		i:=g[i].nxt;
	end;
	ins[u]:=false;dec(t);
end;

begin
	//assign(input,'reality.in');reset(input);
	//assign(output,'reality.out');rewrite(output);
	read(n,m);
	for i:=1 to m do begin
		read(u,v);add(u,v);
	end;
	t:=0;tim:=0;cc:=0;
	for i:=1 to n do
		if dfn[i]=0 then tarjan(i);
	k:=-1;
	for i:=1 to cc do
		if siz[i]>1 then begin 
			if k<>-1 then begin write(0);halt end;
			k:=i; 
		end;
	if k=-1 then begin 
		writeln(n);for i:=1 to n do write(i,' ');halt;
	end;
	for i:=1 to n do
		if scc[i]=k then begin u:=i;break end;
	fillchar(s,sizeof(s),0);
	ans:=0;cnt:=0;dfs(u);
	for i:=1 to n do
		if f[i]=cnt then begin inc(ans);inc(t);s[t]:=i end;
	writeln(ans);
	for i:=1 to t do write(s[i],' ');
	close(input);close(output);
end.
