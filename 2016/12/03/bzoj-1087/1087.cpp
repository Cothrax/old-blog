#include<algorithm>
#include<cstdio>
#define ll long long
using namespace std;
const int N=10,M=1<<N;
int n,m,k,cnt[M];
ll f[N][N*N][M];
bool flg[M],mat[M][M];
bool jud(int x,int y)
{return ((x<<1|x|x>>1)&y)==0;}
int main(){
	//freopen("in","r",stdin);
	//freopen("out","w",stdout);
	scanf("%d %d\n",&n,&k);m=1<<n;
	for(int i=1;i<m;i++)cnt[i]=cnt[i&(i-1)]+1;
	for(int i=0;i<m;i++)
		if(!(i&(i>>1)))flg[i]=true;
	for(int i=0;i<m;i++)if(flg[i])
		for(int j=0;j<m;j++)if(flg[j])mat[i][j]=jud(i,j);
	for(int i=0;i<m;i++)if(flg[i])f[1][cnt[i]][i]=1;
	for(int i=1;i<n;i++)
		for(int p=0;p<m;p++)if(flg[p])
			for(int q=0;q<m;q++)if(flg[q]&&mat[p][q])
				for(int j=cnt[p];j+cnt[q]<=k;j++)
					f[i+1][j+cnt[q]][q]+=f[i][j][p];
	ll ans=0;
	for(int j=0;j<m;j++)ans+=f[n][k][j];
	printf("%lld",ans);
	return 0;
}
