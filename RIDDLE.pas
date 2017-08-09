const
	maxn = 100000;
var
	b, a: array[1..maxn] of longint;
	f: text;
	n, k: longint;

procedure enter;
var
	i: longint;
begin
	readln(f, n, k);
	for i := 1 to n do read(f, a[i]);
end;

procedure sort(left, right: longint);
var
	i, j, key, tmp: longint;
begin
	i := left;
	j := right;
	key := b[(left + right) div 2];
	repeat
		while b[i] < key do inc(i);
		while b[j] > key do dec(j);
		if i <= j then
		begin
			tmp := b[i];
			b[i] := b[j];
			b[j] := tmp;
			inc(i);
			dec(j);
		end;
	until i > j;
	if i < right then sort(i, right);
	if left < j then sort(left, j);
end;

function check(mid: longint): boolean;
var
	i, sum: longint;
begin
	for i := 1 to mid do b[i] := a[i];
	sort(1, mid);
	sum := 0;
	for i := 1 to mid do
	begin
		if b[i] > sum + 1 then exit(false);
		sum := sum + b[i];
		if sum >= k then exit(true);
	end;
	exit(false);
end;

procedure bs;
var
	mid, left, right, res: longint;
begin
	left := 1;
	right := n;
	res := -1;
	while left <= right do
	begin
		mid := (left + right) div 2;
		if check(mid) then
		begin
			right := mid - 1;
			res := mid;
		end else left := mid + 1;
	end;
	writeln(res);
end;

procedure process;
var
	test: longint;
begin
	assign(f, 'file.inp');
	reset(f);
	readln(f, test);
	while test > 0 do
	begin
		enter;
		bs;
		dec(test);
	end;
	close(f);
end;

begin
	process;
end.
