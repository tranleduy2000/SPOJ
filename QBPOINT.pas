const
	maxn = 2000;
var
	n: longint;
	a: array[1..maxn] of real;
	x, y: array[1..maxn] of longint;
procedure enter;
var	
	f: text;
	i: longint;
begin
	assign(f, 'file.inp');
	reset(f);
	readln(f, n);
	for i := 1 to n do readln(f, x[i], y[i]);
	close(f);
end;

procedure sort(l, r: longint);
var
	i, j: longint;
	tmp, key: real;
begin
	i := l;
	j := r;
	key := a[(l + r) div 2];
	repeat
		while a[i] < key do inc(i);
		while a[j] > key do dec(j);
		if i <= j then
		begin
			tmp := a[i];
			a[i] := a[j];
			a[j] := tmp;
			inc(i);
			dec(j);
		end;
	until i > j;
	if i < r then sort(i, r);
	if j > l then sort(l, j);
end;

procedure solve;
var
	i, j, top, k, d, count: longint;
	res : longint;
begin
	res := 0;
	for i := 1 to n do
	begin
		top := 0;
		count := 0;
		for j := i + 1 to n do
		begin
			if x[i] <> x[j] then
			begin
				inc(top);
				a[top] := (y[j] - y[i]) / (x[j] - x[i]);
			end
			else 
				inc(count);
		end;
		sort(1, top);
		for j := 1 to top do write(a[j]:0:2, ' '); writeln;
		j := 1;
		while j <= top do
		begin
			k := j + 1;
			while (k <= top) and (a[k] = a[j]) do inc(k);
			d := k - j;
			res := res + d * (d - 1);
			j := k ;
		end;
	end;
	writeln(res div 2);
end;

begin
	enter;
	solve;
end.
