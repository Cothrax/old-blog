#include<cstdio>
#include<time.h>
#include<cstdlib>
#define rnd(x) rand()%x
const int INF=10e6,N=1010;

int main(){
	freopen("1001.in","w",stdout);
	srand(int(time(0)));
	int n=rnd(N)+1,m=rnd(N)+1;
	printf("%d %d\n",n,m);
	for(int i=0;i<n;i++){
		for(int j=0;j<m-1;j++)printf("%d ",rnd(INF));
		printf("\n");	
	}
	for(int i=0;i<n-1;i++){
		for(int j=0;j<m;j++)printf("%d ",rnd(INF));
		printf("\n");
	}
	for(int i=0;i<n-1;i++){
		for(int j=0;j<m-1;j++)printf("%d ",rnd(INF));
		printf("\n");
	}
	fclose(stdout);
	return 0;
}