uses math;
const inf=1000000000;
type
    int=longint;
    edge=record t,next:int end;
var
    g:array[0..100010] of edge;
    head,dep,w,dist:array[0..100010] of int;
    d:array[0..100010,0..1] of int;
    par,mxw:array[0..100010,0..25] of int;
    n,logn,q,i,j:int;

procedure add(f,t:int);
var m:int;
begin
    inc(head[0]);m:=head[0];
    g[m].t:=t;
    g[m].next:=head[f];head[f]:=m;
end;
//为了省事，更新答案用
procedure update(var x,y:int;nx,ny:int);
begin
    if (nx<x) or ((nx=x) and (ny>y)) then
        begin x:=nx;y:=ny end;
end;

procedure dfs(v,p:int);
var i,u:int;
begin
    dep[v]:=dep[p]+1; //深度
    dist[v]:=dist[p]+w[v]; //到根的路径上的点权和
    par[v,0]:=p; //父节点
    mxw[v,0]:=max(w[p],w[v]); //倍增路径上的最大点权
    i:=head[v];
    //d是dp数组，d[v,0]是离最近叶子的路径上的点权和，d[v,1]是这个路径上的最大点权
    if i=0 then d[v,0]:=w[v] else d[v,0]:=inf;
    d[v,1]:=w[v];
    while i<>0 do begin
        u:=g[i].t;
        dfs(u,v);
        update(d[v,0],d[v,1],d[u,0]+w[v],max(d[u,1],w[v]));
        i:=g[i].next;
    end;
end;

procedure dp(v,p:int);
var i:int;
begin
    update(d[v,0],d[v,1],d[p,0]+w[v],max(d[p,1],w[v]));
    i:=head[v];
    while i<>0 do begin
        dp(g[i].t,v);
        i:=g[i].next;
    end;
end;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure lca(u,v:int;var c,mx:int);
var i:int;
begin
    if dep[u]<dep[v] then swap(u,v);
    mx:=max(w[u],w[v]);
    for i:=logn downto 0 do
        if dep[par[u,i]]>=dep[v] then begin
            mx:=max(mx,mxw[u,i]);
            u:=par[u,i];
        end;
    if u=v then begin c:=u;exit end;
    for i:=logn downto 0 do
        if par[u,i]<>par[v,i] then begin
            mx:=max(mx,max(mxw[u,i],mxw[v,i]));
            u:=par[u,i];v:=par[v,i];
        end;
    mx:=max(mx,max(mxw[u,0],mxw[v,0]));
    c:=par[u,0];
end;

procedure solve();
var t1,t2,c,mx,mx1,md,md1:int;
begin
    read(t1,t2);
    if t1=t2 then begin writeln(w[t1],' ',w[t1]);exit end;
    //Case 1
    lca(t1,t2,c,mx);
    md:=dist[t1]+dist[t2]-2*dist[c]+w[c];
    //Case 2.1
    mx1:=max(mxw[t1,logn],d[t2,1]);
    md1:=dist[t1]+d[t2,0];
    update(md,mx,md1,mx1);
    //Case 2.2
    mx1:=max(mxw[t2,logn],d[t1,1]);
    md1:=dist[t2]+d[t1,0];
    update(md,mx,md1,mx1);
    //Case 3
    mx1:=max(w[1],max(d[t1,1],d[t2,1]));
    md1:=d[t1,0]+d[t2,0]+w[1];
    update(md,mx,md1,mx1);

    writeln(md,' ',mx);
end;

begin
    assign(input,'plutotree.in');reset(input);
    assign(output,'plutotree.out');rewrite(output);
    read(n,q);
    for i:=2 to n do begin
        read(j);add(j,i);
    end;
    for i:=1 to n do read(w[i]);
    dfs(1,0);
    dp(1,1);
    //倍增数组
    logn:=floor(ln(n)/ln(2));
    for i:=1 to logn do
        for j:=1 to n do begin
            par[j,i]:=par[par[j,i-1],i-1];
            mxw[j,i]:=max(mxw[j,i-1],mxw[par[j,i-1],i-1]);
        end;
    for i:=1 to q do solve();
    close(input);close(output);
end.
