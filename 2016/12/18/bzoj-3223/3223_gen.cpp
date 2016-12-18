#include<algorithm>
#include<cstdio>
#include<ctime>
#include<cstdlib>
#define rnd(x) rand()%x
using namespace std;
const int N=100000;
int main(){
	freopen("in","w",stdout);
	srand((int)time(0));
	int n=rnd(N)+1,m=rnd(N)+1;
	printf("%d %d\n",n,m);
	for(int i=0;i<m;i++){
		int r=rnd(n)+1;
		printf("%d %d\n",rnd(r)+1,r);
	}
}
