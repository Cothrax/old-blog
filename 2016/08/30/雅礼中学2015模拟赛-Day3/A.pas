var t,n:qword;
begin
	assign(input,'A.in');reset(input);
	assign(output,'A.out');rewrite(output);
	read(t);
	repeat
		read(n);
		writeln(n+1);
		t:=t-1;
	until t=0;
	close(input);close(output);
end.
