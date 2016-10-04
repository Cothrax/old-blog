type int=longint;
var 
	par,w,s:array[0..10010] of int;
	t,n,m,i,j,x,y:int;c:char;

function find(x:int):int;
begin
	if par[x]=x then find:=x
	else begin
		find:=find(par[x]);
		inc(w[x],w[par[x]]);
		par[x]:=find;
	end;
end;

procedure union(x,y:int); //x->y
begin
	x:=find(x);y:=find(y);
	par[x]:=y;inc(s[y],s[x]);
	inc(w[x]);w[x]:=w[y]-w[x];
end;

procedure query(x:int);
begin
	y:=find(x);writeln(y,' ',s[y],' ',w[y]-w[x]);
end;

begin
	assign(input,'meteorite.in');reset(input);
	assign(output,'meteorite.out');rewrite(output);
	readln(t);
	for j:=1 to t do begin
		readln(n,m);
		for i:=1 to n do begin 
			par[i]:=i;w[i]:=0;s[i]:=1
		end;
		writeln('Case ',j,': ');
		for i:=1 to m do begin
			read(c);
			case c of 
				'T':begin readln(x,y);union(x,y) end;
				'Q':begin readln(x);query(x) end;
			end;
		end;
	end;
	close(input);close(output);
end.
