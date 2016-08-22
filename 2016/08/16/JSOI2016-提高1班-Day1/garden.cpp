#include<cstdio>
#include<cstring>
#include<iostream>
#include<algorithm>

#define maxn 100010
#define INF  0x3f3f3f3f
using namespace std;
int  n,m,K;
int  F[maxn][20];
int  H[maxn];       //深度 
int  D[maxn];       //距离 

int  List[maxn*3];  //SCC距离 
int  Front[maxn];   //SCC第一距离 
int  Back[maxn];    //SCC第二距离
int  SCC[maxn];     //联通分量 
int  Ls=0,SCCs=0;
struct Edge{int v,w;Edge *next;};
Edge *E[maxn],Er[maxn*3];int Es=0;

struct Data1{
	void addEdge(int u,int v,int w){
		Edge *P=&Er[++Es];P->v=v;P->w=w;P->next=E[u];E[u]=P;
		      P=&Er[++Es];P->v=u;P->w=w;P->next=E[v];E[v]=P;
	}
	void init(){
		memset(E,0,sizeof(E));
		int u,v,w;
		scanf("%d%d",&n,&m);
		for(int i=1;i<=m;i++)scanf("%d%d%d",&u,&v,&w),addEdge(u,v,w);
	}
}data1;

int  calc(int u,int v){
	int x1=Front[u],x2=Back[u],y1=Front[v],y2=Back[v],dis=INF;
	dis=min(dis,abs(List[x1]-List[y1]));
	dis=min(dis,abs(List[x1]-List[y2]));
	dis=min(dis,abs(List[x2]-List[y1]));
	dis=min(dis,abs(List[x2]-List[y2]));
	return dis;
}
int  LCA(int u,int v){
	int fu=u,fv=v;
	if(D[fu]>D[fv])swap(fu,fv);
	for(int j=19;j>=0;j--)
	    if(F[fv][j]&&D[F[fv][j]]>=D[fu])fv=F[fv][j];
	if(fv==fu)return H[u]+H[v]-H[fu]-H[fu];
	for(int j=19;j>=0;j--)
	    if(F[fv][j]&&F[fu][j]&&F[fu][j]!=F[fv][j])fu=F[fu][j],fv=F[fv][j];
	if(SCC[fu]!=SCC[fv]||SCC[fu]==0||SCC[fv]==0)return H[u]+H[v]-H[F[fu][0]]-H[F[fu][0]];
	return H[u]+H[v]-H[fu]-H[fv]+calc(fu,fv);
}

int  Q[maxn],bot;
struct Data2{
	int  Path[maxn],Length[maxn],u;
	bool V[maxn];
	int  P1[maxn*2][2],P2[maxn][2],bot1,bot2;
	
	void getPath(int u,int v,int f,int w){
		bot1=bot2=0;
		//cout<<"getPath "<<u<<" "<<v<<" "<<f<<" "<<w<<endl;
		for(int P=u;H[P]>=H[f];P=Path[P]){bot1++;P1[bot1][0]=P;P1[bot1+1][1]=Length[P];}
		//cout<<"P1"<<endl;
		//for(int i=1;i<=bot1;i++)cout<<i<<" "<<P1[i][0]<<" "<<P1[i][1]<<endl;
		for(int P=v;H[P]>H[f];P=Path[P]){bot2++;P2[bot2][0]=P;P2[bot2][1]=Length[P];}
		//cout<<"P2"<<endl;
		//for(int i=1;i<=bot2;i++)cout<<i<<" "<<P2[i][0]<<" "<<P2[i][1]<<endl;
		while(bot2){
			bot1++;P1[bot1][0]=P2[bot2][0];P1[bot1][1]=P2[bot2][1];bot2--;
		}
		for(int i=bot1+1;i<=bot1*2;i++)P1[i][0]=P1[i-bot1][0],P1[i][1]=P1[i-bot1][1];
		P1[bot1+1][1]+=w;
		
		Ls++;
		for(int i=1;i<=bot1*2;i++)List[Ls+i]=List[Ls+i-1]+P1[i][1];
		for(int i=1;i<=bot1;i++)Front[P1[i][0]]=Ls+i,Back[P1[i][0]]=Ls+i+bot1;
		Ls+=bot1*2;
	}
	void findSCC(int u,int v,int w){
		int fu=u,fv=v;
		while(fu!=fv)if(H[fu]>H[fv])fu=Path[fu];else fv=Path[fv];
		getPath(u,v,fu,w);
		
		SCCs++;
		for(int i=1;i<=bot1;i++)SCC[P1[i][0]]=SCCs;
		for(int i=1;i<=bot1;i++)if(P1[i][0]!=fu)F[P1[i][0]][0]=fu;
		//cout<<"SCC "<<SCCs<<endl;
		//for(int i=1;i<=2*bot1;i++)cout<<i<<" "<<P1[i][0]<<" "<<P1[i][1]<<endl;
	}
	void BFS(){
		memset(H,0,sizeof(H));
		memset(V,true,sizeof(V));
		memset(List,0,sizeof(List));
		memset(SCC,0,sizeof(SCC));
		memset(F,0,sizeof(F));
		Q[bot=1]=1;V[1]=false;Path[1]=Length[1]=0;H[1]=1;
		for(int top=1;top<=bot;top++){
			u=Q[top];
			//cout<<"BFS "<<u<<endl;
			for(Edge *P=E[u];P;P=P->next){
			    if(P->v==Path[u])continue;
			    if(V[P->v]){
					Q[++bot]=P->v;
					H[P->v]=H[u]+1;V[P->v]=false;
					F[P->v][0]=Path[P->v]=u;
					Length[P->v]=P->w;
			    }
			    else if(SCC[u]==0)findSCC(P->v,u,P->w);
			}
		}
		//for(int i=1;i<=bot;i++)cout<<Q[i]<<" "<<F[Q[i]][0]<<" "<<SCC[Q[i]]<<" "<<Length[Q[i]]<<endl;
	}
	void work(){
		memset(H,0,sizeof(H));
		memset(D,0,sizeof(D));
		for(int top=1;top<=bot;top++){
			u=Q[top];
			D[u]=D[F[u][0]]+1;
			if(SCC[F[u][0]]!=SCC[u]||SCC[u]==0)H[u]=H[F[u][0]]+Length[u];
			                              else H[u]=H[F[u][0]]+calc(F[u][0],u);
			for(int j=1;j<20&&F[u][j-1];j++)F[u][j]=F[F[u][j-1]][j-1];
		}
		/*
		for(int i=1;i<=bot;i++){
			u=Q[i];
			printf("Qi=%d SCC=%d H=%d D=%d\n",u,SCC[u],H[u],D[u]);
			for(int j=0;j<20;j++)printf("%5d",F[u][j]);cout<<endl;
		}
		*/
	}
}data2;

struct Data3{
	void query(){
		int  u,v;
		scanf("%d",&K);
		for(int i=1;i<=K;i++){
			scanf("%d%d",&u,&v);
			printf("%d\n",LCA(u,v));
		}
	}
}data3;
int  main(){
	freopen("garden.in","r",stdin);
	freopen("garden.out","w",stdout);
	data1.init();
	data2.BFS();
	data2.work();
	data3.query();
	return 0;
}
