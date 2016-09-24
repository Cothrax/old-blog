type int=longint;
var 
	n,m,k,c,i,j:int;
	next,ind,cc,p,f,l,s:array[0..100010] of int;

procedure search(v:int);
begin
	while (v<>0) and (cc[v]=0) do begin
		cc[v]:=c;inc(k);l[v]:=k;f[k]:=v;
		if ind[v]=2 then p[c]:=v;
		if p[c]<>0 then inc(s[c]);
		v:=next[v];
	end;
end;

procedure solve();
var t,k,tmp:int;
begin
	read(t,k);
	tmp:=l[p[cc[t]]]-l[t];
	if tmp>=k then writeln(f[l[t]+k]);
	if tmp>0 then begin
		dec(k,tmp);
		writeln(f[l[p[cc[t]]]+k mod s[cc[t]]]);
	end;
	writeln(f[l[t]-k mod s[cc[t]]]);
end;

begin
	assign(input,'walk.in');reset(input);
	//assign(output,'walk.out');rewrite(output);
	read(n,m);
	for i:=1 to n do begin
		read(j);inc(ind[j]);next[i]:=j;
	end;
	k:=0;c:=0;
	for i:=1 to n do
		if ind[i]=0 then begin
			inc(c);search(i);
		end;
	for i:=1 to n do
		if cc[i]=0 then begin
			inc(c);p[c]:=i;search(i);
		end;
	for i:=1 to n do
		if cc[i]=9 then writeln(i,' ',next[i],' ',cc[next[i]],' ',ind[i],' ',ind[next[i]]);
	writeln;
	for i:=1 to n do
		if cc[i]=1 then writeln(i,' ',next[i]);
	for i:=1 to m do solve();
	close(input);close(output);
end.
