#include<algorithm>
#include<cstdio>
using namespace std;
const int N=13,M=1<<N,Z=100000000;
int n,m,l,a[N],f[N][M];
bool flg[M],mat[M][M];

int main(){
	freopen("in","r",stdin);
	freopen("out","w",stdout);
	scanf("%d %d\n",&n,&m);l=1<<m;int x;
	for(int i=1;i<=n;i++)
		for(int j=0;j<m;j++)scanf("%d",&x),a[i]|=((x^1)<<j);
	//for(int i=1;i<=n;i++)printf("%d:%d\n",i,a[i]);
	for(int i=0;i<l;i++)
		if(!(i&(i<<1)))flg[i]=true;
	for(int i=0;i<l;i++)
		for(int j=0;j<l;j++)
			if(!(i&j))mat[i][j]=true;
	for(int i=0;i<l;i++)if(flg[i]&&!(i&a[1]))f[1][i]=1;
	for(int i=1;i<n;i++)
		for(int p=0;p<l;p++)if(flg[p]&&!(p&a[i])&&f[i][p])
			for(int q=0;q<l;q++)if(flg[q]&&!(q&a[i+1])&&mat[p][q])
				f[i+1][q]=(f[i][p]+f[i+1][q])%Z;
	int ans=0;
	for(int i=0;i<l;i++)ans=(ans+f[n][i])%Z;
	printf("%d",ans);
	return 0;
}
