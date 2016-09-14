uses math;
const bs=100000000;p=8;
type 
	int=longint;
	big=array[0..5010] of int64;
var 
	n,m:big;
	l,r,mid,ans:int64;

function com(a,b:big):int64;
var i:int;
begin
	i:=max(a[0],b[0]);
	while (a[i]=b[i]) and (i>0) do dec(i);
	com:=a[i]-b[i];
end;

function rd():big;
var s:ansistring;f,b:int64;i:int;
begin
	fillchar(rd,sizeof(rd),0);
	readln(s);f:=0;b:=1;
	for i:=length(s) downto 1 do begin
		inc(f,(ord(s[i])-ord('0'))*b);b:=b*10;
		if b=bs then begin
			inc(rd[0]);rd[rd[0]]:=f;f:=0;b:=1;
		end; 
	end;
	if f<>0 then begin
		inc(rd[0]);rd[rd[0]]:=f;
	end;
end;

function mul(a:big;b:int64):big;
var i:int;
begin
	fillchar(mul,sizeof(mul),0);
	mul[0]:=a[0];
	for i:=1 to a[0] do begin
		inc(mul[i],a[i]*b);
		inc(mul[i+1],mul[i] div bs);
		mul[i]:=mul[i] mod bs;
	end;
	while mul[mul[0]+1]>0 do begin
		inc(mul[0]);
		inc(mul[mul[0]+1],mul[mul[0]] div bs);
		mul[mul[0]]:=mul[mul[0]] mod bs;
	end;
end;

begin
	assign(input,'spring.in');reset(input);
	assign(output,'spring.out');rewrite(output);
	m:=rd();n:=rd();
	l:=1;r:=2000000000;
	if com(m,n)<0 then begin write(0);halt end;
	while l<=r do begin
		mid:=(l+r) shr 1;
		if com(m,mul(n,mid))>=0 then begin ans:=mid;l:=mid+1 end
		else r:=mid-1;
	end;
	write(ans);
	close(input);close(output);
end.
