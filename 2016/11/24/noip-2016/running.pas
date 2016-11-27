type
	int=longint;
	edge=record v,nxt:int end;
	node=record v,k,nxt:int end;
	arr=array[0..300010] of int;
var
	g:array[0..600010] of edge;
	lnk:array[0..2400010] of node;
	head,w,lca,par,s,t,_s,_t,ans,
	pre,dep,loc,seg,son,top,siz:arr;
	cnt:array[-900010..900010] of int;
	n,m,k,sz,sl,i,u,v:int;

procedure add(u,v:int);
begin
	inc(sz);g[sz].v:=v;
	g[sz].nxt:=head[u];head[u]:=sz;
end;

function find(x:int):int;
begin
	if par[x]=x then find:=x
	else begin
		par[x]:=find(par[x]);
		find:=par[x];
	end;
end;

procedure union(x,y:int);
begin
	x:=find(x);y:=find(y);
	par[x]:=y;
end;

procedure ins(var ptr:arr;u,v,k:int);
begin
	inc(sl);lnk[sl].v:=v;lnk[sl].k:=k;
	lnk[sl].nxt:=ptr[u];ptr[u]:=sl;
end;

procedure calc(var ptr:arr;u:int);
var i,v:int;
begin
	i:=ptr[u];
	while i<>0 do begin
		v:=lnk[i].v;
		if dep[v]<>0 then lca[lnk[i].k]:=find(v);
		i:=lnk[i].nxt;
	end;
end;

procedure dfs1(u,p:int);
var v,i:int;
begin
	pre[u]:=p;dep[u]:=dep[p]+1;siz[u]:=1;son[u]:=0;
	i:=head[u];
	while i<>0 do begin
		v:=g[i].v;
		if dep[v]=0 then begin
			dfs1(v,u);
			if siz[v]>siz[son[u]] then son[u]:=v;
			inc(siz[u],siz[v]);
		end;
		i:=g[i].nxt;
	end;
	calc(s,u);calc(t,u);if p<>0 then union(u,p);
end;

procedure dfs2(u:int);
var i,v:int;
begin
	inc(k);loc[u]:=k;seg[k]:=u;
	if u=son[pre[u]] then top[u]:=top[pre[u]] else top[u]:=u;
	if son[u]<>0 then dfs2(son[u]);
	i:=head[u];
	while i<>0 do begin
		v:=g[i].v;
		if (v<>son[u])and(v<>pre[u]) then dfs2(v);
		i:=g[i].nxt;
	end;
end;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure modify(u,v,x:int);
var p:^int;
begin
	while true do begin
		if dep[u]<dep[v] then swap(u,v);
		if top[u]=top[v] then break;
		if dep[top[u]]>dep[top[v]] then p:=@u else p:=@v;
		ins(_t,loc[p^]+1,0,x);
		ins(_s,loc[top[p^]],0,x);
		p^:=pre[top[p^]];
	end;
	ins(_s,loc[v],0,x);ins(_t,loc[u]+1,0,x);
end;

procedure solv(var ptr:arr;x:int);
var u,v,i,j,tmp:int;
begin
	for u:=1 to n do begin
		i:=ptr[u];if x=0 then tmp:=dep[u];
		while i<>0 do begin
			if x=1 then begin
				v:=lca[lnk[i].k];tmp:=dep[lnk[i].v]-2*dep[v];
				if tmp=w[v] then dec(ans[v]);
			end;
			modify(u,lca[lnk[i].k],tmp);
			i:=lnk[i].nxt;
		end;
	end;
	for i:=1 to n do begin
		j:=_s[i];
		while j<>0 do begin
			inc(cnt[lnk[j].k]);j:=lnk[j].nxt;
		end;
		j:=_t[i];
		while j<>0 do begin
			dec(cnt[lnk[j].k]);j:=lnk[j].nxt;
		end;
		inc(ans[seg[i]],cnt[w[seg[i]]]);
	end;
end;

begin
	read(n,m);sz:=0;sl:=0;
	for i:=1 to n-1 do begin
		read(u,v);add(u,v);add(v,u);
	end;
	for i:=1 to n do read(w[i]);
	for i:=1 to m do begin
		read(u,v);ins(s,u,v,i);ins(t,v,u,i);
	end;
	for i:=1 to n do par[i]:=i;
	dfs1(1,0);k:=0;dfs2(1);
	for i:=1 to n do inc(w[i],dep[i]);
	solv(s,0);
	fillchar(_s,sizeof(_s),0);
	fillchar(_t,sizeof(_t),0);
	fillchar(cnt,sizeof(cnt),0);
	for i:=1 to n do dec(w[i],dep[i]*2);
	solv(t,1);
	for i:=1 to n do write(ans[i],' ');
end.
