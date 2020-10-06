clc;
n = input("Ingrese el valor de N: ");
e=0;
for i=0:+1:n
    fact = factorial(i);
    e = e + (1/fact);
end
fprintf ("El valor de e es %f", e);
fprintf ("\n\n");