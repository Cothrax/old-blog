#include<algorithm>
#include<cstdio>
#define P pair<int,int>
#define mkp(x,y) make_pair(x,y)
#define ll long long
using namespace std;
const int N=11,Z=N*N*2;const ll INF=10E16;
int n,m,nm,l;ll a[N*N];
inline int p(int x,int y){return x*m+y;}

P pre[N*N][1<<N];ll f[N*N][1<<N];
const int X[4]={0,1,0,-1},Y[4]={1,0,-1,0};
int q[Z],h,t;bool inq[Z];
void spfa(int i){
	for(;h!=t;inq[q[h]]=0,h=(h+1)%Z)
		for(int j=0;j<4;j++){
			int u=q[h],x=u/m+X[j],y=u%m+Y[j],v=p(x,y);
			if(x<0||y<0||x>=n||y>=m)continue;
			if(f[v][i]>f[u][i]+a[v]){
				f[v][i]=f[u][i]+a[v];pre[v][i]=mkp(u,i);
				if(!inq[v])q[t++]=v,inq[v]=1,t%=Z;
			}
		}
}

bool flg[Z];
void dfs(int i,int j){
	if(f[i][j]==INF||i==-1||j==0)return;
	flg[i]=1;int x,y;
	dfs(x=pre[i][j].first,y=pre[i][j].second);
	if(x==i)dfs(x,y^j);
}

int main(){
	//freopen("in","r",stdin);freopen("out","w",stdout);
	scanf("%d %d",&n,&m);nm=n*m;
	int sp[N],k=0;bool mk[Z];
	fill(mk,mk+Z,0);
	for(int i=0;i<n;i++)
		for(int j=0;j<m;j++){
			scanf("%lld",&a[p(i,j)]);
			if(!a[p(i,j)])sp[k++]=p(i,j),mk[p(i,j)]=1;
		}
	l=1<<k;
	for(int i=0;i<nm;i++){
		fill(f[i],f[i]+l+1,INF);
		fill(pre[i],pre[i]+l+1,mkp(-1,0));
	}
	for(int i=0;i<k;i++)f[sp[i]][1<<i]=0;
	fill(inq,inq+Z,0);
	for(int i=0;i<l;i++){
		ll tmp;h=t=0;
		for(int j=0;j<nm;j++){
			for(int s=i;s;s=i&(s-1))
				if(f[j][i]>(tmp=f[j][s]+f[j][i^s]-a[j]))
					f[j][i]=tmp,pre[j][i]=mkp(j,s);
			if(f[j][i]!=INF)q[t++]=j,inq[j]=1,t%=Z;
		}spfa(i);
	}
	printf("%lld\n",f[sp[0]][l-1]);dfs(sp[0],l-1);
	for(int i=0;i<n;i++){
		for(int j=0;j<m;j++)
			if(mk[p(i,j)])printf("x");
			else if(flg[p(i,j)])printf("o");
			else printf("_");
		printf("\n");
	}
	return 0;
}
