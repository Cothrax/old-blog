#include<algorithm>
#include<cstdio>
#include<string.h>
#include<cmath>
#define ll long long
using namespace std;
const int N=12;
ll f[N][N],sum[N];
void dp(int n){
	fill(f[0],f[0]+N,(ll)1);
	for(int i=1;i<n;i++)
		for(int j=0;j<10;j++)
			for(int k=0;k<10;k++)
				if(abs(k-j)>=2)f[i][j]+=f[i-1][k];
	for(int i=0;i<n;i++)
		for(int j=1;j<10;j++)sum[i]+=f[i][j];
	for(int i=1;i<n;i++)sum[i]+=sum[i-1];
}
ll calc(ll n){
	ll ret=0;int a[N],k=0;
	while(n)a[k++]=n%10,n/=10;a[k]=20;
	for(int i=k-1;i>=0;i--){
		for(int j=0;j<a[i];j++)
			if(abs(a[i+1]-j)>=2)ret+=f[i][j];
		if(abs(a[i+1]-a[i])<2)break;
	}
	return ret-f[k-1][0]+sum[k-2];
}
int main(){
	//freopen("in","r",stdin);freopen("out","w",stdout);
	ll a,b;
	scanf("%lld %lld",&a,&b);
	dp((int)log10(b)+2);
	printf("%lld",calc(b+1)-calc(a));
	return 0;
}
