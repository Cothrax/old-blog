#include<algorithm>
#include<cstdio>
#include<cstdlib>
using namespace std;
const int N=50010,INF=1E8;
struct treap{
	int sz;
	struct node{int l,r,w,rnd;}t[N];
	treap(){sz=0;srand(20001106);}
	void lturn(int &k)
	{int p=t[k].r;t[k].r=t[p].l;t[p].l=k;k=p;}
	void rturn(int &k)
	{int p=t[k].l;t[k].l=t[p].r;t[p].r=k;k=p;}
	void ins(int &k,int x){
		if(!k)t[k=++sz].w=x,t[k].rnd=rand();
		else if(t[k].w>x){
			ins(t[k].l,x);
			if(t[k].rnd<t[t[k].l].rnd)rturn(k);
		}else if(t[k].w<x){
			ins(t[k].r,x);
			if(t[k].rnd<t[t[k].r].rnd)lturn(k);
		};
	}
	int _max(int &k)
	{if(!t[k].r)return t[k].w;return _max(t[k].r);}
	int _min(int &k)
	{if(!t[k].l)return t[k].w;return _min(t[k].l);}
	int succ(int &k,int x){
		if(!k)return INF;
		if(t[k].w<x)return succ(t[k].r,x);
		if((!t[k].l)||_max(t[k].l)<x)return t[k].w;
		return succ(t[k].l,x);
	}
	int prev(int &k,int x){
		if(!k)return -INF;
		if(t[k].w>x)return prev(t[k].l,x);
		if((!t[k].r)||_min(t[k].r)>x)return t[k].w;
		return prev(t[k].r,x);
	}
	void print(int &k,int dep){
		if(!k)return;
		print(t[k].l,dep+1);
		for(int i=0;i<dep;i++)printf("    ");
		printf("[%d]=%d(%d/%d)%d\n",k,t[k].w,t[k].cnt,t[k].s,
			(int)t[k].rnd/1000000);
		print(t[k].r,dep+1);
	}
}dat;
int main(){
	freopen("in","r",stdin);
	int n,x,ans,rt=0;
	scanf("%d\n%d\n",&n,&ans);
	dat.ins(rt,ans);
	for(int i=1;i<n;i++){
		scanf("%d\n",&x);
		ans+=min(dat.succ(rt,x)-x,x-dat.prev(rt,x));
		dat.ins(rt,x);
	}
	printf("%d",ans);
	return 0;
}
