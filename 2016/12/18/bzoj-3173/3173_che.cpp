#include<iostream>
#include<cstdio>
#include<cstring>
#include<cstdlib>
#include<set>
#include<ctime>
#include<vector>
#include<queue>
#include<algorithm>
#include<map>
#include<cmath>
#define eps 1e-8
#define inf 1000000000
#define rad 100000000
#define pa pair<int,int>
#define ll long long 
using namespace std;
int read()
{
    int x=0,f=1;char ch=getchar();
    while(ch<'0'||ch>'9'){if(ch=='-')f=-1;ch=getchar();}
    while(ch>='0'&&ch<='9'){x=x*10+ch-'0';ch=getchar();}
    return x*f;
}
int n,cnt,root,now,mx;
int mn[100005],ans[100005];
int v[100005],size[100005],rnd[100005],l[100005],r[100005];
void update(int x)
{
	size[x]=size[l[x]]+size[r[x]]+1;
}
void rturn(int &k)
{
	int t=l[k];l[k]=r[t];r[t]=k;update(k);update(t);k=t;
}
void lturn(int &k)
{
	int t=r[k];r[k]=l[t];l[t]=k;update(k);update(t);k=t;
}
void insert(int &x,int rank)
{
	if(!x)
	{
		x=++cnt;
		rnd[x]=rand();size[x]=1;
		return;
	}
	size[x]++;
	if(size[l[x]]<rank)
	{
		insert(r[x],rank-size[l[x]]-1);
		if(rnd[r[x]]<rnd[x])lturn(x);
	}
	else 
	{
		insert(l[x],rank);
		if(rnd[l[x]]<rnd[x])rturn(x);
	}
}
void dfs(int x)
{
	if(!x)return;
	dfs(l[x]);
	v[++now]=x;
	dfs(r[x]);
}
void solve()
{
	memset(mn,127,sizeof(mn));
	mn[0]=-inf;
	for(int i=1;i<=n;i++)
	{
		int t=upper_bound(mn,mn+mx+1,v[i])-mn;
		if(mn[t-1]<=v[i])
		{
			mn[t]=min(mn[t],v[i]);
			ans[v[i]]=t;
			mx=max(t,mx);
		}
	}
}
int main()
{
	
	freopen("in","r",stdin);freopen("ans","w",stdout);
	n=read();
	for(int i=1;i<=n;i++)
	{
		int x=read();
		insert(root,x);
	}
	dfs(root);
	solve();
	for(int i=1;i<=n;i++)
	{
		ans[i]=max(ans[i-1],ans[i]);
		printf("%d\n",ans[i]);
	}
	return 0;
}
