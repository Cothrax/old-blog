uses math;
const 
	bs=100000000;
	k=8;
type
	int=longint;
	big=array[0..500] of int64;

function add(a,b:big):big;
var i:int;
begin
	fillchar(add,sizeof(add),0);
	add[0]:=max(a[0],b[0]);
	for i:=1 to add[0] do begin
		inc(add[i],a[i]+b[i]);
		inc(add[i+1],add[i] div bs);
		add[i]:=add[i] mod bs;
	end;
	if add[add[0]+1]>0 then inc(add[0]);
end;

function mul(a:big;b:int):big;
var i:int;
begin
	fillchar(mul,sizeof(mul),0);
	mul[0]:=a[0];
	for i:=1 to mul[0] do begin
		inc(mul[i],a[i]*b);
		inc(mul[i+1],mul[i] div bs);
		mul[i]:=mul[i] mod bs;
	end;
	while mul[mul[0]+1]>0 do inc(mul[0]);
end;

procedure print(a:big);
var i,j,x:int;
begin
	//if a[0]=0 then begin write(0);exit end;
	write(a[a[0]]);
	for i:=a[0]-1 downto 1 do begin
		if a[i]=0 then x:=1 else x:=floor(ln(a[i])/ln(10))+1;
		for j:=1 to k-x do write(0);
		write(a[i]);
	end;
end;

var 
	n,i:int;
	f:array[0..2] of big;
begin
	assign(input,'t3.in');reset(input);
	assign(output,'t3.out');rewrite(output);
	read(n);
	f[1][0]:=0;
	f[2][0]:=1;f[2][1]:=1;
	for i:=3 to n do
		f[i mod 3]:=mul(add(f[(i-1) mod 3],f[(i-2) mod 3]),i-1);
	print(f[n mod 3]);
	close(input);close(output);
end.
