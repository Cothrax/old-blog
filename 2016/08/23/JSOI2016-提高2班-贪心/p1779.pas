uses math;
type 
	big=array[0..1010] of int64;
	int=longint;
const 
	bs:int64=100000000;
	k=8;
var 
	a:array[0..1010,0..1] of int;
	n,i:int;
	tmp,ans,prob:big;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(b,e:int);
var i,j:int;
begin
	i:=b;j:=e;a[0]:=a[random(e-b)+b];
	repeat
		while a[i,0]*a[i,1]<a[0,0]*a[0,1] do inc(i);
		while a[j,0]*a[j,1]>a[0,0]*a[0,1] do dec(j);
		if i<=j then begin
			swap(a[i,0],a[j,0]);swap(a[i,1],a[j,1]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<e then qsort(i,e);
	if b<j then qsort(b,j);
end;

function com(a,b:big):int64;
var i:int;
begin
	i:=max(a[0],b[0]);
	while (a[i]=b[i]) and (i>0) do dec(i);
	com:=a[i]-b[i];
end;

function mul(a:big;b:int):big;
var i:int;
begin
	fillchar(mul,sizeof(mul),0);
	for i:=1 to a[0] do begin
		inc(mul[i],a[i]*b);
		inc(mul[i+1],mul[i] div bs);
		mul[i]:=mul[i] mod bs;
	end;
	mul[0]:=a[0];
	while mul[mul[0]+1]>0 do inc(mul[0]);
end;

function sdiv(a:big;b:int):big;
var m:int64;i:int;
begin
	fillchar(sdiv,sizeof(sdiv),0);
	m:=0;
	sdiv[0]:=a[0];
	for i:=a[0] downto 1 do begin
		sdiv[i]:=(m*bs+a[i]) div b;
		m:=(m*bs+a[i]) mod b;
	end;
	while (sdiv[sdiv[0]]=0) and (sdiv[0]>0) do dec(sdiv[0]);
end;

procedure print(a:big);
var i,j,x:int;
begin
	if a[0]=0 then begin write(0);exit end;
	write(a[a[0]]);
	for i:=a[0]-1 downto 1 do begin
		if a[i]=0 then x:=1 else x:=floor(ln(a[i])/ln(10))+1;
		for j:=1 to k-x do write(0);
		write(a[i]);
	end;
end;

begin
	assign(input,'p1779.in');reset(input);
	read(n);inc(n);
	for i:=1 to n do read(a[i,0],a[i,1]);
	qsort(2,n);
	ans[0]:=0;prob[0]:=1;prob[1]:=a[1,0];
	for i:=2 to n do begin
		tmp:=sdiv(prob,a[i,1]);
		if com(tmp,ans)>0 then ans:=tmp;
		prob:=mul(prob,a[i,0]);
	end;
	print(ans);
	close(output);
end.
