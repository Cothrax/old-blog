uses math;
type int=longint;
var 
	n,i,j:int;
	a,b,f,bit:array[0..100010] of int;

procedure add(x,k:int);
begin
	while x<=n do begin
		bit[x]:=max(bit[x],k);
		x:=x+x and (-x);
	end;
end;

function query(x:int):int;
begin
	query:=0;
	while x>0 do begin
		query:=max(query,bit[x]);
		x:=x and (x-1);
	end;
end;

begin
	//assign(input,'road.in');reset(input);
	//assign(output,'road.out');rewrite(output);
	read(n);
	for i:=1 to n do begin read(j);a[j]:=i end;
	for i:=1 to n do begin read(j);b[a[j]]:=i end;
	for i:=1 to n do begin
		f[i]:=query(n-b[i]+1)+1;  //i->n-i+1
		add(n-b[i]+1,f[i]);
	end;
	for i:=2 to n do f[i]:=max(f[i],f[i-1]);
	write(f[n]);
	//close(input);close(output);
end.
