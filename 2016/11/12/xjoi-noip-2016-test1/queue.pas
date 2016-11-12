type int=longint;edge=record v,nxt:int end;
var
	g:array[0..200010] of edge;
	head,stk,f,bit,lp,rp,par:array[0..100010] of int;
	seg,tag:array[0..400010] of int;
	hp:array[0..150010,0..1] of int;
	n,m,sz,hs,k,cnt,op,i,u,v,t:int;

procedure add(u,v:int);
begin
	inc(sz);g[sz].v:=v;
	g[sz].nxt:=head[u];head[u]:=sz;
end;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(l,r:int);
var i,j,x:int;
begin
	if l>=r then exit;
	i:=l;j:=r;x:=stk[random(r-l)+l];
	repeat
		while stk[i]<x do inc(i);
		while stk[j]>x do dec(j);
		if i<=j then begin
			swap(stk[i],stk[j]);inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if l<j then qsort(l,j);
end;

procedure dfs(u,p:int);
var i,v,h:int;
begin
	par[u]:=p;i:=head[u];h:=t+1;inc(cnt);lp[u]:=cnt;
	while i<>0 do begin
		v:=g[i].v;
		if v<>p then begin inc(t);stk[t]:=v end;
		i:=g[i].nxt;
	end;
	qsort(h,t);
	for i:=h to t do dfs(stk[i],u);
	inc(k);f[u]:=k;t:=h-1;rp[u]:=cnt;
end;

//begin heap
procedure hfy(i:int);
var l,r,s:int;
begin
	l:=i shl 1;r:=l or 1;
	if (l<=hs) and (hp[l,0]<hp[i,0]) then s:=l else s:=i;
	if (r<=hs) and (hp[r,0]<hp[s,0]) then s:=r;
	if s<>i then begin
		swap(hp[s,0],hp[i,0]);swap(hp[s,1],hp[i,1]);
		hfy(s);
	end;
end;
function ext():int;
begin
	ext:=hp[1,1];hp[1]:=hp[hs];dec(hs);hfy(1);
end;
procedure ins(w,k:int);
var i,p:int;
begin
	inc(hs);hp[hs,0]:=w;hp[hs,1]:=k;
	i:=hs;p:=i shr 1;
	while (i>1) and (hp[i,0]<hp[p,0]) do begin
		swap(hp[i,0],hp[p,0]);swap(hp[i,1],hp[p,1]);
		i:=p;p:=p shr 1;
	end;
end;
//end heap

//begin bit
procedure _add(x,k:int);
begin
	if x=0 then exit;
	while x<=n do begin
		inc(bit[x],k);inc(x,x and (-x));
	end;
end;
function ask(x:int):int;
begin
	ask:=0;
	while x>0 do begin
		inc(ask,bit[x]);x:=x and (x-1);
	end;
end;
//end bit

//seg-tree begin
procedure pushdown(i,b,e:int);
begin
	if b<e then begin 
		seg[i shl 1]:=tag[i];tag[i shl 1]:=tag[i];
		seg[i shl 1 or 1]:=tag[i];tag[i shl 1 or 1]:=tag[i];
	end;
	tag[i]:=-1;
end;
procedure modify(i,b,e,l,r,k:int);
var mid:int;
begin
	if (b>e) or (e<l) or (r<b) then exit;
	if (l<=b) and (e<=r) then begin
		seg[i]:=k;tag[i]:=k;exit;
	end;
	if tag[i]<>-1 then pushdown(i,b,e);
	mid:=(b+e) shr 1;seg[i]:=k;
	modify(i shl 1,b,mid,l,r,k);
	modify(i shl 1 or 1,mid+1,e,l,r,k);
end;
function query(i,b,e,x:int):int;
var mid:int;
begin
	if b=e then exit(seg[i]);
	if tag[i]<>-1 then pushdown(i,b,e);
	mid:=(b+e) shr 1;
	if x<=mid then query:=query(i shl 1,b,mid,x)
	else query:=query(i shl 1 or 1,mid+1,e,x);
end;
//seg-tree end

//op begin
procedure op1(x:int);
var i,u:int;
begin
	for i:=1 to x do begin
		u:=ext();
		_add(lp[u],1);_add(rp[u]+1,-1);
		modify(1,1,n,lp[u],rp[u],u);
	end;
	writeln(u);
end;
procedure op2(x:int);
var u,v,i:int;
begin
	writeln(ask(lp[x])-1); //bug: 这写在前面
	u:=query(1,1,n,lp[x]);ins(f[u],u); //bug: 记得ins
	_add(lp[u],-1);_add(rp[u]+1,1);
	i:=head[u];
	while i<>0 do begin
		v:=g[i].v;
		if v<>par[u] then modify(1,1,n,lp[v],rp[v],v);
		i:=g[i].nxt;
	end;
end;
//op end

begin
	read(n,m);sz:=0;
	for i:=1 to n-1 do begin
		read(u,v);add(u,v);add(v,u);
	end;
	cnt:=0;k:=0;t:=0;dfs(1,0);hs:=0;
	for i:=1 to n do ins(f[i],i);
	fillchar(tag,sizeof(tag),255);
	for i:=1 to m do begin
		read(op,u);
		case op of 1:op1(u);2:op2(u) end;
	end;
end.
