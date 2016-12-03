#include<algorithm>
#include<cstdio>
#include<time.h>
#include<cstdlib>
#define rnd(x) rand()%x
using namespace std;
const int N=200010,INF=10e2;
int n,m,sz;
int main(){
	freopen("in","w",stdout);
	srand((int)time(0));
	n=200000;m=rnd(INF);sz=0;
	printf("%d %d\n",n,m);
	for(int i=0;i<n;i++){
		if(sz>0&&rnd(2)==0)printf("Q %d\n",rnd(sz)+1);
		else printf("A %d\n",rnd(INF)),sz++;
	}
	return 0;
}
