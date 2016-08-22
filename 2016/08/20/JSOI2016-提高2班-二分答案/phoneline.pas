uses math;
type
    int=longint;
    edge=record t,next,w:int end;
var 
    g:array[0..20010] of edge;
    head:array[0..1010] of int;
    used:array[0..1010,0..1010] of boolean;
    n,p,k,i,l,r,mid,ans,f0,t0,w0:int;
    flag:boolean;

procedure add(f,t,w:int);
var m:int;
begin
    inc(head[0]);m:=head[0];
    g[m].t:=t;g[m].w:=w;
    g[m].next:=head[f];head[f]:=m;
end;

procedure dfs(v,j:int);
var i,u:int;
begin
    if j>k then exit;
    if v=n then begin flag:=true;exit end;
    used[v,j]:=true;
    i:=head[v];
    while i<>0 do begin
        u:=g[i].t;
        if (g[i].w<=mid) and not used[u,j] then dfs(u,j);
        if (g[i].w>mid) and not used[u,j+1] then dfs(u,j+1);
        if flag then exit;
        i:=g[i].next;
    end;
end;

function check():boolean;
begin
    fillchar(used,sizeof(used),false);
    flag:=false;
    dfs(1,0);
    check:=flag;
end;

begin
    assign(input,'phoneline.in');reset(input);
    assign(output,'phoneline.out');rewrite(output);
    read(n,p,k);
    l:=0;r:=0;
    fillchar(head,sizeof(head),0);
    for i:=1 to p do begin
        read(f0,t0,w0);
        add(f0,t0,w0);add(t0,f0,w0);
        r:=max(r,w0);
    end;
    ans:=-1;
    while l<=r do begin
        mid:=(l+r) shr 1;
        if check() then begin ans:=mid;r:=mid-1 end
        else l:=mid+1;
    end;
    write(ans);
    close(input);close(output);
end.
