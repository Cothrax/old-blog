#include<algorithm>
#include<cstdio>
#include<cmath>
#define ll long long
using namespace std;
const int N=17,M=1<<N;
int a[N],n,m,k;
ll f[N][M];
int main(){
	freopen("in","r",stdin);
	scanf("%d %d\n",&n,&k);m=1<<n;
	for(int i=0;i<n;i++)scanf("%d\n",&a[i]);
	for(int i=0;i<n;i++)f[i][1<<i]=1;
	for(int i=0;i<m;i++)
		for(int j=0;j<n;j++)if(i&(1<<j)&&f[j][i])
			for(int r=(m-1)^i;r;r=r&(r-1)){
				int p=round(log(r&(-r))/log(2));
				if(abs(a[p]-a[j])>k)f[p][i|(1<<p)]+=f[j][i];
			}
	ll ans=0;
	for(int i=0;i<n;i++)ans+=f[i][m-1];
	printf("%lld",ans);
}
