uses math;
type int=longint;
const z=1000003;mx=20000;
var
	hash,x,y:array[0..1010] of qword;
	nxt,cnt:array[0..1010] of int;
	head:array[0..z] of int;
	n,i,j,k,l,sz,x0,y0:int;dx,dy,ans:qword;

procedure insert(k:qword);
var i:int;
begin
	i:=k mod z;
	if head[i]=0 then begin
		inc(sz);head[i]:=sz;hash[sz]:=k;cnt[sz]:=1;exit;
	end;
	i:=head[i];
	while nxt[i]<>0 do begin
		if hash[i]=k then begin inc(cnt[i]);exit end;
		i:=nxt[i];
	end;
	if hash[i]=k then begin inc(cnt[i]);exit end;
	inc(sz);nxt[i]:=sz;hash[sz]:=k;cnt[sz]:=1;
end;

function query(k:qword):int;
var i:int;
begin
	i:=head[k mod z];
	while i<>0 do begin
		if hash[i]=k then exit(i);
		i:=nxt[i];
	end;
	query:=-1;
end;

begin
	assign(input,'car.in');reset(input);
	assign(output,'car.out');rewrite(output);
	read(n);sz:=0;
	for i:=1 to n do begin
		read(x0,y0);
		x[i]:=x0+mx;y[i]:=y0+mx;
		insert(x[i]*mx+y[i]);
	end;
	ans:=0;
	for i:=1 to n do
		for j:=i+1 to n do begin
			dx:=x[i]-x[j];dy:=y[i]-y[j];
			k:=query((x[i]-dy)*mx+y[i]+dx);
			l:=query((x[j]-dy)*mx+y[j]+dx);
			if min(k,l)>0 then inc(ans,min(cnt[k],cnt[l]));
			k:=query((x[i]+dy)*mx+y[i]-dx);
			l:=query((x[j]+dy)*mx+y[j]-dx);
			if min(k,l)>0 then inc(ans,min(cnt[k],cnt[l]));
		end;
	write(ans div 4);
	close(input);close(output);
end.
