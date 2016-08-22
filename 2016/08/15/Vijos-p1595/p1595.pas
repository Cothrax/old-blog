uses math;
var
    g:array[0..101,0..101] of boolean; 
    dfn,low,scc,s,ind,outd:array[0..101] of integer;
    used,ins:array[0..101] of boolean;
    n,i,j,t,cc,tim:integer;


procedure tarjan(v:integer);
var i:integer;
begin
    inc(tim);dfn[v]:=tim;low[v]:=tim;
    ins[v]:=true;used[v]:=true;
    inc(t);s[t]:=v;
    for i:=1 to n do 
        if g[v,i] then begin
            if not used[i] then begin
                tarjan(i);
                low[v]:=min(low[v],low[i]);
            end else if ins[i] then 
                low[v]:=min(low[v],dfn[i]);
        end;
    if low[v]=dfn[v] then begin
        inc(cc);
        while s[t+1]<>v do begin
            ins[s[t]]:=false;
            scc[s[t]]:=cc;
            dec(t);
        end;
    end;
end;

begin
    read(n);
    fillchar(g,sizeof(g),false);
    for i:=1 to n do begin
        read(j);
        while j<>0 do begin
            g[i,j]:=true;
            read(j);
        end;
    end;

    fillchar(used,sizeof(used),false);
    fillchar(ins,sizeof(ins),false);
    cc:=0;tim:=0;t:=0;
    for i:=1 to n do if not used[i] then tarjan(i);

    if cc=1 then begin writeln(1);write(0);halt end;
    fillchar(ind,sizeof(ind),0);
    fillchar(outd,sizeof(outd),0);
    for i:=1 to n do 
        for j:=1 to n do
            if (g[i,j]) and (scc[i]<>scc[j]) then begin
                inc(outd[scc[i]]);
                inc(ind[scc[j]]);
            end;
    for i:=1 to cc do begin
        if ind[i]=0 then inc(ind[0]);
        if outd[i]=0 then inc(outd[0]);
    end;
    writeln(ind[0]);
    write(max(ind[0],outd[0]));
end.
