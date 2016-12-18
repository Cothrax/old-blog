#include<algorithm>
#include<cstdio>
using namespace std;
const int N=100010;
//splay::begin
int c[N][2],siz[N],par[N],rt;bool flg[N];
void upd(int x){siz[x]=siz[c[x][0]]+siz[c[x][1]]+1;}
void pushdn(int x){
	if(!flg[x])return;
	swap(c[x][0],c[x][1]);
	int l=c[x][0],r=c[x][1];
	flg[l]^=1;flg[r]^=1;flg[x]=0;
}
void rotate(int x,int &k){
	int y=par[x],z=par[y],l=c[y][0]==x?0:1,r=l^1;
	if(y==k)k=x;else c[z][c[z][0]==y?0:1]=x;
	par[x]=z;par[y]=x;par[c[x][r]]=y;
	c[y][l]=c[x][r];c[x][r]=y;
	upd(y);upd(x);
}
int rank(int x,int rk){
	pushdn(x);int l=c[x][0],r=c[x][1];
	if(siz[l]+1==rk)return x;
	else if(siz[l]>=rk)return rank(l,rk);
	else return rank(r,rk-siz[l]-1); //bug: r,not l
}
int find(int rk){return rank(rt,rk);}
void splay(int x,int &k){
	while(x!=k){
		int y=par[x],z=par[y];
		if(y!=k){
			if(c[y][0]==x^c[z][0]==y)rotate(x,k); 
			else rotate(y,k);
		}rotate(x,k); //bug:rotate,not splay
	}
}
void build(int l,int r,int p){
	if(l>r)return;
	if(l==r){
		par[l]=p;siz[l]=1;c[p][l<p?0:1]=l;
		return;
	}
	int mid=(l+r)>>1;
	build(l,mid-1,mid);build(mid+1,r,mid);
	par[mid]=p;upd(mid);c[p][mid<p?0:1]=mid;
}
void rev(int l,int r){
	int x=find(l),y=find(r+2);
	splay(x,rt);splay(y,c[rt][1]);
	flg[c[y][0]]^=1;
}
void walk(int x,int lim){
	if(!x)return;pushdn(x);
	walk(c[x][0],lim);
	if(x!=lim&&x!=1)printf("%d ",x-1);
	walk(c[x][1],lim);
}
//splay::end
int main(){
	//freopen("in","r",stdin);freopen("out","w",stdout);
	int n,m,l,r;scanf("%d %d\n",&n,&m);
	rt=(n+3)>>1;build(1,n+2,0);
	for(int i=0;i<m;i++)
		scanf("%d %d\n",&l,&r),rev(l,r);
	walk(rt,n+2);
	return 0;
}
