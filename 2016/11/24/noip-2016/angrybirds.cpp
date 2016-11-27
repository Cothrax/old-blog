#include<algorithm>
#include<cstdio>
#include<cmath>
using namespace std;
const int N=20,M=1<<20;
const double eps=0.000001;
int n,m,t,h[N*N],s[N][N*N],f[M]={0};
double x[N],y[N];
int calc(int u,int v){
	double a,b,p;
	p=x[u]/x[v];
	if(abs(x[u]-x[v])<eps)return 0;
	a=(y[u]-y[v]*p)/(x[u]*x[u]-x[v]*x[v]*p);
	b=(y[u]-a*x[u]*x[u])/x[u];
	if(a>-eps)return 0;
	int ret=0;
	for(int i=0;i<n;i++)
		if(abs(y[i]-(a*x[i]*x[i]+b*x[i]))<eps)ret|=1<<i;
	return ret;
}
int main(){
	//freopen("angrybirds.in","r",stdin);
	//freopen("angrybirds.out","w",stdout);
	scanf("%d",&t);
	while(t--){
		scanf("%d%d",&n,&m);m=(1<<n)-1;
		for(int i=0;i<n;i++)scanf("%lf%lf",&x[i],&y[i]);
		int k=0;
		for(int i=0;i<n;i++)
			for(int j=i+1;j<n;j++)h[k++]=calc(i,j);
		sort(h,h+k);int lst=0;
		for(int i=0;i<k;i++)
			if(h[i]==0)continue;
			else if (lst==0||h[i]!=h[lst-1])h[lst++]=h[i];
		int cnt[N]={0};
		for(int i=0;i<lst;i++)
			for(int j=h[i];j>0;j=j&(j-1)){
				int p=round(log(j&(-j))/log(2));
				s[p][cnt[p]++]=h[i];
			}
		for(int i=1;i<=m;i++){
			int p=round(log(i&(-i))/log(2));
			f[i]=f[i^(1<<p)]+1;
			for(int j=0;j<cnt[p];j++)
				f[i]=min(f[i],f[i^(i&s[p][j])]+1);
		}
		printf("%d\n",f[m]);
	}
	//fclose(stdin);fclose(stdout);
	return 0;
}
/*
2 0
1.41 2.00
1.73 3.00
 */
