type int=longint;
var 
	t,i,pos,neg:int;
	a,b:array[0..2] of int;

procedure solv(i,j:int);
begin
	if i>j then inc(pos,(i-j) div 2) else inc(neg,j-i);
end;

begin
	assign(input,'osiris.in');reset(input);
	assign(output,'osiris.out');rewrite(output);
	read(t);
	repeat
		read(a[0],a[1],a[2],b[0],b[1],b[2]);
		pos:=0;neg:=0;
		for i:=0 to 2 do solv(a[i],b[i]);
		if pos>=neg then writeln('YES') else writeln('NO');
		dec(t);
	until t=0;
	close(input);close(output);
end.
