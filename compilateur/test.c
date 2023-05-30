int g(int c){
  return c+20;
}

int f(int a){
  return 2*a;
}

int main(void){
  int a=15;
  int b = 50;
  while(a<f(b)){
    a = g(a);
    if (a>=95){
      a = a-4;
    }
    else{
      a = a+1;
    }
  }
 return a;
}