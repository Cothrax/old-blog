uses math;
const eps:double=0.000000001;
type int=longint;
var 
	a,b,lim,ans:int64;i,j:int;
	g,f:array[0..100] of int64;

function fl(a:double):int64;
begin
	if abs(a-round(a))<eps then exit(round(a))
	else exit(floor(a));
end;

function ce(a:double):int64;
begin
	if abs(a-round(a))<eps then exit(round(a))
	else exit(ceil(a));
end;
	
begin
	assign(input,'t2.in');reset(input);
	assign(output,'t2.out');rewrite(output);
	read(a,b);
	while (a<>0) and (b<>0) do begin
		fillchar(g,sizeof(g),0);
		fillchar(f,sizeof(f),0);
		lim:=floor(ln(b)/ln(2));
		f[1]:=b-a+1;
		for i:=2 to lim do
			f[i]:=fl(exp(1/i*ln(b)))-ce(exp(1/i*ln(a)))+1;
		for i:=lim downto 1 do begin
			g[i]:=f[i];j:=2*i;
			while j<=lim do begin
				dec(g[i],g[j]);
				inc(j,i);
			end;
		end;
		ans:=0;
		for i:=1 to lim do inc(ans,g[i]*i);
		writeln(ans);
		read(a,b);
	end;
	close(input);close(output);
end.
