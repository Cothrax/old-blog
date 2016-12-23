#include<cstdio>
#include<cstring>
#include<algorithm>
using namespace std;
const int N=410,INF=1e7;
struct edge{int v,w,cap,nxt;} g[N*N];
int head[N],sz=1,n,m;
void _add(int u,int v,int w,int cap){
	g[++sz].v=v;g[sz].cap=cap;g[sz].w=w;
	g[sz].nxt=head[u];head[u]=sz;
}
void add(int u,int v,int w,int cap)
{_add(u,v,w,cap);_add(v,u,-w,0);}

int d[N],q[N],pre[N];bool inq[N];
bool spfa(int s,int dest){
	fill(d,d+2*n+1,INF);d[s]=0;
	fill(inq,inq+2*n+1,0);inq[s]=1;
	fill(pre,pre+2*n+1,0);
	q[0]=s;int u,v;
	for(int h=0,t=1;h!=t;inq[q[h]]=0,h=(h+1)%N)
		for(int i=head[u=q[h]];i;i=g[i].nxt)
			if(g[i].cap&&d[v=g[i].v]>d[u]+g[i].w){
				d[v]=d[u]+g[i].w;pre[v]=i;
				if(!inq[v])q[t++]=v,inq[v]=1,t%=N;
			}
	return d[dest]!=INF;
}
void mcf(int s,int t){
	int f=0,ret=0;
	while(spfa(s,t)){
		int x=INF,y=0;
		for(int i=pre[t];i;i=pre[g[i^1].v])
			x=min(x,g[i].cap),y+=g[i].w;
		f+=x;ret+=x*y;
		for(int i=pre[t];i;i=pre[g[i^1].v])
			g[i].cap-=x,g[i^1].cap+=x;
	}
	printf("%d %d",f,ret);
}
int main(){
	freopen("in","r",stdin);
	scanf("%d %d\n",&n,&m);int u,v,w;
	for(int i=1;i<=n;i++)add(i,i+n,0,1);
	for(int i=0;i<m;i++)
		scanf("%d %d %d\n",&u,&v,&w),add(u+n,v,w,1);
	mcf(1+n,n);
}
