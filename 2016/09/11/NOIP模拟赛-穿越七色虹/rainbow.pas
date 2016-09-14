uses math;
type int=longint;
const n=7;
var 
	p,a,b,e:array[0..n] of double;
	h,t,l,r,mid:double;
	i:int;
	
function com(i,j:int):boolean;
begin com:=(b[i]<b[j]) or ((b[i]=b[j]) and (e[i]<e[j])) end;

procedure swap(i,j:int);
var tmp:double;
begin
	tmp:=b[i];b[i]:=b[j];b[j]:=tmp;
	tmp:=e[i];e[i]:=e[j];e[j]:=tmp;
end;

function check(x:double):boolean;
var i,j:int;last:double;
begin
	for i:=1 to n do begin
		b[i]:=p[i]-sqrt(max(0,sqr(a[i]+x)-sqr(h)));
		e[i]:=p[i]+sqrt(max(0,sqr(a[i]+x)-sqr(h)));
	end;
	for i:=1 to n do 
		for j:=i+1 to n do
			if com(j,i) then swap(i,j);
	j:=n+1;
	for i:=1 to n do if e[i]>=t then begin j:=i;break end;
	if j=n+1 then exit(false);
	last:=0;
	for i:=1 to j do begin
		if b[i]>last then exit(false);
		last:=max(last,e[i]);
	end;
	check:=true;
end;

begin
	assign(input,'rainbow.in');reset(input);
	assign(output,'rainbow.out');rewrite(output);
	read(h,t);
	for i:=1 to n do read(p[i],a[i]);
	l:=0;r:=1000000;
	for i:=1 to 100 do begin
		mid:=(l+r)/2;
		if check(mid) then r:=mid else l:=mid;
	end;
	write(r:0:2);
	close(input);close(output);
end.
