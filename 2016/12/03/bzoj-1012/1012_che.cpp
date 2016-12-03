#include<algorithm>
#include<cstdio>
using namespace std;
const int N=200010;
int a[N],n,m,k,sz;
int ask(int x){
	int ret=0;
	for(int i=0;i<x;i++)ret=max(ret,a[sz-i]);
	return ret;
}

int main(){
	freopen("in","r",stdin);
	freopen("ans","w",stdout);
	scanf("%d %d\n",&n,&m);
	int lst=0,x;char c;
	for(int i=0;i<n;i++){
		scanf("%c %d\n",&c,&x);
		switch(c){
			case 'A':a[++sz]=(x+lst)%m;break;
			case 'Q':printf("%d\n",lst=ask(x));break;
		}
	}
	return 0;
}
