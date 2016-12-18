#include<algorithm>
#include<cstdio>
#define P pair<int,int>
#define mkp(x,y) make_pair(x,y)
using namespace std;
const int N=100010;
namespace splay_tree{
	int c[N][2],w[N],par[N],siz[N],sz=0,rt=1,loc[N],a[N];
	bool rev[N];
	void upd(int x){siz[x]=siz[c[x][0]]+siz[c[x][1]]+1;}
	void pushdn(int x){
		for(int i=0;i<2&&rev[x];i++){
			int t=c[x][i];rev[t]^=1;
			swap(c[t][0],c[t][1]);
		}rev[x]=0;
	}
	void rotate(int x,int &k){
		int y=par[x],z=par[y],l=c[y][0]==x?0:1,r=l^1;
		if(y==k)k=x;else c[z][c[z][0]==y?0:1]=x;
		par[c[x][r]]=y;par[y]=x;par[x]=z;
		c[y][l]=c[x][r];c[x][r]=y;
		upd(y);upd(x);
	}
	void splay(int x,int &k){
		while(x!=k){
			int y=par[x],z=par[y];
			if(y!=k){
				if(c[y][0]==x^c[z][0]==y)rotate(x,k);
				else rotate(y,k);
			}rotate(x,k);
		}
	}
	int find(int x,int rk){
		pushdn(x);
		int l=c[x][0],r=c[x][1];
		if(siz[l]+1==rk)return x;
		else if(siz[l]>=rk)return find(l,rk);
		else return find(r,rk-siz[l]-1);
	}
	int rever(int st,int k){
		int q[N],t=0;
		for(int x=k;x;x=par[x])q[t++]=x;
		for(int i=t-1;i>=0;i--)pushdn(q[i]);
		int rk=siz[c[k][0]];
		for(int i=1;i<t;i++){
			int x=q[i],l=c[x][0],r=c[x][1];
			if(q[i-1]==r)rk+=siz[l]+1;
		}
		int x=find(rt,st),y=find(rt,rk+2);
		splay(x,rt);splay(y,c[rt][1]);
		x=c[y][0];rev[x]^=1;swap(c[x][0],c[x][1]);
		return rk;
	}
	void build(int l,int r,int p){
		if(l>r)return;
		if(l==r){
			loc[l]=++sz;
			par[sz]=loc[p];c[loc[p]][l<p?0:1]=sz;
			w[sz]=a[l];siz[sz]=1;upd(sz);
			return;
		}
		int mid=(l+r)>>1,x=loc[mid]=++sz;
		build(l,mid-1,mid);build(mid+1,r,mid);
		par[x]=loc[p];c[loc[p]][mid<p?0:1]=x;
		w[x]=a[mid];siz[x]=1;upd(x);
	}
}
int main(){
	using namespace splay_tree;
	//freopen("in","r",stdin);freopen("out","w",stdout);
	int n;scanf("%d",&n);
	for(int i=1;i<=n;i++)scanf("%d",&a[i]);
	build(0,n+1,n+2);
	P b[N];
	for(int i=1;i<=n;i++)b[i-1]=mkp(a[i],i);
	sort(b,b+n);
	for(int i=0;i<n;i++)
		printf("%d ",rever(i+1,loc[b[i].second]));
}
