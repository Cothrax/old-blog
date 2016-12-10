#include<algorithm>
#include<cstdio>
#include<string.h>
#include<cstdlib>
#include<time.h>
#define ll long long
#define rnd(x) rand()%x
const int INF=1E7;
int main(){
	freopen("in","w",stdout);
	srand((int)time(0));
	int x=rnd(INF)+1;
	printf("%d %d",rnd(x)+1,x);
	return 0;
}
