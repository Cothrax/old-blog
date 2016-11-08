uses math;
type int=longint;edge=record v,nxt:int end;
var 
	g:array[0..200010] of edge;
	seg:array[0..400010] of int;
	w,l,r,head,par:array[0..100010] of int;
	flg:array[0..100010] of boolean;
	n,m,sz,i,k,u,v:int;s:string;

procedure add(u,v:int);
begin
	inc(sz);g[sz].v:=v;
	g[sz].nxt:=head[u];head[u]:=sz;
end;

procedure dfs(u:int);
var i,v:int;
begin
	inc(k);l[u]:=k;i:=head[u];
	while i<>0 do begin
		v:=g[i].v;
		if l[v]=0 then begin par[v]:=u;dfs(v) end;
		i:=g[i].nxt;
	end;
	r[u]:=k;
end;

procedure _modify(i,b,e,l,r,k:int);
var mid:int;
begin
	if (l>r) or (e<l) or (b>r) then exit;
	if (l<=b) and (e<=r) then begin
		seg[i]:=max(seg[i],k);
		exit;
	end;
	mid:=(b+e) shr 1;
	_modify(i shl 1,b,mid,l,r,k);
	_modify(i shl 1 or 1,mid+1,e,l,r,k);
end;

function _query(i,b,e,x:int):int;
var mid:int;
begin
	if b=e then exit(seg[i]);
	mid:=(b+e) shr 1;
	if x<=mid then _query:=max(seg[i],_query(i shl 1,b,mid,x))
	else _query:=max(seg[i],_query(i shl 1 or 1,mid+1,e,x));
end;

procedure modify(u:int);
var v:int;
begin
	_modify(1,1,n,l[u],r[u],w[u]);
	if flg[u] then exit;
	flg[u]:=true;v:=u;u:=par[u];
	while u<>0 do begin 
		_modify(1,1,n,l[u],l[v]-1,w[u]);
		_modify(1,1,n,r[v]+1,r[u],w[u]);
		if flg[u] then exit;
		flg[u]:=true;v:=u;u:=par[u];
	end;
end;

procedure query(u:int);
begin writeln(_query(1,1,n,l[u])) end;

begin
	assign(input,'lca_sample2.in');reset(input);
	assign(output,'lca.out');rewrite(output);
	readln(n,m);
	for i:=1 to n do read(w[i]);readln;
	for i:=1 to n-1 do begin
		readln(u,v);add(u,v);add(v,u);
	end;
	k:=0;dfs(1);
	fillchar(seg,sizeof(seg),255);
	for i:=1 to m do begin
		readln(s);
		case s[1] of
			'Q':begin val(copy(s,7,length(s)-6),u,v);query(u)end;
			'M':begin val(copy(s,8,length(s)-7),u,v);modify(u)end;
		end;
	end;
	close(input);close(output);
end.
