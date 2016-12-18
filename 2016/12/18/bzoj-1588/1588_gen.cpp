#include<algorithm>
#include<cstdio>
#include<string.h>
#include<cstdlib>
#include<time.h>
#define ll long long
#define rnd(x) rand()%x
const int INF=1E4;
int main(){
	freopen("in","w",stdout);
	srand((int)time(0));
	int n=rnd(INF)+1;
	printf("%d\n",n);
	for(int i=0;i<n;i++)printf("%d\n",rnd(INF));
	return 0;
}
