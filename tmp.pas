var
	n, st, en, max, tmp, i, sum: longint;
	a: array[1..1000000] of longint;
	f: text;

begin
	assign(f, 'file.inp'); reset(f);
	readln(f, n);
	st := 1; en := 1; sum := 0; max := 0;
	for i := 1 to n do
	begin
		readln(f, a[i]);
		sum := sum + a[i];
	        if max < sum then
		begin
			max := sum;
                        st := tmp + 1;
			en := i;
		end;
		if sum < 0 then
		begin
			sum := 0;
			tmp := i;
		end;
	end;
	writeln(max);
        for i := st to en do write(a[i], ' ');
	close(f);
        readln;
end.

