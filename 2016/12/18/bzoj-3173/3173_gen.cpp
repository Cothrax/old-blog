#include<algorithm>
#include<cstdio>
#include<cstdlib>
#include<ctime>
#define rnd(x) rand()%x
using namespace std;
const int N=1e1;

int main(){
	freopen("in","w",stdout);
	srand((int)time(0));
	int n=rnd(N)+1;
	printf("%d\n",n);
	for(int i=1;i<=n;i++)printf("%d ",rnd(i));
	return 0;
}
