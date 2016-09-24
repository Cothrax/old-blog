uses math;
type 
	int=longint;
	arr=array[0..3] of int;
	pint=^int;
var
	f,t,r1,r2:arr;
	l,r,mid,ans,c1,c2,i:int;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure sort(var f:arr);
var i,j:int;
begin
	for i:=1 to 2 do
		for j:=i+1 to 3 do
			if f[i]>f[j] then swap(f[i],f[j]);
end;

function cal(f:arr;k:int;p:pint):arr;
var d1,d2,x:int;
begin
	d1:=f[2]-f[1];d2:=f[3]-f[2];
	if d1=d2 then exit(f);
	if d1>d2 then begin
		x:=min(d1 div d2,k);
		if d2*x=d1 then dec(x);
		dec(k,x);inc(p^,x);
		dec(f[2],x*d2);dec(f[3],x*d2);
	end else begin
		x:=min(d2 div d1,k);
		if d1*x=d2 then dec(x);
		dec(k,x);inc(p^,x);
		inc(f[1],x*d1);inc(f[2],x*d1);
	end;
	if k=0 then cal:=f else cal:=cal(f,k,p);
end;

function equ(a,b:arr):boolean;
var i:int;
begin
	for i:=1 to 3 do
		if a[i]<>b[i] then exit(false);
	equ:=true;
end;

begin
	assign(input,'hop.in');reset(input);
	assign(output,'hop.out');rewrite(output);
	for i:=1 to 3 do read(f[i]);
	for i:=1 to 3 do read(t[i]);
	sort(f);c1:=0;r1:=cal(f,maxlongint,@c1);
	sort(t);c2:=0;r2:=cal(t,maxlongint,@c2);
	if not equ(r1,r2) then begin write('NO');halt end;
	if c1>c2 then f:=cal(f,c1-c2,@i);
	if c2>c1 then t:=cal(t,c2-c1,@i);
	l:=0;r:=c1+c2;ans:=0;
	while l<=r do begin
		mid:=(l+r) shr 1;
		if equ(cal(f,mid,@i),cal(t,mid,@i)) then begin
			ans:=mid*2;r:=mid-1
		end else l:=mid+1;
	end;
	writeln('YES');write(ans+abs(c1-c2));
	close(input);close(output);
end.
