uses math;
type int=longint;
var
	t,k,mxn,mxm,ans,i,j:int;
	q:array[0..10010,0..1] of int;
	c,f:array[-1..2010,-1..2010] of int;
begin
	//assign(input,'problem.in');reset(input);
	//assign(output,'problem.out');rewrite(output);
	read(t,k);mxn:=0;mxm:=0;
	for i:=1 to t do begin
		read(q[i,0],q[i,1]);
		mxn:=max(mxn,q[i,0]);mxm:=max(mxm,q[i,1]);
	end;
	c[0,0]:=1;if k=1 then f[0,0]:=1;
	for i:=1 to mxn do
		for j:=0 to min(mxm,i) do begin
			c[i,j]:=(c[i-1,j]+c[i-1,j-1])mod k;
			if c[i,j]=0 then f[i,j]:=1;
		end;
	for i:=0 to mxn do
		for j:=1 to mxm do
			f[i,j]:=f[i,j]+f[i,j-1];
	for i:=1 to t do begin
		ans:=0;
		for j:=0 to q[i,0] do
			ans:=ans+f[j,q[i,1]];
		writeln(ans);
	end;
	//close(input);close(output);
end.
