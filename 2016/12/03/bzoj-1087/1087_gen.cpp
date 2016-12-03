#include<algorithm>
#include<cstdio>
#include<time.h>
#include<cstdlib>
#define rnd(x) rand()%x
using namespace std;
int main(){
	freopen("in","w",stdout);
	srand((int)time(0));
	int n=rnd(9)+1;
	printf("%d %d",n,rnd(9*9)+1);
	return 0;
}
