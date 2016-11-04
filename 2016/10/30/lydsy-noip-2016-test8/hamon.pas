uses math;
type int=longint;ll=int64;node=record lc,rc,w:int end;
const mx=100000;md=123456789;
var
	seg:array[0..mx*20] of node;
	bit,rt,f,g:array[0..mx+10] of int;
	n,sz,i,tp,x,ans,cnt:int;

procedure _add(x,k:int);
begin
	while x<=mx do begin
		bit[x]:=max(bit[x],k);
		inc(x,x and (-x));
	end;
end;
function _query(x:int):int;
begin
	_query:=0;
	while x>0 do begin
		_query:=max(_query,bit[x]);
		x:=x and (x-1);
	end;
end;

procedure add(var i:int;l,r,x,k:int);
var mid:int;
begin
	inc(sz);seg[sz]:=seg[i];i:=sz;
	seg[i].w:=(ll(seg[i].w)+ll(k))mod md;
	if l=r then exit;
	mid:=(l+r) shr 1;
	if x<=mid then add(seg[i].lc,l,mid,x,k)
	else add(seg[i].rc,mid+1,r,x,k);
end;
function query(i,l,r,k:int):int;
var mid,lc,rc:int;
begin
	if l=r then exit(seg[i].w);
	mid:=(l+r) shr 1;
	lc:=seg[i].lc;rc:=seg[i].rc;
	if k<=mid then query:=query(lc,l,mid,k)
	else query:=(ll(seg[lc].w)+ll(query(rc,mid+1,r,k)))mod md;
end;

begin
	assign(input,'hamon.in');reset(input);
	assign(output,'hamon.out');rewrite(output);
	read(n,tp);sz:=0;
	for i:=1 to n do begin
		read(x);
		f[i]:=_query(x-1);
		if f[i]=0 then g[i]:=1
		else g[i]:=query(rt[f[i]],1,n,x-1);
		inc(f[i]);add(rt[f[i]],1,n,x,g[i]);_add(x,f[i]);
	end;
	ans:=0;cnt:=0;
	for i:=1 to n do ans:=max(ans,f[i]);
	for i:=1 to n do
		if f[i]=ans then cnt:=(cnt+g[i])mod md;
	writeln(ans);if tp=1 then write(cnt);
	close(input);close(output);
end.
