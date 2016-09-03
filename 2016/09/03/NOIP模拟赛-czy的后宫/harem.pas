type 
	int=longint;
	mat=array[0..101,0..101] of qword;
const z:qword=1000000007;
var 
	m,i,j:int;
	n:int64;ans:qword;
	a:mat;c:char;

function mul(a,b:mat):mat;
var i,j,k:int;
begin
	fillchar(mul,sizeof(mul),0);
	for i:=0 to m do
		for j:=0 to m do	
			for k:=0 to m do
				mul[i,j]:=(mul[i,j]+a[i,k]*b[k,j]) mod z;
end;

function mpow(a:mat;p:int64):mat;
var i:int;
begin
	fillchar(mpow,sizeof(mpow),0);
	for i:=0 to m do mpow[i,i]:=1;
	while p>0 do begin
		if p and 1=1 then mpow:=mul(mpow,a);
		a:=mul(a,a);
		p:=p shr 1;
	end;
end;

procedure print(a:mat);
var i,j:int;
begin
	for i:=0 to m do begin
		for j:=0 to m do write(a[i,j]:3);
		writeln;
	end;
end;

begin
	assign(input,'harem.in');reset(input);
	assign(output,'harem.out');rewrite(output);
	readln(n,m);
	for i:=1 to m do
		for j:=1 to m do begin
			read(c);
			a[i,j]:=1-ord(c)+ord('0');
			if j=m then readln;
		end;
	for i:=0 to m do begin
		a[0,i]:=1;a[i,0]:=1;
	end;
	a:=mpow(a,n);
	//print(a);
	ans:=0;
	for i:=0 to m do
		ans:=(ans+a[i,0]) mod z;
	write(ans);
	close(input);close(output);
end.
