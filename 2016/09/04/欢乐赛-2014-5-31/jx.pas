uses math;
type int=longint;
var
	n,i,j,t:int;
	sum,s:array[0..1000010] of int;
	f:array[0..1000010,0..3] of int;

procedure push(x:int);
begin
	while (t>0) and (s[t]<=x) do dec(t);
	inc(t);s[t]:=x;
end;

begin
	assign(input,'jx.in');reset(input);
	assign(output,'jx.out');rewrite(output);
	read(n);
	sum[0]:=0;
	for i:=1 to n do begin
		read(j);
		sum[i]:=sum[i-1]+j;
	end;
	//f[i,j]=max(f[k,j-1]-sum[k])+sum[i]
	f[0,0]:=0;
	for i:=1 to 3 do begin
		t:=0;
		push(f[i-1,i-1]-sum[i-1]);
		for j:=i to n do begin
			f[j,i]:=s[1]+sum[j];
			push(f[j,i-1]-sum[j]);
		end;
		for j:=i+1 to n do
			f[j,i]:=max(f[j,i],f[j-1,i]);
	end;
	write(f[n,3]);
	close(input);close(output);
end.
