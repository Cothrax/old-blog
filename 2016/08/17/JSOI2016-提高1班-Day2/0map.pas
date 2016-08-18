uses math;
type int=longint;
const inf=100000000;
var 
    n,m,k,i,j,t1,t2,ans,last:int;
    f:array[0..310,0..310] of int; //floyd
    e:array[0..310,0..2010,0..1] of int; //原始数据
    g:array[0..600010,0..1] of int; //压缩后数据
    cnt,l,r,p:array[0..100010] of int; //计数,左端点,右端点
    s:array[0..310] of int; //题中的l

begin
    assign(input,'map.in');reset(input);
    assign(output,'map.out');rewrite(output);
    //input
    read(n,m);
    fillchar(cnt,sizeof(cnt),0);
    for i:=1 to m do begin
        read(s[i]);
        for j:=1 to s[i] do begin
            read(e[i,j,0],e[i,j,1]);
            inc(cnt[e[i,j,0]]);
        end;
    end;
    //指针
    last:=0;
    for i:=1 to n do begin
        l[i]:=last+1;
        r[i]:=last+cnt[i];
        p[i]:=l[i];
        last:=r[i];
    end;
    //e压进g（类似计数排序）
    for i:=1 to m do    
        for j:=1 to s[i] do begin
            g[p[e[i,j,0]],0]:=i;
            g[p[e[i,j,0]],1]:=e[i,j,1];
            inc(p[e[i,j,0]]);
        end;
    //init f
    filldword(f,sizeof(f) div 4,inf);
    for i:=1 to n do
        for j:=l[i] to r[i] do
            for k:=l[i] to r[i] do
                f[g[j,0],g[k,0]]:=min(f[g[j,0],g[k,0]],g[j,1]+g[k,1]);
    for i:=1 to m do f[i,i]:=0;
    //floyd
    for k:=1 to m do
        for i:=1 to m do    
            for j:=1 to m do
                f[i,j]:=min(f[i,j],f[i,k]+f[k,j]);
    //query
    read(t1,t2);
    while (t1<>0) and (t2<>0) do begin
        ans:=inf;
        for i:=l[t1] to r[t1] do
            for j:=l[t2] to r[t2] do
                ans:=min(ans,g[i,1]+f[g[i,0],g[j,0]]+g[j,1]);
        if ans=inf then writeln(-1) else writeln(ans);
        read(t1,t2);
    end;

    close(input);close(output);
end.
