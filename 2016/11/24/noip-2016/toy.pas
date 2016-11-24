type int=longint;
var
	n,m,i,j,k,cur:int;
	s:ansistring;
	dir:array[0..100010] of int;
	a:array[0..100010] of ansistring;

begin
	//assign(input,'toy.in');reset(input);
	//assign(output,'toy.out');rewrite(output);
	readln(n,m);
	for i:=0 to n-1 do begin
		readln(s);j:=pos(' ',s);
		val(copy(s,1,j-1),dir[i]);//d=0 inside;d=1 outside
		a[i]:=copy(s,j+1,length(s)-j);
	end;
	cur:=0;
	for i:=1 to m do begin
		read(j,k); //j=0 left;j=1 right
		if (j=0)xor(dir[cur]=0) then cur:=(cur+k)mod n
		else cur:=((cur-k)mod n+n)mod n;
	end;
	write(a[cur]);
	//close(input);close(output);
end.
