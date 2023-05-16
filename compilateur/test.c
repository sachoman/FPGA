int f(int a, int b){
  int c  = 4+3;
  c = a+b+2+c;
  return c;
}

int g(void){
  return 4*6-2;
}

int main(void){
  int e = 2;
  e = f(5,6);
  return e - g();
}