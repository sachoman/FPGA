int g(int c){
  return c+50;
}

int main(void){
  int a=15;
  a=g(a);
  while(a<100){
    a = g(a);
  }
 return a;
}