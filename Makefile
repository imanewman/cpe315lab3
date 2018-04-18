FLAGS=-O1 
# list .s source files here
SRCFILES=main.s intadd.s intsub.s intmul.s

all:	intcalc

intcalc: $(SRCFILES) 
	gcc $(FLAGS) -o intcalc $^ 

clean: 
	rm -f *.o intcalc

scp:
	scp *.s tnewma03@unix3.csc.calpoly.edu:~/cpe315/lab3
	#scp Makefile tnewma03@unix3.csc.calpoly.edu:~/cpe315/lab3