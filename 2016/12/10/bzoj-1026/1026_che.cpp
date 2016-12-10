#include<algorithm>
#include<cstdio>
#include<string.h>
#include<cmath>
#define ll long long
//#define D
using namespace std;
const int N=12;
ll jud(ll n){
	int a[N],k=0;
	while(n)a[k++]=n%10,n/=10;
	for(int i=1;i<k;i++)if(abs(a[i-1]-a[i])<2)return 0;
	return 1;
}

int main(){
	freopen("in","r",stdin);
	freopen("ans","w",stdout);
	ll a,b,ans=0;
	scanf("%lld %lld",&a,&b);
	for(ll i=a;i<=b;i++)ans+=jud(i);
	printf("%lld",ans);
}
