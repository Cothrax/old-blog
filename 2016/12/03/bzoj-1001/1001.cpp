#include<cstdio>
#include<algorithm>
#include<string.h>
//#define DEBUG
using namespace std;
const int N=1010,INF=10e7;
struct edge{int v,nxt,c;} g[N*N*12];
int n,m,sz,head[N*N],q[N*N],dep[N*N];
inline void _add(int u,int v,int c)
{g[++sz]={v,head[u],c};head[u]=sz;}
inline void add(int u,int v,int c)
{_add(u,v,c);_add(v,u,0);_add(v,u,c);_add(u,v,0);}
inline int p(int x,int y){return x*m+y;}

bool bfs(int s,int t0){
	memset(dep,-1,sizeof(dep));
	int u,v;q[0]=s;dep[s]=0;
	for(int h=0,t=1;h<t;h++)
		for(int i=head[u=q[h]];i;i=g[i].nxt)
			if(dep[v=g[i].v]==-1&&g[i].c)
				q[t++]=v,dep[v]=dep[u]+1;
	return dep[t0]!=-1;
}
int dfs(int u,int t,int f){
	if(u==t)return f;
	int ret=0,v;
	for(int i=head[u];i;i=g[i].nxt)
		if(dep[v=g[i].v]==dep[u]+1){
			int tmp=dfs(v,t,min(f-ret,g[i].c));
			g[i].c-=tmp;g[i^1].c+=tmp;ret+=tmp;
			if(ret==f)return ret;
		}
	return ret;
}
int maxflow(int s,int t)
{int ret=0;while(bfs(s,t))ret+=dfs(s,t,INF);return ret;}

int main(){
	//freopen("1001.in","r",stdin);
	//freopen("1001.ans","w",stdout);
	scanf("%d%d",&n,&m);sz=1;int w;
	for(int i=0;i<n;i++)
		for(int j=0;j<m-1;j++)
			scanf("%d",&w),add(p(i,j),p(i,j+1),w);
	for(int i=0;i<n-1;i++)
		for(int j=0;j<m;j++)
			scanf("%d",&w),add(p(i,j),p(i+1,j),w);
	for(int i=0;i<n-1;i++)
		for(int j=0;j<m-1;j++)
			scanf("%d",&w),add(p(i,j),p(i+1,j+1),w);
#ifdef DEBUG
	for(int i=0;i<=p(n-1,m-1);i++)
		for(int j=head[i];j;j=g[j].nxt)
			printf("%d->%d=%d\n",i,g[j].v,g[j].c);
#endif
	printf("%d",maxflow(p(0,0),p(n-1,m-1)));
	//fclose(stdin);fclose(stdout);
	return 0;
}
/*
3 4
5 6 4
4 3 1
7 5 3
5 6 7 8
8 7 6 5
5 5 5
6 6 6
 */
