type int=longint;
const eps=0.0000000001;
var 
	g,g0:array[0..110,0..110] of double;
	tmp:array[0..110] of double;
	n,m,i,j,k,r,p:int;
	f:double;

procedure inc(var a:double;b:double);
begin a:=a+b end;

begin
	assign(input,'resistor.in');reset(input);
	assign(output,'resistor.out');rewrite(output);
	while not eof do begin
		readln(n,m);
		fillchar(g,sizeof(g),0);
		for i:=1 to m do begin
			readln(j,k,r);
			inc(g[j,k],1/r);inc(g[j,j],-1/r);
			inc(g[k,j],1/r);inc(g[k,k],-1/r);
		end;
		g0:=g;
		for i:=1 to n do begin
			g[1,i]:=0;g[n,i]:=0;
		end;
		g[1,1]:=1;g[1,n+1]:=1;
		g[n,n]:=1;g[n,n+1]:=0;
		for i:=1 to n do begin
			p:=i;
			for j:=i+1 to n do 
				if abs(g[j,i])>abs(g[p,i]) then p:=j;
			tmp:=g[i];g[i]:=g[p];g[p]:=tmp;
			for j:=i+1 to n+1 do g[i,j]:=g[i,j]/g[i,i];
			for j:=1 to n do
				if j<>i then
					for k:=i+1 to n+1 do 
						inc(g[j,k],-g[j,i]*g[i,k]);
		end;
		f:=0;
		for i:=1 to n do
			if abs(g0[1,i])>eps then inc(f,g[i,n+1]*g0[1,i]);
		writeln(round(abs(1/f)*100)/100:0:2);
	end;
	close(input);close(output);
end.
