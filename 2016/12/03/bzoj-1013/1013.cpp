#include<algorithm>
#include<cstdio>
#include<cmath>
//#define D
using namespace std;
const int N=15;const double EPS=10E-4;
int n;double a[N][N];
void solv(){
	for(int i=1;i<=n;i++){
		int p=i;
		for(int j=i+1;j<=n;j++)
			if(a[p][i]<a[j][i])p=j;
		swap(a[p],a[i]);
		for(int j=i+1;j<=n+1;j++)a[i][j]/=a[i][i];
		for(int j=1;j<=n;j++)if(j!=i)
			for(int k=i+1;k<=n+1;k++)
				a[j][k]-=a[j][i]*a[i][k];
	}
}
int main(){
	freopen("in","r",stdin);
	scanf("%d\n",&n);
	for(int i=1;i<=n+1;i++)
		for(int j=1;j<=n;j++){
			scanf("%lf",&a[i][j]);
			a[i][n+1]+=a[i][j]*a[i][j];
			a[i][j]*=2;
		}
	for(int i=1;i<=n;i++)
		for(int j=1;j<=n+1;j++)
			a[i][j]-=a[i+1][j];
	solv();
	for(int i=1;i<=n;i++){
		double x=a[i][n+1];
		printf("%0.3lf",(abs(x)<EPS)?0:x);
		if(i<n)printf(" ");
	}
	return 0;
}
