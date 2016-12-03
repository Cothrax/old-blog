#include<algorithm>
#include<cstdio>
#include<string.h>
using namespace std;
const int N=250010,M=250010;
struct edge{int v,nxt;} g[N*2];
int head[N],par[N],flg[N];
int n,m,sz=0,k=0;
void add(int u,int v)
{g[++sz]={v,head[u]};head[u]=sz;}
void dfs(int u,int p){
	par[u]=p;int v;
	for(int i=head[u];i;i=g[i].nxt)
		if((v=g[i].v)!=p)dfs(v,u);
}
int ask(int u){
	int ret=0;
	while(u!=1)ret+=flg[u],u=par[u];
	return ret;
}
int main(){
	freopen("in","r",stdin);
	freopen("ans","w",stdout);
	scanf("%d\n",&n);
	int u,v,cnt=0;char c;
	for(int i=0;i<n-1;i++)
		scanf("%d %d\n",&u,&v),add(u,v),add(v,u);
	dfs(1,0);scanf("%d",&m);
	//for(int i=1;i<=n;i++)printf("%d %d\n",i,par[i]);
	fill(flg,flg+N,1);
	while(cnt<m){
		scanf("%c ",&c);
		switch(c){
			case 'W':{
				scanf("%d\n",&u);cnt++;
				printf("%d\n",ask(u));
			};break;
			case 'A':{
				scanf("%d %d\n",&u,&v);
				if(par[u]==v)swap(u,v);flg[v]=0;
			};break;
		}
	}
	return 0;
}
