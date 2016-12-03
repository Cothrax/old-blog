#include<algorithm>
#include<cstdio>
#include<string.h>
using namespace std;
const int N=10;
int a[N][N],n,k,ans=0;
void print(){
	printf(":::\n");
	for(int i=1;i<=n;i++){
		for(int j=1;j<=n;j++)printf("%d ",a[i][j]);
		printf("\n");
	}
}

void print(int s){
	for(int i=0;i<n;i++)printf("%d",s&(1<<i)?1:0);
	printf("\n");
}

void dfs(int cur,int cnt){
	//printf("%d,%d\n",cur,cnt);
	if(cnt==k){/*print();*/ans++;return;};
	if(cur==n*n)return;
	int y=cur%n+1,x=cur/n+1;//printf("(%d,%d)\n",x,y);
	int tmp=a[x-1][y-1]+a[x-1][y]+a[x-1][y+1]+a[x][y-1];
	if(!tmp)a[x][y]=1,dfs(cur+1,cnt+1),a[x][y]=0;
	dfs(cur+1,cnt);
}

int main(){
	freopen("in","r",stdin);
	freopen("ans","w",stdout);
	scanf("%d %d\n",&n,&k);
	memset(a,0,sizeof(a));
	dfs(0,0);printf("%d",ans);
	return 0;
}
