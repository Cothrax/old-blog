type int=longint;
var 
	h,t,s,f:array[0..1000010] of int;
	c,next:array[0..100010] of int;
	n,m,i,x,a,b,ans:int;
	
procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure merge(a,b:int);
var i:int;
begin
	i:=h[a];
	while i<>0 do begin
		if c[i-1]=b then dec(ans);
		if c[i+1]=b then dec(ans);
		i:=next[i];
	end;
	i:=h[a];
	while i<>0 do begin c[i]:=b;i:=next[i] end;
	next[t[b]]:=h[a];t[b]:=t[a];inc(s[b],s[a]);
	s[a]:=0;h[a]:=0;t[a]:=0;
end;

begin
	assign(input,'pudding.in');reset(input);
	assign(output,'pudding.out');rewrite(output);
	read(n,m);ans:=0;
	for i:=1 to n do begin
		read(c[i]);
		if c[i]<>c[i-1] then inc(ans);
		f[c[i]]:=c[i];
		if h[c[i]]=0 then t[c[i]]:=i;
		inc(s[c[i]]);next[i]:=h[c[i]];h[c[i]]:=i;
	end;
	for i:=1 to m do begin
		read(x);
		if x=1 then begin
			read(a,b);
			if a=b then continue;
			if s[f[a]]>s[f[b]] then 
				swap(f[a],f[b]);
			a:=f[a];b:=f[b];
			if s[a]=0 then continue;
			merge(a,b);
		end else writeln(ans);
	end;
	close(input);close(output);
end.
