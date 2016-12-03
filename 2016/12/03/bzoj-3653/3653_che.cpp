#include<algorithm>
#include<cstdio>
//#define D
using namespace std;
const int N=300010,M=300010;
struct edge{int v,nxt;} g[N*2];
int head[N],par[N],dep[N]={-1},n,m,sz=0;
void add(int u,int v)
{g[++sz]={v,head[u]};head[u]=sz;}
void dfs(int u,int p){
	par[u]=p;dep[u]=dep[p]+1;int v;
	for(int i=head[u];i;i=g[i].nxt)
		if((v=g[i].v)!=p)dfs(v,u);
}
bool jud(int u,int p){
	while(u){
		if(u==p)return true;
		u=par[u];
	}
	return false;
}
int dist(int u,int v){
	int u0=u,v0=v;
	if(dep[u]>dep[v])swap(u,v);
	while(dep[v]>dep[u])v=par[v];
	while(u!=v)u=par[u],v=par[v];
	return dep[u0]+dep[v0]-2*dep[u];
}
int query(int u,int k){
	//printf("que:%d %d\n",u,k);
	int ret=0;
	for(int v=1;v<=n;v++)if(v!=u)
		for(int w=1;w<=n;w++)if(w!=v&&w!=u){
#ifdef D
			printf("%d,%d>%d %d %d %d\n",
			u,v,w,jud(w,v),jud(w,u),dist(u,v));
#endif
			if(jud(w,v)&&jud(w,u)&&dist(u,v)<=k)ret++;
		}
	return ret;
}

int main(){
	freopen("in","r",stdin);
	freopen("ans","w",stdout);
	scanf("%d %d\n",&n,&m);int u,v;
	for(int i=0;i<n-1;i++)
		scanf("%d %d\n",&u,&v),add(u,v),add(v,u);
	dfs(1,0);
	//printf("%d>>\n",jud(3,2));
	//for(int i=1;i<=n;i++)printf("%d:%d,%d\n",i,par[i],dep[i]);
	
	for(int i=0;i<m;i++){
		scanf("%d %d\n",&u,&v);
		printf("%d\n",query(u,v));
	}
	return 0;
}
