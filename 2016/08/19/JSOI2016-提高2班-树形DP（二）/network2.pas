var f:array[1..55,0..2047] of longint;
    g:array[0..2047] of longint;
    q:array[1..55] of boolean;
    e:array[1..110] of record go,len,next:longint end;
    a:array[1..55] of longint;
    cost:array[1..55,1..11] of longint;
    n,m,i,j,k,l,ef:longint;

procedure addedge(x,y,l:longint);
begin
  ef:=ef+1; e[ef].go:=y; e[ef].len:=l;
  e[ef].next:=a[x]; a[x]:=ef;
  ef:=ef+1; e[ef].go:=x; e[ef].len:=l;
  e[ef].next:=a[y]; a[y]:=ef;
end;

procedure solve(u:longint);
var i,j,k:longint; flag:boolean;
begin
  q[u]:=true; f[u,0]:=0;
  k:=a[u]; flag:=false;
  while k>0 do
  begin
    if not q[e[k].go] then
    begin
      solve(e[k].go);
      if not flag then
      begin
        for i:=1 to 1 shl m-1 do
          if f[e[k].go,i]+e[k].len<f[u,i] then
            f[u,i]:=f[e[k].go,i]+e[k].len;
      end
      else begin
        g:=f[u];
        for i:=0 to 1 shl m-1 do
          for j:=1 to 1 shl m-1 do
            if i and j=0 then
              if f[u,i]+f[e[k].go,j]+e[k].len<g[i or j] then
                g[i or j]:=f[u,i]+f[e[k].go,j]+e[k].len;
        f[u]:=g;
      end;
    end;
    k:=e[k].next;
    flag:=true;
  end;
  g:=f[u];
  for i:=0 to 1 shl m-2 do
    for j:=1 to m do
      if i and (1 shl (j-1))=0 then
        if f[u,i]+cost[u,j]<g[i or (1 shl (j-1))] then
          g[i or (1 shl (j-1))]:=f[u,i]+cost[u,j];
  f[u]:=g;
end;
    
begin
  assign(input,'network.in');reset(input);
  assign(output,'network.out');rewrite(output);
 
  readln(n,m);
  ef:=0;
  fillchar(e,sizeof(e),0);
  for i:=1 to n-1 do
  begin
    readln(j,k,l);
    addedge(j,k,l);
  end;
  for i:=1 to n do
    for j:=1 to m do
      read(cost[i,j]);

  fillchar(q,sizeof(q),false);
  filldword(f,sizeof(f) div 4,maxlongint shr 4);
  solve(1);
  writeln(f[1,1 shl m-1]);

 close(input);
 close(output);
end.
