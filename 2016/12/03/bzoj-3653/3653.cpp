#include<algorithm>
#include<cstdio>
//#define D
using namespace std;
const int N=300010,M=300010;
struct edge{int v,nxt;} g[N*2];
int head[N],loc[N],seq[N],dep[N]={-1},siz[N],n,m,sz=0,k=0;
void add(int u,int v)
{g[++sz]={v,head[u]};head[u]=sz;}
void dfs(int u,int p){
	loc[u]=++k;seq[k]=u;dep[u]=dep[p]+1;siz[u]=1;int v;
	for(int i=head[u];i;i=g[i].nxt)
		if((v=g[i].v)!=p)dfs(v,u),siz[u]+=siz[v];
}

struct node{int l,r,w;} seg[N*20];
int rt[N],p=0;
void ins(int &i,int l,int r,int x,int k){
	if(!k)return;seg[++p]=seg[i];i=p;seg[i].w+=k;
	if(l==r)return;int mid=(l+r)>>1;
	if(x<=mid)ins(seg[i].l,l,mid,x,k);
	else ins(seg[i].r,mid+1,r,x,k);
}
int ask(int i,int l,int r,int x){
	if(l==r)return seg[i].w;
	int mid=(l+r)>>1;
	if(x<=mid)return ask(seg[i].l,l,mid,x);
	else return ask(seg[i].r,mid+1,r,x)+seg[seg[i].l].w;
}
int query(int l,int r,int x)
{return ask(rt[r],0,n,x)-ask(rt[l-1],0,n,x);}

int main(){
	//freopen("in","r",stdin);
	//freopen("out","w",stdout);
	scanf("%d %d\n",&n,&m);int u,v;
	for(int i=0;i<n-1;i++)
		scanf("%d %d\n",&u,&v),add(u,v),add(v,u);
	dfs(1,0);
	for(int i=1;i<=n;i++){
		rt[i]=rt[i-1];
		ins(rt[i],0,n,dep[seq[i]],siz[seq[i]]-1);	
	}
	for(int i=0;i<m;i++){
		scanf("%d %d\n",&u,&v);
		int a1=min(dep[u],v)*(siz[u]-1);
		int a2=query(loc[u],loc[u]+siz[u]-1,v+dep[u])-siz[u]+1;
		printf("%d\n",a1+a2);
	}
	return 0;
}
