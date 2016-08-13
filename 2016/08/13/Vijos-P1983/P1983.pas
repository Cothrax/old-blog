uses math;
const inf=1000000000;
type
    int=longint; 
    edge=record f,t,w,next:int end;
    ask=record f,t,w,lca:int end;
var 
    g:array[0..600010] of edge;
    head,dep,count:array[0..300010] of int;
    par,dist:array[0..300010,0..20] of int;
    a:array[0..300010] of ask;
    n,m,logn,i,j,f0,t0,w0,l,r,mid,ans:int;

procedure add(f,t,w:int);
var m:int;
begin
    inc(head[0]);m:=head[0];
    g[m].f:=f;g[m].t:=t;g[m].w:=w;
    g[m].next:=head[f];head[f]:=m;
end;

procedure dfs(v,p,d,w:int);
var i,u:int;
begin
    dep[v]:=d;par[v,0]:=p;dist[v,0]:=w;
    i:=head[v];
    while i<>0 do begin
        u:=g[i].t;
        if dep[u]=0 then dfs(u,v,d+1,g[i].w);
        i:=g[i].next;
    end;
end;

procedure lca(u,v,id:int);
var i:int;
begin
    if dep[u]<dep[v] then begin i:=u;u:=v;v:=i end;
    for i:=logn downto 0 do
        if dep[par[u,i]]>=dep[v] then begin
            inc(a[id].w,dist[u,i]);
            u:=par[u,i];
        end;
    if u=v then begin a[id].lca:=u;exit end;
    for i:=logn downto 0 do
        if par[u,i]<>par[v,i] then begin
            inc(a[id].w,dist[u,i]+dist[v,i]);
            u:=par[u,i];v:=par[v,i];
        end;
    a[id].w:=a[id].w+dist[u,0]+dist[v,0];
    a[id].lca:=par[u,0];
end;

procedure qsort(b,e:int);
var i,j,x:int;tmp:ask;
begin
    i:=b;j:=e;x:=a[random(e-b)+b].w;
    repeat
        while a[i].w<x do inc(i);
        while a[j].w>x do dec(j);
        if i<=j then begin
            tmp:=a[i];a[i]:=a[j];a[j]:=tmp;
            inc(i);dec(j);
        end;
    until i>j;
    if i<e then qsort(i,e);
    if b<j then qsort(b,j);
end;

function bin(x:int):int;
var l,r,mid:int;
begin
    l:=1;r:=m;bin:=0;
    //min(i)|a[i].w>=x
    while l<=r do begin
        mid:=(l+r) shr 1;
        if a[mid].w>x then begin bin:=mid;r:=mid-1 end
        else l:=mid+1;
    end;
end;

procedure dfs2(v:int);
var i,u:int;
begin
    i:=head[v];
    while i<>0 do begin
        u:=g[i].t;
        if u<>par[v,0] then begin
            dfs2(u);
            inc(count[v],count[u]);
        end;
        i:=g[i].next;
    end;
end;

function check(x:int):boolean;
var i,j,w,tot:int;
begin
    if a[m].w<=x then exit(true);
    j:=bin(x); //二分来卡常，然并卵
    fillchar(count,sizeof(count),0);
    w:=0;tot:=m-j+1;
    for i:=j to m do begin
        inc(count[a[i].f]);
        inc(count[a[i].t]);
        dec(count[a[i].lca],2);
        w:=max(w,a[i].w-x);
    end;
    dfs2(1);
    for i:=2 to n do
        if (count[i]=tot) and (dist[i,0]>=w) then exit(true);
    check:=false;
end;

begin
    read(n,m);
    logn:=floor(ln(n)/ln(2));
    j:=0;
    for i:=1 to n-1 do begin
        read(f0,t0,w0);
        add(f0,t0,w0);add(t0,f0,w0);
        j:=max(j,w0);
    end;
    l:=j;
    for i:=1 to m do read(a[i].f,a[i].t);

    //倍增数组和LCA
    filldword(dist,sizeof(dist) div 4,inf);
    fillchar(par,sizeof(par),0);
    dfs(1,0,1,inf);
    for i:=1 to logn do
        for j:=1 to n do begin
            par[j,i]:=par[par[j,i-1],i-1];
            if par[j,i]<>0 then
                dist[j,i]:=dist[j,i-1]+dist[par[j,i-1],i-1];
        end;
    for i:=1 to m do lca(a[i].f,a[i].t,i);
    qsort(1,m);

    //二分
    r:=a[m].w;l:=max(a[1].w-l,0);
    while l<=r do begin
        mid:=(l+r) shr 1;
        if check(mid) then begin ans:=mid;r:=mid-1 end
        else l:=mid+1;
    end;
    write(ans);
end.
