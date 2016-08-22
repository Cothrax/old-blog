type int=longint;
var 
	sgt,tag:array[0..400010] of int;
	n,m,i,j,x,y:int;

procedure putdown(i,b,e:int);
var mid:int;
begin
	if b<e then begin
		mid:=(b+e) shr 1;
		tag[i*2]:=1-tag[i*2];sgt[i*2]:=mid-b+1-sgt[i*2];
		tag[i*2+1]:=1-tag[i*2+1];sgt[i*2+1]:=e-mid-sgt[i*2+1];
	end;
	tag[i]:=0;
end;

function query(i,b,e,l,r:int):int;
var mid:int;
begin
	if (r<b) or (l>e) then exit(0);
	if (l<=b) and (e<=r) then exit(sgt[i]);
	mid:=(b+e) shr 1;
	if tag[i]=1 then putdown(i,b,e);
	query:=query(i*2,b,mid,l,r)+query(i*2+1,mid+1,e,l,r);
end;

procedure insert(i,b,e,l,r:int);
var mid:int;
begin
	if (r<b) or (l>e) then exit;
	if (l<=b) and (e<=r) then begin
		sgt[i]:=e-b+1-sgt[i];
		tag[i]:=1-tag[i];
		exit;
	end;
	mid:=(b+e) shr 1;
	if tag[i]=1 then putdown(i,b,e);
	insert(i*2,b,mid,l,r);insert(i*2+1,mid+1,e,l,r);
	sgt[i]:=sgt[i*2]+sgt[i*2+1];
end;

begin
	assign(input,'lites.in');reset(input);
	assign(output,'lites.out');rewrite(output);
	read(n,m);
	for i:=1 to m do begin
		read(j,x,y);
		if j=0 then insert(1,1,n,x,y)
		else writeln(query(1,1,n,x,y));
	end;
	close(input);close(output);
end.