const
	maxn = 100;
	dirx : array[1..4] of integer = (0, -1, 0, 1);
	diry : array[1..4] of integer = (-1, 0, 1, 0);
var
	a: array[1..maxn, 1..maxn] of longint;
	n,  max, min: longint;
	
procedure enter;
var
	i,j: longint;
	f: text;
begin
	assign(f, 'file.inp');
	reset(f);
	readln(f, n);
	min := 1000000;
	max := 0;
	for i := 1 to n do
		for j := 1 to n do 
		begin
			read(f, a[i, j]);
			if a[i, j] < min then min := a[i, j];
			if a[i, j] > max then max := a[i, j];
		end;
	close(f);
end;

//bfs
function check(left, right: longint): boolean;
var
	qy, qx: array[1..maxn * maxn] of longint;
	free: array[1..maxn, 1..maxn] of boolean;
	f, r, x, y, i, tx, ty:longint;
begin
	f := 1;
	r := 1;
	qx[f] := 1; 
	qy[r] := 1;
	fillchar(free, sizeof(free), true);
	repeat
		x := qx[f];
		y := qy[f];
		inc(f); 
		for i := 1 to 4 do
		begin
			tx := x + dirx[i];
			ty := y + diry[i];
			if free[tx, ty] and (tx <= n) and (ty > 0) and (ty <= n) and (ty > 0)
				and (a[tx, ty] <= right)  and (a[tx, ty] >= left) then
			begin
				free[tx, ty] := false;
				if (tx = n) and (ty = n) then exit(true);
				inc(r);
				qx[r] := tx;
				qy[r] := ty;
			end;
		end;
	until f > r;
	exit(false);
end;

procedure solve;
var
	i, res, left, right, mid: longint;
begin
	res := max - min;
	for i := min to a[1, 1] do
	begin
		left := 0;
		right := res;
		while left <= right do
		begin
			mid := (left + right) div 2;
			if check(i, i + mid) then 
			begin
				right := mid - 1;
				res := mid;
			end else 
				left := mid + 1;
		end;
	end;
	writeln(res);
end;

begin
	enter;
	solve;
end.
{
* Bài này dùng bs
* Gọi k là độ chênh lệch nhỏ nhất có thể đc
* Chặt nhị phân k, left = min(A) right = max(A)
* 
* Dễ nhận thấy rằng để đạt được độ chênh lệch k, thì phải đi qua các ô 
* không lớn hơn A[1,1] + k, điều này đơn giản là vì nếu lớn hơn a[1,1] + k
* thì ko còn thỏa mãn độ chênh lệch.
* Bài toán trở thành tìm k nhỏ nhất mà tồn tại đường đi từ ô [1,1] -> [n, n]
* 
* 
* }
