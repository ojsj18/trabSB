long int data_items[]={3,  67, 34, 222, 45, 75, 54, 34,
                       44, 33, 22,  11, 66, 0};
long int i, maior;
int main (long int argc, char **argv)
{
  maior = data_items[0];
  i=1;
  while (data_items[i] != 0)
    {
      if (data_items[i] > maior)
        maior = data_items[i];
      i++;
    }
  return (maior);
}
