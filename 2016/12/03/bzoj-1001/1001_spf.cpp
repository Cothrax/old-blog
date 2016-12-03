#include<cstdio>
#include<iostream>
#include<string.h>
#include<algorithm>
using namespace std;
const int N=1000*1000*2,INF=1000000000;
struct edge{int v,w,nxt;} g[N*3];
int n,m,S,T,sz=0,head[N],q[N],d[N];
bool inq[N]={false};
inline void _add(int u,int v,int w)
{g[++sz]={v,w,head[u]};head[u]=sz;}
inline void add(int u,int v,int w)
{_add(u,v,w);_add(v,u,w);}
inline int p(int x,int y,int z){
	if(x<0||y>m-2)return S;
	if(x>n-2||y<0)return T;
	return x*m*2+y*2+z;
}
int spfa(){
	fill(d,d+N,INF);int u,v;q[0]=S;inq[S]=true;d[S]=0;
	for(int h=0,t=1;h!=t;inq[q[h]]=false,h=(h+1)%N)
		for(int i=head[u=q[h]];i;i=g[i].nxt)
			if(d[v=g[i].v]>d[u]+g[i].w){
				d[v]=d[u]+g[i].w;
				if(!inq[v]){q[t++]=v;t%=N;inq[v]=true;}
			}
	return d[T];
}
int main(){
	//freopen("1001.in","r",stdin);
	//freopen("1001.out","w",stdout);
	scanf("%d%d",&n,&m);
	int w;S=n*m*2,T=n*m*2+1;
	for(int i=0;i<n;i++)
		for(int j=0;j<m-1;j++)
			scanf("%d",&w),add(p(i-1,j,1),p(i,j,0),w);
	for(int i=0;i<n-1;i++)
		for(int j=0;j<m;j++)
			scanf("%d",&w),add(p(i,j-1,0),p(i,j,1),w);
	for(int i=0;i<n-1;i++)
		for(int j=0;j<m-1;j++)
			scanf("%d",&w),add(p(i,j,0),p(i,j,1),w);
	printf("%d",spfa());
	//fclose(stdin);fclose(stdout);
	return 0;
}
/*
3 4
5 6 4
4 3 1
7 5 3
5 6 7 8
8 7 6 5
5 5 5
6 6 6
 */