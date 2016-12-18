#include<algorithm>
#include<cstdio>
#include<cstdlib>
#include<ctime>
#define rnd(x) rand()%x
using namespace std;
const int N=1e5;

int main(){
	freopen("in","w",stdout);
	srand((int)time(0));
	int n=N+1;
	printf("%d\n",n);
	for(int i=0;i<n;i++)printf("%d ",rnd(N)+1);
	return 0;
}
