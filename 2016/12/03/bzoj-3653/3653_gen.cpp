#include<algorithm>
#include<cstdio>
#include<string.h>
#include<time.h>
#define rnd(x) rand()%x
using namespace std;
const int N=300010;
int a[N],n,m;

int main(){
	freopen("in","w",stdout);
	n=300000;m=300000;srand((int)time(0));
	printf("%d %d\n",n,m);
	for(int i=0;i<n;i++)a[i]=i+1;
	for(int i=0;i<n*2;i++)swap(a[rnd(n)],a[rnd(n)]);
	for(int i=1;i<n;i++)printf("%d %d\n",a[i],a[rnd(i)]);
	for(int i=0;i<m;i++)printf("%d %d\n",rnd(n)+1,rnd(n)+1);
}
