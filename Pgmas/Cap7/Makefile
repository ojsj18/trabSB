CC = gcc

FONTES_C = O1.c O2.c O3.c O4.c
OBJS_C  = $(FONTES_C:%.c=%.o)

Exec: $(OBJS_C) 
	$(CC) $(OBJS_C) -o $@

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

simplemainLib: simplemain.c libbar_dep.a libfunc_dep.a
	gcc  simplemain.o -L.  -lbar_dep -lfunc_dep


simplemain: simplemain.c 
#	$(CC) $(CFLAGS) -c bar_dep.c -o bar_dep.o
#	$(CC) $(CFLAGS) -c func_dep.c -o func_dep.o
#	$(CC) $(CFLAGS) -c simplemain.c -o simplemain.o
#	ar -cr bar_dep.a bar_dep.o
#	ar -cr func_dep.a func_dep.o
	gcc  simplemain.o bar_dep.o func_dep.o

libbar_dep.a: bar_dep.o
	ar -cr $@ bar_dep.o

libfunc_dep.a: func_dep.o
	ar -cr $@ func_dep.o


all: Exec simplemain simplemainLib

clean:
	rm -f Exec  $(OBJS_C) libbar_dep.a libfunc_dep.a
