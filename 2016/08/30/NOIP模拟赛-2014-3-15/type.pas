type int=longint;
var 
	a:array[0..100010] of char;
	i,j,n,p:int;c,x:char;
begin
	assign(input,'type.in');reset(input);
	assign(output,'type.out');rewrite(output);
	readln(n);
	p:=0;
	for i:=1 to n do begin
		read(c);read(x);
		case c of 
			'T':begin inc(p);readln(a[p]) end;
			'U':begin readln(j);dec(p,j) end;
			'Q':begin readln(j);writeln(a[j]) end;
		end;
	end;
	close(input);close(output);
end.
