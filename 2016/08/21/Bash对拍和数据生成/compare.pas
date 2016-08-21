uses crt,dos;
const name='test'; //程序名
var a,b:ansistring; 

procedure readin(f:string;var a:ansistring); 
begin  
    assign(input,f);reset(input);  
    read(a);
    close(input);  
end;  
begin
    repeat
        exec(name+'_gen','');  
        exec(name+'_che','');  
        exec(name,'');  
        readin(name+'.out',a);  
        readin(name+'.ans',b);  
        writeln(a=b);
    until a<>b;
end.