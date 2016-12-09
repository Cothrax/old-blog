#include<cstdio>
#include<algorithm>
#include<string.h>
#define ll long long
using namespace std;
const int N=100050,K=20,Z=1E9+1;
int n,m=0,b[K]={1},h[1<<K],f[K][1<<K];
bool flg[N];
int calc(int x){
	int cnt=0,a[K];memset(a,0,sizeof(a));
	for(int i=x;i<=n;i*=2,cnt++)
		for(int j=i;j<=n;j*=3)
			a[cnt+1]++,flg[j]=true;
	for(int i=1;i<=cnt;i++)fill(f[i],f[i]+b[a[i]],0);
	f[0][0]=1;
	for(int i=0;i<=cnt;i++)
		for(int j=0;h[j]<b[a[i]]&&j<m;j++)if(f[i][j])
			for(int k=0;h[k]<b[a[i+1]]&&k<m;k++)
				if(!(h[k]&(h[k]<<1))&&!(h[k]&h[j]))
					f[i+1][k]=((ll)f[i+1][k]+(ll)f[i][j])%Z;
	int ret=0;
	for(int i=0;h[i]<b[a[cnt]]&&i<m;i++)
		ret=((ll)ret+(ll)f[cnt][i])%Z;
	return ret;
}
int main(){
	//freopen("in","r",stdin);
	scanf("%d",&n);int ans=1;
	for(int i=1;i<K;i++)b[i]=b[i-1]<<1;
	for(int i=0;i<1<<K;i++)if(!(i&(i<<1)))h[m++]=i;
	for(int i=1;i<=n;i++)if(!flg[i])ans=((ll)ans*(ll)calc(i))%Z;
	printf("%d",ans);
	return 0;
}
