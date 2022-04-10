long  int a, b;                            
void troca (long  int *x, long int *y)           
{                                     
  long  int z;                          
  z  = *x;                       
  *x = *y;                       
  *y = z;                        
}                               

int main (long  int argc, char **argv)          
{                                     
  a=1;                            
  b=2;                            
  troca (&a, &b);                 
  return (0);                       
}                                

