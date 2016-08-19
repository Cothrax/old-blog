uses math;
type 
    int=longint;
    edge=record t,next:int end;
var 
    g:array[0..100010] of edge;
    head,dfn,low,s:array[0..100010] of int;
    ins:array[0..100010] of boolean;
    n,m,i,j,t,tim,ans:int;

procedure add(f,t:int);
var m:int;
begin
    inc(head[0]);m:=head[0];
    g[m].t:=t;
    g[m].next:=head[f];head[f]:=m;
end;

procedure tarjan(v:int);
var i,u,cnt:int;
begin
    inc(tim);dfn[v]:=tim;low[v]:=tim;
    inc(t);s[t]:=v;ins[v]:=true;
    i:=head[v];
    while i<>0 do begin
        u:=g[i].t;
        if dfn[u]=0 then begin
            tarjan(u);
            low[v]:=min(low[v],low[u]);
        end else if ins[u] then
            low[v]:=min(low[v],dfn[u]);
        i:=g[i].next;
    end;
    if low[v]=dfn[v] then begin
        cnt:=0;
        while s[t+1]<>v do begin
            inc(cnt);
            ins[s[t]]:=false;
            dec(t);
        end;
        ans:=max(ans,cnt);
    end;
end;

begin
    assign(input,'friend.in');reset(input);
    assign(output,'friend.out');rewrite(output);

    read(n,m);
    fillchar(head,sizeof(head),0);
    for i:=1 to m do begin
        read(j,t);add(j,t);
    end;
    t:=0;tim:=0;ans:=0;
    fillchar(dfn,sizeof(dfn),0);
    fillchar(ins,sizeof(ins),false);
    for i:=1 to n do if dfn[i]=0 then tarjan(i);
    write(ans);

    close(input);close(output);
end.
