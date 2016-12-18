#include<algorithm>
#include<cstdio>
#include<cstdlib>
#include<ctime>
//#define D
#define rnd(x) rand()%x
using namespace std;
const int N=1E4;

int main(){
	freopen("in","w",stdout);
	srand((int)time(0));
	int n=rnd(N)+1,cnt=1;
	printf("%d %d\n",n,0);
	for(int i=0;i<n;i++)
		switch(rnd(4)){
			case 0:printf("I %d\n",rnd(1000)+1),cnt++;break;
			case 1:printf("F %d\n",rnd((int)cnt/2)+1);break;
			case 2:printf("A %d\n",rnd(100));
			case 3:printf("S %d\n",rnd(100));
		}
	return 0;
}
