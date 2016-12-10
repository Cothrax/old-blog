#include<algorithm>
#include<cstdio>
#include<cmath>
#define ll long long
using namespace std;
const int N=16;
ll f[N][N][N],sum[N][N],amt[N][N],b[N]={1};
void dp(int n){
	for(int i=1;i<n;i++)b[i]=b[i-1]*10;
	for(int i=0;i<10;i++)f[0][i][i]=1,sum[0][i]=1;
	for(int i=1;i<n;i++)
		for(int j=0;j<10;j++)
			for(int k=0;k<10;k++)
				f[i][j][k]=sum[i-1][k]+(j==k?1:0)*b[i],
				sum[i][k]+=f[i][j][k];
	for(int i=0;i<n;i++)
		for(int j=1;j<10;j++)
			for(int k=0;k<10;k++)
				amt[i][k]+=f[i][j][k];
	for(int i=1;i<n;i++)
		for(int j=0;j<10;j++)
			amt[i][j]+=amt[i-1][j];
}
ll calc(ll n,int x){
	ll tmp=n;
	int a[N],k=0,cnt=0;ll ret=0;
	while(n)a[k++]=n%10,n/=10;
	for(int i=k-1;i>=0;i--){
		for(int j=(i==k-1?1:0);j<a[i];j++)
			ret+=f[i][j][x]+cnt*b[i];
		cnt+=(a[i]==x)?1:0;
	}
	return ret+amt[k-2][x];
}
int main(){
	//freopen("in","r",stdin);freopen("out","w",stdout);
	ll a,b;scanf("%lld %lld",&a,&b);
	dp((int)log10(b)+2);
	for(int i=0;i<10;i++){
		printf("%lld",calc(b+1,i)-calc(a,i));
		if(i<9)printf(" ");
	}
	//fclose(stdin);fclose(stdout);
	return 0;
}
