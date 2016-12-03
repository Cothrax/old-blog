#include<cstdio>
#include<algorithm>
using namespace std;
const int N=200010;
int stk[N],idx[N],n,m,t;
void ins(int x,int k){
	while(t>0&&stk[t]<k)t--;
	stk[++t]=k;idx[t]=x;
}
int bin(int x){ //max_i{idx[i]>=x}
	int l=1,r=t,ans=t;
	while(l<=r){
		int mid=(l+r)/2;
		if(idx[mid]>=x)ans=mid,r=mid-1;
		else l=mid+1;
	}
	return stk[ans];
}
int main(){
	//freopen("in","r",stdin);freopen("out","w",stdout);
	scanf("%d %d\n",&n,&m);
	int lst=0,sz=0;t=0;
	for(int i=0;i<n;i++){
		int x;char c;
		scanf("%c %d\n",&c,&x);
		switch(c){
			case 'A':ins(++sz,(x+lst)%m);break;
			case 'Q':printf("%d\n",lst=bin(sz-x+1));break;
		}
	}
	return 0;
}
