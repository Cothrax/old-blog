#include<algorithm>
#include<cstdio>
#include<cmath>
using namespace std;
const int N=105,M=N*N,INF=1E7,EPS=1E-7;
struct edge{int v,cap,nxt;} g[M*10];
int head[M],sz=1;
void _add(int u,int v,int cap){
	g[++sz].v=v;g[sz].cap=cap;
	g[sz].nxt=head[u];head[u]=sz;
}
void add(int u,int v,int cap)
{_add(u,v,cap);_add(v,u,0);}

double a[N][N];int r[M],n,s,t,S,T,sum=0;
bool jud(double n){return abs(n-(int)n)<EPS;}
void init(){
	s=2*n+1,t=s+1,S=t+1,T=S+1;
	fill(r,r+M,0);
	for(int i=1;i<n;i++){
		if(!jud(a[i][n]))add(s,i,1);
		if(!jud(a[n][i]))add(i+n,t,1);
		r[s]-=(int)a[i][n];r[i]+=(int)a[i][n];
		r[t]+=(int)a[n][i];r[i+n]-=(int)a[n][i];
		for(int j=1;j<n;j++){
			if(!jud(a[i][j]))add(i,j+n,1);
			r[i]-=(int)a[i][j];r[j+n]+=(int)a[i][j];
		}
	}
	add(t,s,INF);
	for(int i=1;i<=t;i++)
		if(r[i]>0)add(S,i,r[i]),sum+=r[i];
		else add(i,T,-r[i]);
}

int q[M],d[M];
bool bfs(int s,int dest){
	fill(d,d+M,INF);
	d[s]=0;q[0]=s;int u,v;
	for(int h=0,t=1;h!=t;h=(h+1)%M)
		for(int i=head[u=q[h]];i;i=g[i].nxt)
			if(g[i].cap&&d[v=g[i].v]==INF)
				{d[v]=d[u]+1;q[t++]=v;t%=M;}
	return d[dest]!=INF;
}
int dfs(int u,int t,int f){
	if(u==t)return f;
	int ret=0;int v;
	for(int i=head[u];i;i=g[i].nxt)
		if(d[v=g[i].v]==d[u]+1){
			int tmp=dfs(v,t,min(f-ret,g[i].cap));
			g[i].cap-=tmp;g[i^1].cap+=tmp;ret+=tmp;
			if(f==ret)return f;
		}
	if(!ret)d[u]=INF;
	return ret;
}
int mf(int s,int t){
	int ret=0;
	while(bfs(s,t))ret+=dfs(s,t,INF);
	return ret;
}

int main(){
	freopen("in","r",stdin);
	scanf("%d\n",&n);
	for(int i=1;i<=n;i++)
		for(int j=1;j<=n;j++)scanf("%lf",&a[i][j]);
	init();
	if(mf(S,T)<sum)printf("No");
	else printf("%d",mf(s,t)*3);
	return 0;
}
