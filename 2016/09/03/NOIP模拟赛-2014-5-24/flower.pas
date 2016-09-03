type int=longint;
var 
	a:array[0..100010,0..1] of qword; //0:t;1:d
	n,i:int;ans,sum:qword;

function com(i,j:int):boolean;
begin com:=a[j,0]*a[i,1]>a[i,0]*a[j,1] end;

procedure swap(var a,b:qword);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(b,e:int);
var i,j:int;
begin
	i:=b;j:=e;a[0]:=a[random(e-b)+b];
	repeat
		while com(i,0) do inc(i);
		while com(0,j) do dec(j);
		if i<=j then begin
			swap(a[i,0],a[j,0]);swap(a[i,1],a[j,1]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<e then qsort(i,e);
	if b<j then qsort(b,j);
end;

begin
	assign(input,'flower.in');reset(input);
	assign(output,'flower.out');rewrite(output);
	read(n);
	for i:=1 to n do begin
		read(a[i,0],a[i,1]);
		a[i,0]:=a[i,0]*2;
	end;
	qsort(1,n);
	sum:=0;ans:=0;
	for i:=1 to n do sum:=sum+a[i,1];
	for i:=1 to n do begin
		sum:=sum-a[i,1];
		ans:=ans+sum*a[i,0];
	end;
	write(ans);
	close(input);close(output);
end.
