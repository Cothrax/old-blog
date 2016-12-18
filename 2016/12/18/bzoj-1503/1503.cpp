#include<algorithm>
#include<cstdio>
#include<cstdlib>
using namespace std;
const int N=100010;
int dlt=0,sz=0;
struct node{int l,r,w,rnd,cnt,s;}t[N];
void upd(int &k){t[k].s=t[t[k].l].s+t[t[k].r].s+t[k].cnt;}
void lturn(int &k){
	int p=t[k].r;t[k].r=t[p].l;t[p].l=k;
	t[p].s=t[k].s;upd(k);k=p;
}
void rturn(int &k){
	int p=t[k].l;t[k].l=t[p].r;t[p].r=k;
	t[p].s=t[k].s;upd(k);k=p;
}
void ins(int &k,int x){
	if(!k)t[k=++sz].rnd=rand(),t[k].w=x,t[k].cnt=t[k].s=1;
	else if(x<t[k].w){
		ins(t[k].l,x);upd(k);
		if(t[k].rnd<t[t[k].l].rnd)rturn(k);
	}else if(x>t[k].w){
		ins(t[k].r,x);upd(k);
		if(t[k].rnd<t[t[k].r].rnd)lturn(k);
	}else{t[k].cnt++;upd(k);}
}
int del(int &k,int x){
	if(!k)return 0;
	if(t[k].w<x){
		int ret=t[t[k].l].s+t[k].cnt;k=t[k].r;
		ret+=del(k,x);upd(k);return ret;
	}else{
		int ret=del(t[k].l,x);upd(k);return ret;
	}
}
int kth(int &k,int x){
	if(!k)return -1;
	int tmp=t[k].s-t[t[k].l].s;
	if(t[t[k].r].s>=x)return kth(t[k].r,x);
	else if(tmp<x) return kth(t[k].l,x-tmp);
	else return t[k].w+dlt;
}
void print(int &k,int dep){
	if(!k)return;
	print(t[k].l,dep+1);
	for(int i=0;i<dep;i++)printf("        ");
	printf("t[%d]=%d(%d/%d)%d\n",k,t[k].w,t[k].cnt,
		t[k].s,t[k].rnd/1000000);
	print(t[k].r,dep+1);
}
int main(){
	//freopen("in","r",stdin);freopen("out","w",stdout);
	srand(102458);
	int n,m,ans=0,rt=0;
	scanf("%d %d\n",&n,&m);
	for(int i=0;i<n;i++){
		char c;int x;scanf("%c %d\n",&c,&x);
		switch(c){
			case 'I':if(x>=m)ins(rt,x-dlt);break;
			case 'A':dlt+=x;break;
			case 'S':dlt-=x,ans+=del(rt,m-dlt);break;
			case 'F':printf("%d\n",kth(rt,x));break;
		}
	}
	printf("%d",ans);
	return 0;
}
