var
	res, s, num: ansistring;
	i: longint;
begin
	readln(s); res := '';
	for i := 1 to length(s) do 
	begin
		str(i, num);
		res := res + num;
	end;
	for i := length(s) - 1 downto 1 do
	begin
		str(i, num);
		res := res + num;
	end;
	writeln(res);
	readln;
end.
