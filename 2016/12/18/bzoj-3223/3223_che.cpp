#include<algorithm>
#include<cstdio>
//#define D
using namespace std;
const int N=100010;
int a[N];
void rev(int l,int r){
	while(l<r){swap(a[l],a[r]);l++;r--;}
}
int main(){
	freopen("in","r",stdin);freopen("ans","w",stdout);
	int n,m,l,r;
	scanf("%d %d\n",&n,&m);
	for(int i=1;i<=n;i++)a[i]=i;
	for(int i=0;i<m;i++)scanf("%d %d\n",&l,&r),rev(l,r);
	for(int i=1;i<=n;i++)printf("%d ",a[i]);
	return 0;
}
