type int=longint;
var 
	a,bit,b,p,lb,ub,opt:array[0..100010] of int;
	n,k,i,j,l,cnt:int;
	
function lowbit(x:int):int;
begin lowbit:=x and (-x) end;

procedure add(x,k:int);
begin
	if x=0 then exit;
	while x<=100010 do begin
		inc(bit[x],k);
		inc(x,lowbit(x));
	end;
end;

function sum(x:int):int;
begin
	sum:=0;
	while x>0 do begin
		inc(sum,bit[x]);
		dec(x,lowbit(x));
	end;
end;

begin
	assign(input,'message.in');reset(input);
	assign(output,'message.out');rewrite(output);
	read(n,k);
	for i:=1 to n do read(a[i]);
	for i:=1 to k do read(b[i]);
	fillchar(bit,sizeof(bit),0);
	for i:=1 to k do begin
		add(b[i],1);
		ub[i]:=sum(b[i]);
		lb[i]:=sum(b[i]-1);
	end;
	fillchar(bit,sizeof(bit),0);
	p[1]:=0;j:=0;
	for i:=2 to k do begin
		add(b[i],1);
		while (j<>0) and ((lb[j+1]<>sum(b[i]-1)) or 
			(ub[j+1]<>sum(b[i]))) do begin
			for l:=i-j to i-p[j]-1 do add(b[l],-1);
			j:=p[j];
		end;
		if (lb[j+1]=sum(b[i]-1)) and (ub[j+1]=sum(b[i])) then inc(j);
		p[i]:=j
	end;
	fillchar(bit,sizeof(bit),0);
	j:=0;cnt:=0;
 	for i:=1 to n do begin
 		add(a[i],1);
 		while (j<>0) and ((lb[j+1]<>sum(a[i]-1)) or
 			(ub[j+1]<>sum(a[i]))) do begin
 			for l:=i-j to i-p[j]-1 do add(a[l],-1);
 			j:=p[j];
 		end;
	 	if (lb[j+1]=sum(a[i]-1)) and (ub[j+1]=sum(a[i])) then inc(j);
	 	if j=k then begin
	 		inc(cnt);opt[cnt]:=i-j+1;
	 		for l:=i-j+1 to i-p[j] do add(a[l],-1);
	 		j:=p[j];
 		end;
 	end;
 	writeln(cnt);
 	for i:=1 to cnt do writeln(opt[i]);
 	close(input);close(output);
end.

