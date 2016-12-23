#include<cstring>
#include<algorithm>
#include<cstdio>
using namespace std;
const int N=1000,INF=1E7;
struct edge{int v,w,cap,nxt;}g[N*10];
int head[N],sz=1;
void _add(int u,int v,int cap,int w){
	g[++sz].v=v;g[sz].w=w;g[sz].cap=cap;
	g[sz].nxt=head[u];head[u]=sz;
}
void add(int u,int v,int cap,int w)
{_add(u,v,cap,w);_add(v,u,0,-w);}

int q[N],d[N],pre[N];bool inq[N];
bool spfa(int s,int dest){
	fill(d,d+N,-INF);
	fill(inq,inq+N,0);
	fill(pre,pre+N,0);
	d[s]=0;inq[s]=1;q[0]=s;int u,v;
	for(int h=0,t=1;h!=t;inq[q[h]]=0,h=(h+1)%N)
		for(int i=head[u=q[h]];i;i=g[i].nxt)
			if(g[i].cap&&d[v=g[i].v]<d[u]+g[i].w){
				d[v]=d[u]+g[i].w;pre[v]=i;
				if(!inq[v])q[t++]=v,inq[v]=1,t%=N;
			}
	return d[dest]!=-INF;
}
int mcf(int s,int t){
	int ret=0,f=0;
	while(spfa(s,t)){
		int x=INF,y=0;
		for(int i=pre[t];i;i=pre[g[i^1].v])
			x=min(x,g[i].cap),y+=g[i].w;
		f+=x;ret+=x*y;
		for(int i=pre[t];i;i=pre[g[i^1].v])
			g[i].cap-=x,g[i^1].cap+=x;
	}
	return ret;
}
int main(){
	freopen("in","r",stdin);freopen("out","w",stdout);
	int n,k,vtx[N],l[N],r[N];
	scanf("%d %d\n",&n,&k);
	for(int i=0;i<n;i++){
		scanf("%d %d\n",&l[i],&r[i]);
		vtx[i]=l[i];vtx[i+n]=r[i];
	}
	sort(vtx,vtx+2*n);
	int m=0,loc[(int)1E5];//[0,m]
	loc[vtx[0]]=0;
	for(int i=1;i<2*n;i++)
		if(vtx[i]>vtx[m])
			vtx[++m]=vtx[i],loc[vtx[m]]=m;
	for(int i=0;i<m;i++)add(i,i+1,INF,0);
	for(int i=0;i<n;i++)
		add(loc[l[i]],loc[r[i]],1,r[i]-l[i]);
	int s=m+1,t=m+2;
	add(s,0,k,0);add(m,t,k,0);
	printf("%d",mcf(s,t));
	return 0;
}
