uses math;
const inf=100000000;
type
    int=longint; 
    edge=record f,t,w,next:int end;
var
    g:array[0..10010] of edge;
    head,par:array[0..10010] of int;
    f,p:array[0..10010,0..2] of int;
    n,i,j,k:int;
    
procedure add(f,t,w:int);
var m:int;
begin
    inc(head[0]);m:=head[0];
    g[m].f:=f;g[m].t:=t;g[m].w:=w;
    g[m].next:=head[f];head[f]:=m;
end;

procedure dp(v:int);
var i,u,tmp:int;
begin
    fillchar(f[v],sizeof(f[v]),0);
    i:=head[v];
    while i<>0 do begin
        u:=g[i].t;dp(u);
        tmp:=f[u,0]+g[i].w;
        if tmp>f[v,0] then begin
            f[v,1]:=f[v,0];
            f[v,0]:=tmp;
            f[v,2]:=u;
        end else if tmp>f[v,1] then
            f[v,1]:=tmp;
        i:=g[i].next;
    end;
end;

procedure dfs(v,w:int);
var i,tmp:int;
begin
    p[v]:=f[v];
    if p[par[v],2]<>v then begin
        tmp:=p[par[v],0]+w;
        if tmp>p[v,0] then begin
            p[v,1]:=p[v,0];
            p[v,0]:=tmp;
            p[v,2]:=par[v];
        end else if tmp>p[v,1] then
            p[v,1]:=tmp;
    end else begin
        tmp:=p[par[v],1]+w;
        if tmp>p[v,0] then begin
            p[v,1]:=p[v,0];
            p[v,0]:=tmp;
            p[v,2]:=par[v];
        end else if tmp>p[v,1] then
            p[v,1]:=tmp;
    end;
    i:=head[v];
    while i<>0 do begin
        dfs(g[i].t,g[i].w);
        i:=g[i].next;
    end;
end;

begin
    assign(input,'computer.in');reset(input);
    assign(output,'computer.out');rewrite(output);

    read(n);
    for i:=2 to n do begin
        read(j,k);
        add(j,i,k);par[i]:=j;
    end;
    dp(1);
    dfs(1,-inf);
    for i:=1 to n do writeln(p[i,0]);

    close(input);close(output);
end.
