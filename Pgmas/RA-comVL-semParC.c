long  int a, b;

long int soma ( )
{
  long int x, y;
  x=a;
  y=b;
  return (x+y);
}

int main (long  int argc, char **argv)
{
  a=4;
  b=5;
  b = soma();
  return (b);
}
