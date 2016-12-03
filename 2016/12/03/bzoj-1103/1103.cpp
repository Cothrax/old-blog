#include<algorithm>
#include<cstdio>
//#define DEBUG
using namespace std;
const int N=250010,M=250010;
struct edge{int v,nxt;} g[N*2];
int head[N],d[N]={-1},siz[N],loc[N],bit[N],par[N];
int n,m,sz=0,k=0;
void add(int u,int v)
{g[++sz]={v,head[u]};head[u]=sz;}
void upd(int x,int k)
{while(x&&x<=n)bit[x]+=k,x+=x&(-x);}
int sum(int x)
{int ret=0;while(x)ret+=bit[x],x-=x&(-x);return ret;}

void dfs(int u,int p){
	loc[u]=++k;d[u]=d[p]+1;siz[u]=1;par[u]=p;int v;
	for(int i=head[u];i;i=g[i].nxt)
		if((v=g[i].v)!=p)dfs(v,u),siz[u]+=siz[v];
}
int main(){
	/*freopen("in","r",stdin);
	freopen("out","w",stdout);*/
	scanf("%d\n",&n);
	int u,v,cnt=0;char c;
	for(int i=0;i<n-1;i++)
		scanf("%d %d\n",&u,&v),add(u,v),add(v,u);
	dfs(1,0);scanf("%d",&m);
	while(cnt<m){
		scanf("%c ",&c);
		switch(c){
			case 'W':{
				scanf("%d\n",&u);cnt++;
				printf("%d\n",d[u]-sum(loc[u]));
			};break;
			case 'A':{
				scanf("%d %d\n",&u,&v);
				if(par[u]==v)swap(u,v);
				upd(loc[v],1);upd(loc[v]+siz[v],-1);
			};break;
		}
	}
	return 0;
}
