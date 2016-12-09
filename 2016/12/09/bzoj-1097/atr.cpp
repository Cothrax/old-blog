#include<algorithm>
#include<cstdio>
#include<queue>
#include<string.h>
#define P pair<int,int>
#define mkp(x,y) make_pair(x,y)
using namespace std;
const int N=20010,M=400010,K=25,L=1<<21,INF=10E8;
struct edge{int v,w,nxt;} g[M];
int head[N],d[N],a[K][K],f[L][K],bf[K],af[K],b[K];
int n,m,k,t,l,sz=0;
bool flg[N];
void _add(int u,int v,int w)
{g[++sz]={v,w,head[u]};head[u]=sz;};
void add(int u,int v,int w)
{_add(u,v,w);_add(v,u,w);}
void dij(int s){
	priority_queue<P,vector<P>,greater<P> >q;
	fill(d,d+n+1,INF);fill(flg,flg+n+1,false);
	d[s]=0;q.push(mkp(0,s));
	while(!q.empty()){
		int u=q.top().second,v;q.pop();
		if(flg[u])continue;flg[u]=true;
		for(int i=head[u];i;i=g[i].nxt)
			if(d[u]+g[i].w<d[v=g[i].v])
				d[v]=d[u]+g[i].w,q.push(mkp(d[v],v));
	}
	for(int i=1;i<=k+1;i++)a[s][i]=d[i];
	a[s][0]=d[n];
}
inline bool jud(int x,int i)
{return (x&bf[i])==bf[i]&&(x&af[i])==0;}

int main(){
	//freopen("atr9b.in","r",stdin);freopen("out","w",stdout);
	scanf("%d %d %d\n",&n,&m,&k);
	int u,v,w;l=1<<k;b[2]=1;
	for(int i=3;i<=k+1;i++)b[i]=b[i-1]<<1;
	for(int i=0;i<m;i++)
		scanf("%d %d %d\n",&u,&v,&w),add(u,v,w);
	for(int i=2;i<=k+1;i++)dij(i);
	scanf("%d\n",&t);
	for(int i=0;i<t;i++){
		scanf("%d %d\n",&u,&v);
		bf[v]|=b[u];af[u]|=b[v];
	}
	for(int i=0;i<l;i++)
		for(int j=2;j<=k+1;j++)f[i][j]=INF;
	for(int i=2;i<=k+1;i++)
		if(!bf[i])f[b[i]][i]=a[i][1]/*,printf("%d, ",i)*/;
	for(int i=0;i<l;i++)
		for(int j=2;j<=k+1;j++)if(f[i][j]!=INF)
			for(int p=2;p<=k+1;p++)if(!(i&b[p])&&jud(i,p))
				f[i|b[p]][p]=min(f[i|b[p]][p],f[i][j]+a[j][p]);
	int ans=INF;
	for(int i=2;i<=k+1;i++)ans=min(ans,f[l-1][i]+a[i][0]);
	printf("%d",ans);
	//fclose(stdin);fclose(stdout);
	return 0;
}
