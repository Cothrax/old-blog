type 
    int=longint;
    edge=record t,next:int end;
var 
    n,m,i,f0,t0,cnt:int;sum,ans:int64;
    g:array[0..2000010] of edge;
    head:array[0..100010] of int;
    w,f:array[0..100010] of int64;

function min(a,b:int64):int64;
begin if a>b then min:=b else min:=a end;

function qabs(a:int64):int64;
begin if a<0 then qabs:=-a else qabs:=a end;

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
    f[v]:=w[v];
    i:=head[v];
    while i<>0 do begin
        u:=g[i].t;
        if p<>u then begin
            dp(u,v);
            inc(f[v],f[u]);
        end;
        i:=g[i].next;
    end;
    ans:=min(ans,qabs(sum-f[v]*2));
end;
    
begin
    read(n,m);cnt:=0;
    while (n<>0) and (m<>0) do begin
        fillchar(head,sizeof(head),0);
        sum:=0;
        for i:=1 to n do begin
            read(w[i]);
            inc(sum,w[i]);
        end;
        for i:=1 to m do begin
            read(f0,t0);
            add(f0,t0);add(t0,f0);
        end;
        ans:=sum;
        dp(1,0);
        inc(cnt);
        writeln('Case ',cnt,': ',ans);
        read(n,m);
    end;
end.
