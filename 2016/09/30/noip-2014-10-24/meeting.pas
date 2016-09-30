type int=longint;
var
	t,n,i:int;
	a:ansistring;

function od():int64;
var cnt,del,s0,s1,d:int64;i:int;
begin
	cnt:=n*(n-1) div 2;
	s0:=0;s1:=0;
	for i:=1 to n do
		if a[i]='0' then inc(s0)
		else inc(s1);
	del:=s0*s1*3;
	if n mod 3=0 then begin
		d:=n div 3;
		dec(cnt,d*2);
		for i:=1 to d do
			if (a[i]<>a[i+d]) or 
				(a[i+d]<>a[i+2*d]) then dec(del,4);
	end;
	od:=cnt-del div 2;
end;

function ev():int64;
var 
	cnt,del,d:int64;i:int;
	s0,s1:array[0..1] of int64;
begin
	cnt:=n*(n div 2-1);
	s0[0]:=0;s0[1]:=0;s1[0]:=0;s1[1]:=0;
	for i:=1 to n do
		if a[i]='0' then inc(s0[i and 1])
		else inc(s1[i and 1]);
	del:=(s0[0]*s1[0]+s0[1]*s1[1])*4+
		(s0[1]*s1[0]+s1[1]*s0[0])*2;
	d:=n div 2;
	for i:=1 to d do
		if a[i]<>a[i+d] then
			dec(del,2);
	if n mod 3=0 then begin
		d:=n div 3;
		dec(cnt,d*2);
		for i:=1 to d do
			if (a[i]<>a[i+d]) or 
				(a[i+d]<>a[i+2*d]) then dec(del,4);
	end;
	ev:=cnt-del div 2;
end;

begin
	assign(input,'meeting.in');reset(input);
	assign(output,'meeting.out');rewrite(output);
	readln(t);
	for i:=1 to t do begin
		readln(a);
		n:=length(a);
		write('Case ',i,': ');
		if odd(n) then writeln(od()) else writeln(ev);
	end;
	close(input);close(output);
end.
