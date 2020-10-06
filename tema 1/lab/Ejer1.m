clc;
res = 's';
acum = 0;
while (res == 's') || (res == 'S')
    n = input ("Ingrese un numero: ");
    acum = acum + n;
    res = input ("Desea sumar otro numero al resultado? [S/N]: ","s");
end
fprintf ("El resultado de la suma es: %.2f\n", acum);
fprintf ("\n\n");
