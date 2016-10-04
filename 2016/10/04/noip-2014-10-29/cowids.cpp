#include <algorithm>
#include <iostream>
#include <cstring>
#include <cstdio>
using namespace std;

const int N = 5e3, INF = 1e7;

int n, m, f[N + 1][11];
bool flag;

void Dfs(int x, int y, int step) {
	if (step == 0) return ;
	if (f[step - 1][y] >= x) {
		if (flag) putchar('0');
		Dfs(x, y, step - 1);
	}
	else {
		putchar('1'); flag = 1;
		Dfs(x - f[step - 1][y], y - 1, step - 1);
	}
	return ;
}

int main() {
	freopen("cowids.in", "r", stdin);
	freopen("cowids.out", "w", stdout);
	scanf("%d%d", &n, &m);
	if (m == 1) {
		putchar('1');
		for (int i = 1; i < n; ++i)
			putchar('0');
	}
	else {
		for (int i = 0; i <= N; ++i)
			f[i][0] = 1;
		for (int i = 1; i <= N; ++i)
			for (int j = 1; j <= m; ++j)
				f[i][j] = min(INF, f[i - 1][j] + f[i - 1][j - 1]);
		Dfs(n, m, N);
	}
	puts("");
	fclose(stdin);fclose(stdout);
	return 0;
}
