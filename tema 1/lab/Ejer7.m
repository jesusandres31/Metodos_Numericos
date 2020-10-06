clc;
n = input ("Ingrese la cantidad de cifras decimales exactas desea: ");
pi = int32(pi*10^n); %toma el valor de pi y lo multiplica por 10 elevado a la cantidad de posiciones decimales ingresadas por el usuario
aprox = 0;
band = 1;
cont = 1;
serie = 0;
while int32((aprox*4)*10^n) ~= pi %cuando el valor de la sucesion llegue al mismo valor solicitado por el usuario termina el bucle
    if band == 1
        aprox = aprox + (1/cont);
        band = 0;
    else
        aprox = aprox - (1/cont);
        band = 1;
    end
    cont = cont + 2;
    serie = serie + 1; %por cada iteracion se suma un valor en serie para saber cuantos terminos de la serie de Taylor fueron necesarios
end
fprintf("Cantidad de terminos de la serie de Taylor necesarios para obtener 3.%i = %i",pi-3*10^n,serie);
fprintf ("\n\n");