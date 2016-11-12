type int=longint;edge=record v,nxt:int end;
var
	g:array[0..200010] of edge;
	head,stk,f,dep:array[0..100010] of int;
	par:array[0..100010,0..20] of int;
	hp:array[0..150010,0..1] of int;
	flg:array[0..100010] of boolean;
	n,m,sz,hs,k,lg,op,i,j,u,v,t:int;


procedure add(u,v:int);
begin
	inc(sz);g[sz].v:=v;
	g[sz].nxt:=head[u];head[u]:=sz;
end;

procedure qsort(l,r:int);
var i,j,x,tmp:int;
begin
	if l>=r then exit;
	i:=l;j:=r;x:=stk[random(r-l)+l];
	repeat
		while stk[i]<x do inc(i);
		while stk[j]>x do dec(j);
		if i<=j then begin
			tmp:=stk[i];stk[i]:=stk[j];stk[j]:=tmp;
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if l<j then qsort(l,j);
end;

procedure dfs(u,p:int);
var i,v,h:int;
begin
	par[u,0]:=p;dep[u]:=dep[p]+1;
	i:=head[u];h:=t+1;
	while i<>0 do begin
		v:=g[i].v;
		if v<>p then begin inc(t);stk[t]:=v end;
		i:=g[i].nxt;
	end;
	qsort(h,t);
	for i:=h to t do dfs(stk[i],u);
	inc(k);f[u]:=k;t:=h-1;
end;

//begin heap
procedure hfy(i:int);
var l,r,s:int;tmp:array[0..1] of int;
begin
	l:=i shl 1;r:=l or 1;
	if (l<=hs) and (hp[l,0]<hp[i,0]) then s:=l else s:=i;
	if (r<=hs) and (hp[r,0]<hp[s,0]) then s:=r;
	if s<>i then begin
		tmp:=hp[s];hp[s]:=hp[i];hp[i]:=tmp;hfy(s);
	end;
end;
function ext():int;
begin
	ext:=hp[1,1];hp[1]:=hp[hs];dec(hs);hfy(1);
end;
procedure ins(w,k:int);
var i:int;tmp:array[0..1] of int;
begin
	inc(hs);hp[hs,0]:=w;hp[hs,1]:=k;i:=hs;
	while (i>1) and (hp[i,0]<hp[i shr 1,0]) do begin
		tmp:=hp[i];hp[i]:=hp[i shr 1];hp[i shr 1]:=tmp;
		i:=i shr 1;
	end;
end;
//end heap

procedure op1(x:int);
var i:int;
begin
	for i:=1 to x do begin
		u:=ext();flg[u]:=true;
	end;
	writeln(u);
end;

procedure op2(u:int);
var i,v:int;
begin
	v:=u;
	for i:=lg downto 0 do
		if flg[par[v,i]] then v:=par[v,i];
	flg[v]:=false;ins(f[v],v);
	writeln(dep[u]-dep[v]);
end;

begin
	read(n,m);sz:=0;lg:=trunc(ln(n)/ln(2));
	for i:=1 to n-1 do begin
		read(u,v);add(u,v);add(v,u);
	end;
	k:=0;t:=0;dfs(1,1);
	for i:=1 to lg do
		for j:=1 to n do par[j,i]:=par[par[j,i-1],i-1];
	hs:=0;
	for i:=1 to n do ins(f[i],i);
	fillchar(flg,sizeof(flg),false);
	for i:=1 to m do begin
		read(op,u);
		case op of 1:op1(u);2:op2(u) end;
	end;
end.
