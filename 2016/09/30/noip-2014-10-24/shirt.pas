type int=longint;
const inf=1000000007;
var 
	t,n,m,i,j:int;
	a:array[0..110] of int;
	f:array[0..110,0..1 shl 10] of qword;

procedure inc(var a:qword;b:qword);
begin
	a:=a+b;
	if a>=inf then a:=a mod inf;
end;

procedure update(i,s:int);
var lb,x:int;
begin
	x:=a[i];
	inc(f[i+1,s],f[i,s]);
	while x>0 do begin
		lb:=x and (-x);
		if (s or lb)>s then 
			inc(f[i+1,s or lb],f[i,s]);
		x:=x and not lb;
	end;
end;

begin
	assign(input,'shirt.in');reset(input);
	assign(output,'shirt.out');rewrite(output);
	read(t);
	repeat
		readln(n);m:=1 shl n-1;
		fillchar(a,sizeof(a),0);
		for i:=1 to n do begin
			while not eoln do begin
				read(j);
				a[j]:=a[j] or (1 shl (i-1));
			end;
			readln;
		end;
		//f[i,s] style i, 1..i-1 -> s
		//f[i+1,s+?]+=f[i,s]
		fillchar(f,sizeof(f),0);
		f[1,0]:=1;
		for i:=1 to 100 do
			for j:=0 to m do
				if f[i,j]>0 then update(i,j);
		writeln(f[101,m]);
		dec(t);
	until t=0;
	close(input);close(output);
end.
