type int=longint;edge=record v,nxt:int end;
var
	g:array[0..200010] of edge;
	head,siz,dep,par,son,top,w,loc,a:array[0..100010] of int;
	seg,tag:array[0..400010] of int;
	n,m,k,sz,rt,md,u,v,i,x,y,z,op:int;

procedure add(u,v:int);
begin
	inc(sz);g[sz].v:=v;
	g[sz].nxt:=head[u];head[u]:=sz;
end;

procedure dfs1(u,p:int);
var i,v:int;
begin
	par[u]:=p;dep[u]:=dep[p]+1;
	siz[u]:=1;son[u]:=0;i:=head[u];
	while i<>0 do begin
		v:=g[i].v;
		if v<>p then begin
			dfs1(v,u);
			if siz[v]>siz[son[u]] then son[u]:=v;
			inc(siz[u],siz[v]);
		end;
		i:=g[i].nxt;
	end;
end;

procedure dfs2(u:int);
var i,v:int;
begin
	if u=0 then exit;
	if u=son[par[u]] then top[u]:=top[par[u]] else top[u]:=u;
	inc(k);loc[u]:=k;a[k]:=u;dfs2(son[u]);
	i:=head[u];
	while i<>0 do begin
		v:=g[i].v;
		if (v<>par[u])and(v<>son[u]) then dfs2(v);
		i:=g[i].nxt;
	end;
end;

// seg-tree begin
procedure pushdown(i,b,e:int);
var l,r,mid:int;
begin
	l:=i shl 1;r:=l or 1;mid:=(b+e)shr 1;
	seg[l]:=(seg[l]+tag[i]*(mid-b+1))mod md;
	seg[r]:=(seg[r]+tag[i]*(e-mid))mod md;
	tag[l]:=(tag[l]+tag[i])mod md;
	tag[r]:=(tag[r]+tag[i])mod md;
	tag[i]:=0;
end;
procedure build(i,b,e:int);
var mid:int;
begin
	if b=e then begin seg[i]:=w[a[b]];exit end;
	mid:=(b+e) shr 1;
	build(i shl 1,b,mid);build(i shl 1 or 1,mid+1,e);
	seg[i]:=(seg[i shl 1]+seg[i shl 1 or 1])mod md;
end;
procedure modify(i,b,e,l,r,k:int);
var mid:int;
begin
	if (e<l) or (r<b) then exit;
	if (l<=b) and (e<=r) then begin
		seg[i]:=(seg[i]+k*(e-b+1))mod md;
		tag[i]:=(tag[i]+k)mod md;
		exit;
	end;
	if tag[i]<>0 then pushdown(i,b,e);
	mid:=(b+e) shr 1;
	modify(i shl 1,b,mid,l,r,k);
	modify(i shl 1 or 1,mid+1,e,l,r,k);
	seg[i]:=(seg[i shl 1]+seg[i shl 1 or 1])mod md;
end;
function query(i,b,e,l,r:int):int;
var mid:int;
begin
	if (e<l) or (r<b) then exit(0);
	if (l<=b) and (e<=r) then exit(seg[i]);
	if tag[i]<>0 then pushdown(i,b,e);
	mid:=(b+e) shr 1;
	query:=(query(i shl 1,b,mid,l,r)+
		query(i shl 1 or 1,mid+1,e,l,r))mod md;
end;
//seg-tree end

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

function lca(u,v:int):int;
begin
	while true do begin
		if dep[u]>dep[v] then swap(u,v);
		if top[u]=top[v] then break;
		if dep[top[u]]<dep[top[v]] then v:=par[top[v]]
		else u:=par[top[u]];
	end;
	lca:=u;
end;

procedure mfylnk(u,v,k:int);
begin
	while true do begin
		if dep[u]>dep[v] then swap(u,v);
		if top[u]=top[v] then break;
		if dep[top[u]]<dep[top[v]] then begin
			modify(1,1,n,loc[top[v]],loc[v],k);
			v:=par[top[v]];
		end else begin
			modify(1,1,n,loc[top[u]],loc[u],k);
			u:=par[top[u]];
		end;
	end;
	modify(1,1,n,loc[u],loc[v],k);
end;

function asklnk(u,v:int):int;
begin
	asklnk:=0;
	while true do begin
		if dep[u]>dep[v] then swap(u,v);
		if top[u]=top[v] then break;
		if dep[top[u]]<dep[top[v]] then begin
			asklnk:=(asklnk+query(1,1,n,loc[top[v]],loc[v]))mod md;
			v:=par[top[v]];
		end else begin
			asklnk:=(asklnk+query(1,1,n,loc[top[u]],loc[u]))mod md;
			u:=par[top[u]];
		end;
	end;
	asklnk:=(asklnk+query(1,1,n,loc[u],loc[v]))mod md;
end;

procedure mfysbt(u,k:int);
begin modify(1,1,n,loc[u],loc[u]+siz[u]-1,k) end;

function asksbt(u:int):int;
begin asksbt:=query(1,1,n,loc[u],loc[u]+siz[u]-1) end;

procedure walk(i,b,e,d:int);
var mid,j:int;
begin
	mid:=(b+e) shr 1;
	if b<e then walk(i*2,b,mid,d+1);
	for j:=1 to d*5 do write(' ');
	writeln(i,':[',b,',',e,']=',seg[i],':',tag[i]);
	if b<e then walk(i*2+1,mid+1,e,d+1);
end;

begin
	read(n,m,rt,md);k:=0;sz:=0;
	for i:=1 to n do read(w[i]);
	for i:=1 to n-1 do begin
		read(u,v);add(u,v);add(v,u);
	end;
	dfs1(rt,0);dfs2(rt);build(1,1,n);
	for i:=1 to m do begin
		read(op);
		case op of
			1:begin read(x,y,z);mfylnk(x,y,z) end;
			2:begin read(x,y);writeln(asklnk(x,y)) end;
			3:begin read(x,z);mfysbt(x,z) end;
			4:begin read(x);writeln(asksbt(x)) end;
		end;
	end;
end.
