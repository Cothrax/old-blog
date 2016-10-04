type int=longint;
const eps=0.00000000001;
var 
	f:array[0..55,0..110] of double;
	a:array[0..55] of int;
	t,n,m,k,i,j,p,l,r:int;ans,cur:double;

procedure incd(var a:double;b:double);
begin a:=a+b end;

begin
	assign(input,'elephant.in');reset(input);
		assign(output,'elephant.out');rewrite(output);
	read(t);
	repeat
		read(n,m,k);
		fillchar(a,sizeof(a),0);
		for i:=1 to k do begin
			read(l,r);
			inc(a[l]);dec(a[r+1]);
		end;
		for i:=1 to n do inc(a[i],a[i-1]);
		//dp
		fillchar(f,sizeof(f),0);
		f[0,1]:=1;
		for i:=0 to k do
			for j:=0 to m-1 do
				if f[i,j]>eps then begin
					incd(f[i+1,j],f[i,j]/2);
					for p:=0 to m-1 do 
						incd(f[i+1,(j*p) mod m],f[i,j]/2/m);
				end;
		//calc
		ans:=0;
		for i:=1 to n do begin
			cur:=0;
			for j:=0 to m-1 do
				incd(cur,f[a[i],j]*j);
			incd(ans,cur);
		end;
		writeln(ans:0:9);
		dec(t);
	until t=0;
	close(input);close(output);
end.
