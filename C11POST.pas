const 
	maxn = 100;
	dx: array[1..8] of integer = (-1, -1, 0, 1, 1, 1, 0, -1);
	dy: array[1..8] of integer = (0, 1, 1, 1, 0, -1, -1, -1);
var
	max, min, startx, starty, m, n, k: longint;
	a: array[1..maxn, 1..maxn] of longint;
	c: array[1..maxn, 1..maxn] of char;
	
procedure enter;
var
	f: text;
	i, j: longint;
begin
	assign(f, 'file.inp');
	reset(f);
	readln(f, m, n);
	k := 0;
	for i := 1 to m do
	begin
		for j := 1 to n do
		begin
			read(f, c[i, j]);
			if c[i, j] = 'P' then
			begin
				startX := i;
				startY := j;
			end else if c[i, j] = 'K' then inc(k);
		end;
		readln(f);
	end;
	max := 0;
	min := 2000000000;
	for i := 1 to m do
		for j := 1 to n do
		begin
			read(f, a[i, j]);
			if a[i, j] > max then max := a[i, j];
			if min > a[i, j] then min := a[i, j];
		end;
	close(f);
end;

function bfs(left, right, num: longint): boolean;
var
	qx, qy: array[1..maxn * maxn] of longint;
	free: array[1..maxn, 1..maxn] of boolean;
	count, f, r, x, y, tx, ty, i: longint;
begin
	//writeln('bfs ', left, ' ', right, ' ', num);
	f := 1; 
	r := 1;
	qx[1] := startX;
	qy[1] := startY;
	fillchar(free, sizeof(free), true);
	count := 0;
	repeat
		x := qx[f];
		y := qy[f];
		for i := 1 to 8 do
		begin	
			tx := x + dx[i];
			ty := y + dy[i];
			if (tx > 0) and (tx <= m) and (ty > 0) and (ty <= n)
				and free[tx, ty] 
				and (a[tx, ty] >= left) 
				and (a[tx, ty] <= right) then
				begin
					if c[tx, ty] = 'K' then inc(count);
					if count = num then exit(true);
					free[tx, ty] := false;
					inc(r);
					qx[r] := tx;
					qy[r] := ty;
				end;
		end;
		inc(f);
	until f > r;
	exit(false);
end;

procedure solve;
var
	res, i, left, right, mid: longint;
begin
	res := max - min;
	for i := min to a[startX, startY] do
	begin
		left := 0;
		right := res;
		while left <= right do
		begin
			mid := (left + right) div 2;
			if bfs(i, i + mid, k) then
			begin
				res := mid;
				right := mid - 1;
			end else left := mid + 1;
		end;
	end;
	writeln(res);
end;

begin
	enter;
	solve;
end.
