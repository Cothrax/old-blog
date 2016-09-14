uses math;
type int=longint;
var 
	tag:array[0..400010] of qword;
	seg:array[0..400010,0..1] of qword;
	a:array[0..100010] of int;
	n,m,i,c,l,r:int;d,su,sq,g,k:qword;

function min(a,b:qword):qword;
begin if a<b then min:=a else min:=b end;

procedure build(i,b,e:int);
var mid:int;
begin
	if b=e then begin seg[i,0]:=a[b];seg[i,1]:=sqr(a[b]);exit end;
	mid:=(b+e) shr 1;
	build(i shl 1,b,mid);
	build(i shl 1 or 1,mid+1,e);
	seg[i,0]:=seg[i shl 1,0]+seg[i shl 1 or 1,0];
	seg[i,1]:=seg[i shl 1,1]+seg[i shl 1 or 1,1];
end;

procedure pushdown(i,b,e:int);
var mid:int;
	procedure deal(j,b,e:int);
	begin
		inc(tag[j],tag[i]);
		inc(seg[j,1],2*tag[i]*seg[j,0]+(e-b+1)*sqr(tag[i]));
		inc(seg[j,0],(e-b+1)*tag[i]);
	end;
begin
	mid:=(b+e) shr 1;
	deal(i shl 1,b,mid);
	deal(i shl 1 or 1,mid+1,e);
	tag[i]:=0;
end;

function query(i,b,e,l,r,x:int):qword;
var mid:int;
begin
	if (r<b) or (e<l) then exit(0);
	if (l<=b) and (e<=r) then exit(seg[i,x]);
	mid:=(b+e) shr 1;
	if tag[i]<>0 then pushdown(i,b,e);
	query:=query(i shl 1,b,mid,l,r,x);
	inc(query,query(i shl 1 or 1,mid+1,e,l,r,x));
end;

procedure modify(i,b,e,l,r,x:int);
var mid:int;
begin
	if (r<b) or (e<l) then exit;
	if (l<=b) and (e<=r) then begin
		inc(tag[i],x);
		inc(seg[i,1],2*x*seg[i,0]+(e-b+1)*sqr(x));
		inc(seg[i,0],(e-b+1)*x);
		exit;
	end;
	mid:=(b+e) shr 1;
	if tag[i]<>0 then pushdown(i,b,e);
	modify(i shl 1,b,mid,l,r,x);
	modify(i shl 1 or 1,mid+1,e,l,r,x);
	seg[i,0]:=seg[i shl 1,0]+seg[i shl 1 or 1,0];
	seg[i,1]:=seg[i shl 1,1]+seg[i shl 1 or 1,1];
end;

function gcd(a,b:qword):qword;
begin if b=0 then gcd:=a else gcd:=gcd(b,a mod b) end;

begin
	assign(input,'classroom.in');reset(input);
	assign(output,'classroom.out');rewrite(output);
	read(n,m);
	for i:=1 to n do read(a[i]);
	build(1,1,n);
	for i:=1 to m do begin
		read(c,l,r);
		case c of
			1:begin read(d);modify(1,1,n,l,r,d) end;
			2:begin 
				su:=query(1,1,n,l,r,0);k:=r-l+1;
				if min(su,k)=0 then writeln('0/1')
				else begin
					g:=gcd(su,k);
					writeln(su div g,'/',k div g);
				end;
			end;
			3:begin
				su:=query(1,1,n,l,r,0);k:=r-l+1;
				sq:=query(1,1,n,l,r,1);d:=k*sq-sqr(su);
				if min(d,sqr(k))=0 then writeln('0/1')
				else begin
					g:=gcd(d,sqr(k));
					writeln(d div g,'/',sqr(k) div g);
				end;
			end;
		end;
	end;
	close(input);close(output);
end.
