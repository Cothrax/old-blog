#include<algorithm>
#include<cstdio>
#include<cmath>
#define ll long long
//#define D
using namespace std;
const int N=14;
ll ans[N];
void solv(ll n){
	int a[N],k;
	while(n)ans[n%10]++,n/=10;
}

int main(){
	freopen("in","r",stdin);
	freopen("ans","w",stdout);
	ll a,b;
	scanf("%lld %lld",&a,&b);
	for(ll i=a;i<=b;i++)solv(i);
	for(int i=0;i<10;i++)printf("%lld ",ans[i]);
	return 0;
}
