#include<algorithm>
#include<cstdio>
using namespace std;
const int N=25,M=1<<21;
int n=0,m,a[N],b[N]={1},s[M],f[M];
int main(){
	scanf("%d",&n);
	for(int i=0;i<n;i++)scanf("%d",&a[i]);
	int x;scanf("%d",&x);n+=x;m=1<<n;
	for(int i=n-x;i<n;i++)scanf("%d",&a[i]),a[i]*=-1;
	for(int i=1;i<n;i++)b[i]=b[i-1]<<1;
	for(int i=0;i<n;i++)s[b[i]]=a[i];
	for(int i=0;i<m;i++)s[i]=s[i&(i-1)]+s[i&(-i)];
	for(int i=1;i<m;i++){
		for(int j=0;j<n;j++)if(i&b[j])
			f[i]=max(f[i^b[j]],f[i]);
		if(!s[i])f[i]++;
	}
	printf("%d",n-2*f[m-1]);
	return 0;
}
