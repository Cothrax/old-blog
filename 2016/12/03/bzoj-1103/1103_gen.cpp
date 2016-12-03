#include<algorithm>
#include<cstdio>
#include<time.h>
#include<cstdlib>
#include<string.h>
#define rnd(x) rand()%x
using namespace std;
const int N=250010,INF=10E6;
int a[N],par[N],n,m;
bool flg[N];

int main(){
	freopen("in","w",stdout);
	n=250000;m=250000;srand((int)time(0));
	for(int i=0;i<n;i++)a[i]=i+1;
	for(int i=0;i<n*2;i++)swap(a[rnd(n)],a[rnd(n)]);
	printf("%d\n",n);
	for(int i=1;i<n;i++)
		printf("%d %d\n",a[i],par[i]=a[rnd(i)]);
	printf("%d\n",m);int x,cnt=0;
	fill(flg,flg+N,false);
	while(cnt<m){
		if(rnd(4)){
			if(flg[x=rnd(n)])continue;
			printf("A %d %d\n",a[x],par[x]);
			flg[x]=true;
		}else printf("W %d\n",rnd(n)+1),cnt++;
	}
	return 0;
}
