#include<algorithm>
#include<cstdio>
#include<cstring>
#include<cmath>
#define ll long long
using namespace std;
const int N=510,M=2010,INF=1E8;
struct edge{int v,cap,nxt;}g[M*100];
int head[N],sz=1;
void _add(int u,int v,int cap){
	g[++sz].v=v;g[sz].cap=cap;
	g[sz].nxt=head[u];head[u]=sz;
}
void add(int u,int v,int cap)
{_add(u,v,cap);_add(v,u,0);}

int q[N],d[N];
bool bfs(int s,int dest){
	fill(d,d+N,INF);
	d[s]=0;q[0]=s;int u,v;
	for(int h=0,t=1;h!=t;h=(h+1)%N)
		for(int i=head[u=q[h]];i;i=g[i].nxt)
			if(g[i].cap&&d[v=g[i].v]==INF)
				d[v]=d[u]+1,q[t++]=v,t%=N;
	return d[dest]!=INF;
}
int dfs(int u,int t,int f){
	if(u==t)return f;
	int ret=0,v;
	for(int i=head[u];i;i=g[i].nxt)
		if(d[v=g[i].v]==d[u]+1){
			int lim=dfs(v,t,min(f-ret,g[i].cap));
			g[i].cap-=lim;g[i^1].cap+=lim;ret+=lim;
			if(f==ret)return ret;
		}
	return ret;
}
int mf(int s,int t){
	int ret=0;
	while(bfs(s,t))ret+=dfs(s,t,INF);
	return ret;
}
int n,m,a[N],seg[M][2];
void init(int s,int t,int x){
	fill(head,head+N,0);sz=1;
	for(int i=1;i<=n;i++)
		if(a[i]>=0){
			if(a[i]&(1<<x))add(i,t,INF);
			else add(s,i,INF);
		}
	for(int i=0;i<m;i++){
		add(seg[i][0],seg[i][1],1);
		add(seg[i][1],seg[i][0],1);
	}
}
int vis[N];
int dfs(int u){
	int ret=1,v;vis[u]=1;
	for(int i=head[u];i;i=g[i].nxt)
		if(g[i^1].cap&&!vis[v=g[i].v])ret+=dfs(v);
	return ret;
}
int main(){
	freopen("in","r",stdin);freopen("out","w",stdout);
	scanf("%d %d\n",&n,&m);int tmp=0;
	for(int i=1;i<=n;i++)scanf("%d\n",&a[i]),tmp=max(tmp,a[i]);
	for(int i=0;i<m;i++)scanf("%d %d\n",&seg[i][0],&seg[i][1]);
	int lim=log2(tmp)+1,s=n+1,t=s+1;
	ll sumE=0,sumV=0,b=1;
	for(int i=0;i<lim;i++,b<<=1){
		init(s,t,i);
		sumE+=((ll)mf(s,t))*b;
		fill(vis,vis+N,0);
		sumV+=((ll)(dfs(t)-1))*b;
	}
	printf("%lld\n%lld",sumE,sumV);
}
