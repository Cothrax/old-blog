#include<algorithm>
#include<cstdio>
#include<string.h>
using namespace std;
const int N=200,M=2050,Z=30031;
int n,k,p,m,t=0,cnt[M],a[M],loc[M];
struct mat{
	int v[N][N];
	mat(){memset(v,0,sizeof(v));}
	friend mat operator*(mat a,mat b){
		mat ret;
		for(int i=0;i<t;i++)
			for(int j=0;j<t;j++)
				for(int k=0;k<t;k++)
					ret.v[i][j]+=a.v[i][k]*b.v[k][j],
					ret.v[i][j]%=Z;
		return ret;
	}
	friend mat operator^(mat a,int n){
		mat ret;
		for(int i=0;i<t;i++)ret.v[i][i]=1;
		for(;n;n>>=1,a=a*a)if(n&1)ret=ret*a;
		return ret;
	}
}f;
int main(){
	//freopen("in","r",stdin);
	scanf("%d %d %d",&n,&k,&p);m=1<<p;
	for(int i=1;i<m;i++)cnt[i]=cnt[i&(i-1)]+1;
	for(int i=0;i<m;i++)
		if(cnt[i]==k&&(i&1))loc[i]=t,a[t++]=i;
		else loc[i]=N-1;
	//printf("%d\n",t);
	for(int i=0;i<t;i++){
		int x=a[i];
		f.v[loc[(x<<1)&(m-1)|1]][i]=1;
		if(x>>(p-1))continue;
		for(int j=1;j<m;j<<=1)f.v[loc[(x<<1)^j|1]][i]=1;
	}
	int st=loc[(1<<k)-1];
	printf("%d",(f^(n-k)).v[st][st]);
	return 0;
}
