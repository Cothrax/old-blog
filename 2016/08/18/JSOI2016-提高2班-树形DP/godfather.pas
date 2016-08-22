uses math;
type 
    int=longint;
    edge=record t,next:int end;
var 
    n,i,j,k,mins:int;
    g:array[0..100010] of edge;
    head,siz,f:array[0..50010] of int;

procedure add(f,t:int);
var m:int;
begin
    inc(head[0]);m:=head[0];
    g[m].t:=t;
    g[m].next:=head[f];head[f]:=m;
end;

procedure dp(v,p:int);
var i,u:int;
begin
    i:=head[v];
    siz[v]:=1;
    while i<>0 do begin
        u:=g[i].t;
        if u<>p then begin
            dp(u,v);
            inc(siz[v],siz[u]);
            f[v]:=max(f[v],siz[u]);
        end;
        i:=g[i].next;
    end;    
    f[v]:=max(f[v],n-siz[v]);
    mins:=min(mins,f[v]);
end;

begin
    assign(input,'godfather.in');reset(input);
    assign(output,'godfather.out');rewrite(output);

    read(n);
    for i:=1 to n-1 do begin
        read(j,k);
        add(j,k);add(k,j);
    end;
    mins:=maxlongint;
    dp(1,0);
    for i:=1 to n do
        if f[i]=mins then write(i,' ');

    close(input);close(output);
end.
    
