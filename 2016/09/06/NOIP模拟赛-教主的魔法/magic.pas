type int=longint;
var
	t:array[0..24000000] of int;
	ls,rs,add,tag:array[0..4000010] of int;
	a:array[0..1000010] of int;
	n,m,k,i,j,l0,r0,c0:int;c:char;


procedure build(i,b,e:int);
var mid,lp,rp,lc,rc:int;
begin
	if b=e then begin
		inc(k);t[k]:=a[b];ls[i]:=k;rs[i]:=k;exit;
	end;
	mid:=(b+e) shr 1;lc:=i*2;rc:=i*2+1;
	build(lc,b,mid);build(rc,mid+1,e);
	lp:=ls[lc];rp:=ls[rc];ls[i]:=k+1;
	while (lp<=rs[lc]) or (rp<=rs[rc]) do begin
		if (lp>rs[lc]) or ((rp<=rs[rc]) 
			and (t[rp]<t[lp])) then begin
			inc(k);t[k]:=t[rp];inc(rp);
		end else begin
			inc(k);t[k]:=t[lp];inc(lp);
		end;
	end;
	rs[i]:=k;
end;

procedure pushdown(i,b,e:int);
var lc,rc:int;
begin
	if b<e then begin
		lc:=i*2;rc:=i*2+1;
		inc(tag[lc],tag[i]);inc(add[lc],add[i]);
		inc(tag[rc],tag[i]);inc(add[rc],add[i]);
	end;
	tag[i]:=0;
end;

procedure modify(i,b,e,l,r,x:int);
var mid:int;
begin
	writeln('m',' ',i,' ',b,' ',e);
	if (r<b) or (e<l) then exit;
	if (l<=b) and (e<=r) then begin
		inc(add[i],x);inc(tag[i],x);exit;
	end;
	mid:=(b+e) shr 1;
	if tag[i]<>0 then pushdown(i,b,e);
	modify(i*2,b,mid,l,r,x);
	modify(i*2+1,mid+1,e,l,r,x);
end;

function bin(i,l,r,x:int):int;
var mid:int;
begin
	writeln('>',i,' ',l,' ',r);
	bin:=l-1;
	while l<=r do begin
		mid:=(l+r) shr 1;
		if t[mid]+add[i]<x then begin bin:=mid;l:=mid+1 end
		else r:=mid-1;
	end;
end;

function query(i,b,e,l,r,x:int):int;
var mid:int;
begin
	writeln('q ',i,' ',b,' ',e);
	if (r<b) or (e<l) then exit(0);
	if (l<=b) and (e<=r) then exit(rs[i]-bin(i,ls[i],rs[i],x));
	mid:=(b+e) shr 1;
	if tag[i]<>0 then pushdown(i,b,e);
	query:=query(i*2,b,mid,l,r,x);
	inc(query,query(i*2+1,mid+1,e,l,r,x));
end;

begin
	readln(n,m);
	for i:=1 to n do read(a[i]);readln;
	k:=0;
	build(1,1,n);
	
	for i:=1 to m do begin
		read(c);readln(l0,r0,c0);
		case c of 
			'M':modify(1,1,n,l0,r0,c0);
			'A':writeln(query(1,1,n,l0,r0,c0));
		end;
	end;
end.
