uses math;
const inf=1000000000;
type 
    int=longint;
    edge=record t,w,next:int end;
var 
    n,t,i,f0,t0,w0:int;
    g:array[0..2010] of edge;
    dist,f:array[0..1010,0..1010] of int;
    w,lim,ans,head:array[0..1010] of int;

procedure add(f,t,w:int);
var m:int;
begin
    inc(head[0]);m:=head[0];
    g[m].t:=t;g[m].w:=w;
    g[m].next:=head[f];head[f]:=m;
end;

procedure cal(v,p,d:int);
var j:int;
begin
    dist[i,v]:=d;
    j:=head[v];
    while j<>0 do begin
        if g[j].t<>p then cal(g[j].t,v,d+g[j].w);
        j:=g[j].next;
    end;
end;

procedure dp(v,p:int);
var i,j:int;
begin
    i:=head[v];
    while i<>0 do begin
        if g[i].t<>p then dp(g[i].t,v);
        i:=g[i].next;
    end;
    for i:=1 to n do
        if dist[v,i]<=lim[v] then begin
            f[v,i]:=w[i];
            j:=head[v];
            while j<>0 do begin
                if g[j].t<>p then 
                    inc(f[v,i],min(ans[g[j].t],f[g[j].t,i]-w[i]));
                j:=g[j].next;
            end;
            ans[v]:=min(ans[v],f[v,i]);
        end;
end;

begin
    assign(input,'fire.in');reset(input);
    assign(output,'fire.out');rewrite(output);
    read(t);
    while t>0 do begin
        fillchar(head,sizeof(head),0);
        filldword(ans,sizeof(ans) shr 2,inf);
        filldword(f,sizeof(f) shr 2,inf);
        filldword(dist,sizeof(dist) shr 2,inf);
        
        read(n);
        for i:=1 to n do read(w[i]);
        for i:=1 to n do read(lim[i]);
        for i:=1 to n-1 do begin
            read(f0,t0,w0);
            add(f0,t0,w0);add(t0,f0,w0);
        end;
        for i:=1 to n do cal(i,0,0);
        
        dp(1,0);
        writeln(ans[1]);
        dec(t);
    end;
    close(input);close(output);
end.
