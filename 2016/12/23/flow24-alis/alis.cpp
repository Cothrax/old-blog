#include<algorithm>
#include<cstdio>
using namespace std;
const int N=1010,INF=1E7;
int n,lis=0,a[N],f[N];
namespace bit{
	const int M=1.1E5;int v[M];
	void add(int x,int k){
		for(;x<M;x+=x&(-x))v[x]=max(v[x],k);
	}
	int ask(int x){
		int ret=0;
		for(;x;x=x&(x-1))ret=max(ret,v[x]);
		return ret;
	}
}
void dp(){
	using namespace bit;
	//f[i] max-len begin_with_a[i]
	//f[i]=max(f[j])+1 (j>i&&a[j]>a[i])
	for(int i=n-1;i>=0;i--){
		add(M-a[i],f[i]=ask(M-a[i])+1);
		lis=max(lis,f[i]);
	}
}
struct edge{int v,cap,nxt;}g[N*10];
int head[N],sz=1;
void _add(int u,int v,int cap){
	g[++sz].v=v;g[sz].cap=cap;
	g[sz].nxt=head[u];head[u]=sz;
}
void add(int u,int v,int cap)
{_add(u,v,cap);_add(v,u,0);}
int q[N],d[N];
bool bfs(int s,int dest){
	fill(d,d+N,INF);d[s]=0;q[0]=s;int u,v;
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
			int tmp=dfs(v,t,min(f-ret,g[i].cap));
			g[i].cap-=tmp;g[i^1].cap+=tmp;ret+=tmp;
			if(f==ret)return ret;
		}
	return ret;
}
int mf(int s,int t){
	int ret=0;
	while(bfs(s,t))ret+=dfs(s,t,INF);
	return ret;
}
void init(int s,int t){
	fill(head,head+N,0);
	for(int i=0;i<n;i++)
		for(int j=i+1;j<n;j++)
			if(a[i]<=a[j]&&f[i]==f[j]+1)add(i+n,j,INF);
	for(int i=0;i<n;i++)add(i,i+n,1);
	for(int i=0;i<n;i++){
		if(f[i]==1)add(i+n,t,INF);
		if(f[i]==lis)add(s,i,INF);
	}
}

int main(){
	freopen("in","r",stdin);freopen("out","w",stdout);
	scanf("%d\n",&n);
	for(int i=0;i<n;i++)scanf("%d",&a[i]);
	dp();printf("%d\n",lis);
	int s=n*2,t=s+1;
	init(s,t);
	printf("%d\n",mf(s,t));
	if(lis==1||lis==2&&a[0]<=a[n-1])printf("-1");
	else{
		init(s,t);add(0,n,INF);add(n-1,2*n-1,INF);
		printf("%d",mf(s,t));
	}
	return 0;
}
