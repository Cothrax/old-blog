uses math;
const inf=1000000000;
type
    int=longint; 
    edge=record f,t,w,next:int end;
    ask=record f,t,w:int end;
var 
    n,m,i,j,f0,t0,w0,l,r,mid,ans:int;
    g:array[0..600010] of edge;
    head:array[0..300010] of int;
    a:array[0..300010] of ask;
    //剖分变量
    k:int;
    par,chd,dep,w,siz,top,dist,
    ev,cnt:array[0..300010] of int;
    
procedure add(f,t,w:int);
var m:int;
begin
    inc(head[0]);m:=head[0];
    g[m].f:=f;g[m].t:=t;g[m].w:=w;
    g[m].next:=head[f];head[f]:=m;
end;

procedure dfs1(v,p:int);
var i,u:int;
begin
    dep[v]:=dep[p]+1;par[v]:=p;siz[v]:=1;chd[v]:=0;
    i:=head[v];
    while i<>0 do begin
        u:=g[i].t;
        if u<>p then begin
            dist[u]:=dist[v]+g[i].w;
            dfs1(u,v);
            inc(siz[v],siz[u]);
            if siz[u]>siz[chd[v]] then chd[v]:=u;
        end;
        i:=g[i].next;
    end;
end;

procedure dfs2(v,tp:int);
var i,u:int;
begin
    inc(k);ev[k]:=dist[v]-dist[par[v]];w[v]:=k;top[v]:=tp;
    if chd[v]<>0 then dfs2(chd[v],tp);
    i:=head[v];
    while i<>0 do begin
        u:=g[i].t;
        if (u<>par[v]) and (u<>chd[v]) then begin
            dfs2(u,u);
        end;
        i:=g[i].next;
    end;
end;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

function lca(u,v:int):int;
var tu,tv:int;
begin
    while true do begin
        if dep[u]>dep[v] then swap(u,v);
        tu:=top[u];tv:=top[v];
        if tu=tv then break;
        if dep[tu]<dep[tv] then v:=par[tv] else u:=par[tu];
    end;
    lca:=u;
end;

procedure modify(u,v:int);
var tu,tv:int;
begin
    while true do begin
        if dep[u]>dep[v] then swap(u,v);
        tu:=top[u];tv:=top[v];
        if tu=tv then begin
            inc(cnt[w[u]+1]);
            dec(cnt[w[v]+1]);
            break;
        end;
        if dep[tu]<dep[tv] then begin
            inc(cnt[w[tv]+1]);
            dec(cnt[w[v]+1]);
            v:=par[tv];
        end else begin
            inc(cnt[w[tu]+1]);
            dec(cnt[w[u]+1]);
            u:=par[tu];
        end;
    end;
end;

function check(x:int):boolean;
var i,tot,maxw,cur:int;
begin
    fillchar(cnt,sizeof(cnt),0);
    tot:=0;maxw:=0;
    for i:=1 to m do
        if a[i].w>x then begin
            modify(a[i].f,a[i].t);
            inc(tot);
            maxw:=max(maxw,a[i].w-x);
        end;
    cur:=0;
    for i:=1 to k do begin
        inc(cur,cnt[i]);
        if (cur=tot) and (ev[i]>=maxw) then exit(true);
    end;
    check:=false;
end;

begin
    read(n,m);
    for i:=1 to n-1 do begin
        read(f0,t0,w0);
        add(f0,t0,w0);add(t0,f0,w0);
    end;
    for i:=1 to m do read(a[i].f,a[i].t);
    //树链剖分
    k:=0;
    dfs1(1,1);
    dfs2(1,1);

    //LCA
    for i:=1 to m do begin
        j:=lca(a[i].f,a[i].t);
        a[i].w:=dist[a[i].f]+dist[a[i].t]-2*dist[j];
    end;
    
    //二分
    l:=0;r:=inf;
    while l<=r do begin
        mid:=(l+r) shr 1;
        if check(mid) then begin ans:=mid;r:=mid-1 end
        else l:=mid+1;
    end;
    write(ans);
end.
