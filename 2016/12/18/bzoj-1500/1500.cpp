#include<algorithm>
#include<cstdio>
#include<cstring>
#define L(x) c[x][0]
#define R(x) c[x][1]
using namespace std;
namespace spt{
	const int N=5e5+10,INF=1e7;
	int c[N][2],par[N],siz[N]={0},sz=0,rt=1;
	int sub[N],lmx[N],rmx[N],w[N],sum[N];
	bool rev[N],tag[N];
	int loc[N],a[N];
	namespace mem{
		int stk[N*2],t=N;
		void init(){for(int i=0;i<N;i++)stk[i]=N-i;}
		inline int ext(){return stk[--t];}
		inline void ins(int x){stk[t++]=x;}
		inline void rec(int x){
			if(!x)return;
			ins(x);rec(L(x));rec(R(x));
			L(x)=R(x)=par[x]=tag[x]=rev[x]=0;
		}
	}
	void upd(int x){
		siz[x]=siz[L(x)]+siz[R(x)]+1;
		sum[x]=sum[L(x)]+sum[R(x)]+w[x];
		lmx[x]=max(lmx[L(x)],sum[L(x)]+lmx[R(x)]+w[x]);
		rmx[x]=max(rmx[R(x)],sum[R(x)]+rmx[L(x)]+w[x]);
		sub[x]=max(max(sub[L(x)],sub[R(x)]),lmx[R(x)]+rmx[L(x)]+w[x]);
	}
	void pushdn(int x){
		for(int i=0;i<2&&rev[x];i++){
			int t=c[x][i];rev[t]^=1;
			swap(L(t),R(t));swap(lmx[t],rmx[t]);
		}
		for(int i=0;i<2&&tag[x];i++){
			int t=c[x][i];if(!t)continue;
			w[t]=w[x];tag[t]=1;
			lmx[t]=rmx[t]=max(0,sum[t]=w[t]*siz[t]);
			sub[t]=max(sum[t],w[t]);
		}rev[x]=tag[x]=0;
	}
	void rotate(int x,int &k){
		int y=par[x],z=par[y],l=c[y][0]!=x,r=l^1;
		if(y==k)k=x;else c[z][c[z][0]!=y]=x;
		par[c[x][r]]=y;par[y]=x;par[x]=z;
		c[y][l]=c[x][r];c[x][r]=y;
		upd(y);upd(x);
	}
	void splay(int x,int &k){
		while(x!=k){
			int y=par[x],z=par[y];
			if(y!=k){
				if(L(y)==x^L(z)==y)rotate(x,k);
				else rotate(y,k);
			}rotate(x,k);
		}
	}
	int find(int x,int rk){
		pushdn(x);
		if(siz[L(x)]+1==rk)return x;
		else if(siz[L(x)]>=rk)return find(L(x),rk);
		else return find(R(x),rk-siz[L(x)]-1);
	}
	void build(int l,int r,int p){
		if(l>r)return;
		int mid=(l+r)>>1,x=loc[mid];
		if(l==r){
			par[x]=loc[p];c[loc[p]][l>p]=x;
			w[x]=a[l];upd(x);
			return;
		}
		build(l,mid-1,mid);build(mid+1,r,mid);
		par[x]=loc[p];c[loc[p]][mid>p]=x;
		w[x]=a[mid];upd(x);
	}
	int split(int l,int r){
		int x=find(rt,l),y=find(rt,r+2);
		splay(x,rt);splay(y,R(rt));
		return L(y);
	}
	namespace opt{
		void init(int n){
			mem::init();
			for(int i=1;i<=n;i++)scanf("%d",&a[i]);
			for(int i=0;i<=n+1;i++)loc[i]=mem::ext();
			sub[0]=a[0]=a[n+1]=-INF;
			rt=loc[(n+1)>>1];build(0,n+1,n+2);
		}
		void rever(int l,int r){
			int x=split(l,r);
			if(tag[x])return;
			rev[x]^=1;
			swap(L(x),R(x));swap(lmx[x],rmx[x]);
			upd(par[x]);upd(rt);
		}
		int query(int l,int r){
			int x=split(l,r);
			return sum[x];
		}
		void del(int l,int r){
			int x=split(l,r);
			L(par[x])=0;upd(par[x]);upd(rt);
			mem::rec(x);
		}
		void modify(int l,int r,int k){
			int x=split(l,r);tag[x]=1;w[x]=k;
			lmx[x]=rmx[x]=max(0,sum[x]=w[x]*siz[x]);
			sub[x]=max(sum[x],w[x]);
			upd(par[x]);upd(rt);
		}
		void ins(int l,int tot){
			for(int i=0;i<tot;i++)scanf("%d ",&a[i]);
			for(int i=0;i<tot;i++)loc[i]=mem::ext();
			split(l+1,l);
			loc[tot]=R(rt);build(0,tot-1,tot);
			upd(loc[tot]);upd(rt);
		}
		int get(){return sub[rt];}
	}
}
int main(){
	using namespace spt::opt;
	freopen("in","r",stdin);freopen("out","w",stdout);
	int n,m;scanf("%d %d\n",&n,&m);
	init(n);
	for(int i=0;i<m;i++){
		char s[10];int p,t,k;
		scanf("%s",s);
		if(s[2]!='X')scanf("%d %d",&p,&t);
		if(s[2]=='K')scanf("%d",&k);
		switch(s[0]){
			case'I':ins(p,t);break;
			case'D':del(p,p+t-1);break;
			case'R':rever(p,p+t-1);break;
			case'G':printf("%d\n",query(p,p+t-1));break;
			default:
				switch(s[2]){
					case'K':modify(p,p+t-1,k);break;
					case'X':printf("%d\n",get());break;
				}break;
		}
	}
	return 0;
}
