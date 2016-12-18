#include<algorithm>
#include<cstdio>
#define P pair<int,int>
#define mkp(x,y) make_pair(x,y)
#define fir first
#define sec second
using namespace std;
const int N=50010,INF=1E8;
int main(){
	freopen("in","r",stdin);
	int n,x,ans;P a[N];
	scanf("%d",&n);
	for(int i=0;i<n;i++)scanf("%d",&x),a[i]=mkp(x,i);
	ans=a[0].fir;sort(a,a+n);
#ifdef D
	for(int i=0;i<n;i++)
		printf("%d %d,%d\n",i,a[i].fir,a[i].sec);
#endif
	int l[N],r[N],loc[N];
	for(int i=0;i<n;i++)loc[a[i].sec]=i;
	for(int i=0;i<n;i++)l[i]=i-1,r[i]=i+1;
	l[0]=n+1;a[n].fir=INF;a[n+1].fir=-INF;
	for(int i=n-1;i>0;i--){
		int j=loc[i];
		ans+=min(a[j].fir-a[l[j]].fir,
			a[r[j]].fir-a[j].fir);
#ifdef D
		printf("(%d)%d %d %d::\n",i,j,a[j].fir-a[l[j]].fir,
			a[r[j]].fir-a[j].fir);
#endif
		r[l[j]]=r[j];l[r[j]]=l[j];
	}
	printf("%d",ans);
	return 0;
}
