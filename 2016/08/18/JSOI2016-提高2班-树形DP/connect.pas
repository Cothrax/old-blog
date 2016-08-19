uses math;
type 
    int=longint;
    edge=record t,next:int end;
    tree=array[0..200010] of edge;
    arr=array[0..100010] of int;
var 
    t:array[0..1] of tree;
    h:array[0..1] of arr;
    f,g:array[0..1,0..100010,0..2] of int;
    cnt:array[0..1,0..100010] of int;
    d,n:array[0..1] of int;
    i,j,f0,t0,dl,k,tmp:int;ans:int64;

procedure add(var g:tree;var head:arr;f,t:int);
var m:int;
begin
    inc(head[0]);m:=head[0];
    g[m].t:=t;
    g[m].next:=head[f];head[f]:=m;
end;

procedure dp(x,v,p:int);
var i,u,tmp:int;
begin
    fillchar(f[x,v],sizeof(f[x,v]),0);
    i:=h[x][v];
    while i<>0 do begin
        u:=t[x][i].t;
        if u<>p then begin
            dp(x,u,v);
            tmp:=f[x,u,0]+1;
            if tmp>f[x,v,0] then begin
                f[x,v,1]:=f[x,v,0];
                f[x,v,0]:=tmp;
                f[x,v,2]:=u;
            end else if tmp>f[x,v,1] then 
                f[x,v,1]:=tmp;
        end;
        i:=t[x][i].next;
    end;
end;

procedure dfs(x,v,p:int);
var i,tmp:int;
begin
    g[x,v]:=f[x,v];
    if p<>0 then 
        if g[x,p,2]<>v then begin
            tmp:=g[x,p,0]+1;
            if tmp>g[x,v,0] then begin
                g[x,v,1]:=g[x,v,0];
                g[x,v,0]:=tmp;
                g[x,v,2]:=p;
            end else if tmp>g[x,v,1] then
                g[x,v,1]:=tmp;
        end else begin
            tmp:=g[x,p,1]+1;
            if tmp>g[x,v,0] then begin
                g[x,v,1]:=g[x,v,0];
                g[x,v,0]:=tmp;
                g[x,v,2]:=p;
            end else if tmp>g[x,v,1] then
                g[x,v,1]:=tmp;
        end;
    i:=h[x][v];
    while i<>0 do begin
        if t[x][i].t<>p then dfs(x,t[x][i].t,v);
        i:=t[x][i].next;
    end;
end;

begin
    assign(input,'connect.in');reset(input);
    assign(output,'connect.out');rewrite(output);

    read(n[0],n[1]);
    for i:=0 to 1 do
        for j:=1 to n[i]-1 do begin
            read(f0,t0);
            add(t[i],h[i],f0,t0);add(t[i],h[i],t0,f0);
        end;
    for i:=0 to 1 do begin 
        dp(i,1,0);
        dfs(i,1,0) 
    end;
    
    for i:=0 to 1 do begin
        d[i]:=0;
        for j:=1 to n[i] do begin
            inc(cnt[i,g[i,j,0]]);
            d[i]:=max(d[i],g[i,j,0]);
        end;
        for j:=1 to d[i] do
            inc(cnt[i,j],cnt[i,j-1]);
    end;
    dl:=max(d[0],d[1]);
    ans:=0;k:=0;
    for i:=0 to 1 do
        for j:=1 to n[i] do begin
            tmp:=n[1-i]-cnt[1-i,dl-g[i,j,0]-1];
            inc(ans,tmp*g[i,j,0]);
            if i=0 then inc(k,tmp);
        end;
    inc(ans,k+(n[0]*n[1]-k)*dl);
    write(ans);

    close(input);close(output);
end.
