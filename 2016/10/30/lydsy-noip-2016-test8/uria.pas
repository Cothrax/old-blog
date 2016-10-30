type int=longint;
var
	n,ans,i,sq:int64;
	phi,p:array[0..10000010] of int;
	f:array[0..10000100] of boolean;

procedure euler();
var i,j,t,k:int;
begin
	phi[1]:=1;k:=0;
	for i:=2 to sq do begin
		if not f[i] then begin
			inc(k);p[k]:=i;phi[i]:=i-1;
		end;
		j:=1;t:=p[j]*i;
		while t<=sq do begin
			f[t]:=true;
			if i mod p[j]=0 then begin
				phi[t]:=p[j]*phi[i];break
			end else
				phi[t]:=(p[j]-1)*phi[i];
			inc(j);t:=p[j]*i;
		end;
	end;
end;

begin
	//assign(input,'uria.in');reset(input);
	//assign(output,'uria.out');rewrite(output);
	read(n);sq:=trunc(sqrt(n));
	foo();halt;
	euler();ans:=0;i:=2;
	while i<=sq do begin
		inc(ans,phi[i]*trunc(n/(i*i)));
		inc(i);
	end;
	write(ans);
	close(input);close(output);
end.

