clc;
p = input ("Ingrese la cantidad de dinero que invertira: ");
t = input ("Igrese la tasa (no porcentual) de interes anual que obtendra: ");
n = input ("Ingrese la cantidad de anios que se llevara a cabo: ");
fprintf ("Aumento de su inversion de %.0f a lo largo de %i anio/s a una tasa de %.2f: \n\n",p,n,t);
fprintf("\tAnio\tIngresos\n");
for i= 1:n
    fprintf("\t %i\t\t%.2f\n",i,p*(1+t)^i);
end
fprintf("\n\nGanancias Brutas: %.2f", (p*(1+t)^n));
fprintf("\nRendimiento esperado: %.2f", (p*(1+t)^n) - p);
fprintf ("\n\n");