type int=longint;
var 
	n,i,p,j,ans:int;
	cnt:array[0..40] of int;
	a:array[0..300010] of int;

procedure calc(x:int);
var i:int;
begin
	for i:=0 to 30 do
		if ((x shr i) and 1)=1 then inc(cnt[i]);
end;

begin
	assign(input,'and.in');reset(input);
	assign(output,'and.out');rewrite(output);
	read(n);
	for i:=1 to n do read(a[i]);
	ans:=0;p:=31;
	while true do begin
		fillchar(cnt,sizeof(cnt),0);
		for i:=1 to n do
			if (ans and a[i])=ans then calc(a[i]);
		//for i:=0 to 31 do write(cnt[i]:3);writeln;
		j:=-1;
		for i:=p downto 0 do
			if cnt[i]>=2 then begin
				ans:=ans or (1 shl i);
				j:=i-1;break;
			end;
		if j=-1 then break;
		p:=j;
	end;
	write(ans);
	close(input);close(output);
end.
