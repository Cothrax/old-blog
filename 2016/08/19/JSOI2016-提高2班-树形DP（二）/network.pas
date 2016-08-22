uses math;
const inf=1000000000;
type 
    int=longint;
    edge=record t,w,next:int end;
var 
    g:array[0..120] of edge; //存多叉
    head,br,ch,w,siz:array[0..60] of int;
    a:array[0..60,0..15] of int;
    f:array[0..60,0..1 shl 11-1] of int;
    cnt:array[0..1 shl 11-1] of int;
    n,m,k,i,j,f0,t0,w0:int;

procedure add(f,t,w:int);
var m:int;
begin
    inc(head[0]);m:=head[0];
    g[m].t:=t;g[m].w:=w;
    g[m].next:=head[f];head[f]:=m;
end;
//多叉转二叉
procedure dfs(v,p,w0:int);inline;
var i,u:int;
begin
    br[v]:=ch[p];ch[p]:=v;w[v]:=w0;
    i:=head[v];
    while i<>0 do begin
        u:=g[i].t;
        if u<>p then dfs(u,v,g[i].w);
        i:=g[i].next;
    end;
end;
//计算x的二进制表示中1的个数
function count(x:int):int;
begin
    count:=0;
    while x<>0 do begin
        inc(count);
        dec(x,x and (-x));
    end;
end;
//计算以v为根的子树的节点数
function cal(v:int):int;
begin
    if v=0 then exit(0);
    siz[v]:=cal(ch[v])+cal(br[v])+1;
    cal:=siz[v];
end;

function dp(v,s:int):int;
var x,i,j,s1,s2,tmp:int;
begin
    if cnt[s]>siz[v] then exit(inf); //剪枝
    if f[v,s]<>-1 then exit(f[v,s]);
    if s=0 then exit(0);
    if v=0 then exit(inf);

    x:=s;
    f[v,s]:=inf;
    while x<>0 do begin //枚举v做的卷子
        i:=x and (-x);
        j:=round(ln(i)/ln(2))+1;
        s1:=s and not i;
        f[v,s]:=min(f[v,s],w[v]+a[v,j]+min(dp(br[v],s1),dp(ch[v],s1)));
        
        s2:=s1;
        while s2<>0 do begin //枚举子节点做的卷子
            tmp:=w[v]+a[v,j]+dp(ch[v],s2)+dp(br[v],s1 xor s2);
            f[v,s]:=min(f[v,s],tmp);
            s2:=(s2-1) and s1;
        end;
        x:=x and not i;
    end;
    s1:=s; //v不做卷子
    while s1<>0 do begin //枚举子节点做的卷子
        f[v,s]:=min(f[v,s],w[v]+dp(ch[v],s1)+dp(br[v],s xor s1));
        s1:=(s1-1) and s;
    end;
    f[v,s]:=min(f[v,s],dp(br[v],s)); //全给兄弟做
    dp:=f[v,s];
end;

begin
    assign(input,'network.in');reset(input);
    assign(output,'network.out');rewrite(output);

    read(n,m);
    k:=1 shl m-1;
    for i:=1 to k do cnt[i]:=count(i);
    for i:=1 to n-1 do begin
        read(f0,t0,w0);
        add(f0,t0,w0);add(t0,f0,w0);
    end;
    dfs(1,0,0);cal(1);
    for i:=1 to n do
        for j:=1 to m do read(a[i,j]);
    
    filldword(f,sizeof(f) div 4,-1);
    write(dp(1,k));

    close(input);close(output);
end.
