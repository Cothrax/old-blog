type 
	int=longint;
	arr=array[0..100010] of int;
var 
	tr:array[0..4001000] of record lc,rc,w:int end;
	lk:array[0..400010] of record w,nxt:int end;
	cnt:array[0..100010] of int64;
	a,rt1,rt2,hd1,hd2:arr;
	st,sl,n,m,q,i,j,l0,r0,x:int;ans:int64;
	
procedure update(var i:int;l,r,x:int);
var mid:int;
begin
	inc(st);tr[st]:=tr[i];i:=st;inc(tr[i].w);
	if l=r then exit;
	mid:=(l+r) shr 1;
	if x<=mid then update(tr[i].lc,l,mid,x)
	else update(tr[i].rc,mid+1,r,x);
end;

function query(i,l,r,x:int):int;
var mid:int;
begin
	if r<=x then exit(tr[i].w);
	mid:=(l+r) shr 1;
	if x<=mid then query:=query(tr[i].lc,l,mid,x)
	else query:=query(tr[i].rc,mid+1,r,x)+tr[tr[i].lc].w;
end;

function calc(i,x:int):int;
begin
	calc:=query(rt1[i],1,n,x)-query(rt2[i],1,n,x);
end;

procedure insert(var hd:arr;i,x:int);
begin
	inc(sl);lk[sl].w:=x;
	lk[sl].nxt:=hd[i];hd[i]:=sl;
end;

procedure init(var hd,rt:arr;j:int);
var i:int;
begin
	rt[j]:=rt[j-1];i:=hd[j];
	while i<>0 do begin
		update(rt[j],1,n,lk[i].w);i:=lk[i].nxt;
	end;
end;

begin
	assign(input,'seq.in');reset(input);
	assign(output,'seq.out');rewrite(output);
	read(n,m,q);sl:=0;st:=0;ans:=0;
	for i:=1 to n do read(a[i]);
	for i:=1 to m do begin
		read(l0,r0,x);insert(hd1,l0,x);
		if r0<n then insert(hd2,r0+1,x);
	end;
	for i:=1 to n do begin
		init(hd1,rt1,i);init(hd2,rt2,i)
	end;
	for i:=1 to n do begin
		cnt[i]:=calc(i,a[i]);inc(ans,cnt[i]);
	end;
	for i:=1 to q do begin
		writeln(ans);read(j,x);
		j:=j xor ans;x:=x xor ans;
		dec(ans,cnt[j]);cnt[j]:=calc(j,x);inc(ans,cnt[j]);
	end;
	write(ans);
	close(input);close(output);
end.
