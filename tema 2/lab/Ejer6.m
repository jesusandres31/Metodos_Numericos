clc;

x = 4.71;
% Valor Real
% Truncado a tres decimales
% Redondeado a tres decimales
matriz = [1,-6,3,-0.149; 1,-6,3,-0.149; 1,-6,3,-0.149]; 
matrizCuadro = [0,0,0,0,0;0,0,0,0,0;0,0,0,0,0];

for i=1:1:length(matriz(1,:)) % Recorre todas las columnas de la matriz, 
    for j=i:1:length(matriz(1,:)) % Dependiendo de la columna que se haga referencia (i), se multiplicara la x por si misma (La columna define el exponente al cual esta elevada la variable)
        if j ~= length(matriz(1,:))  
            matriz(:,i) = matriz(:,i) * x;
        end
        % Se evalua la cantidad de enteros tiene el numero, se hace esto para eliminar los decimales no deseados
        if abs(matriz(1,i)) >= 100 
            matriz(2,i) = fix(matriz(2,i));
            matriz(3,i) = round(matriz(3,i));
        else
            if abs(matriz(1,i)) >= 10 
                matriz(2,i) = (fix(matriz(2,i)*10))/10;
                matriz(3,i) = (round(matriz(3,i)*10))/10;
            else 
                matriz(2,i) = (fix(matriz(2,i)*100))/100;
                matriz(3,i) = (round(matriz(3,i)*100))/100;
            end
        end
        % Almacena los valores de la tabla (ver ejercicio) en la matriz matrizCuadro
        if i==1 
            matrizCuadro(:,j) = matriz(:,1);
        end
    end
end

matrizCuadro(:,4) = matriz(:,2)*-1;
matrizCuadro(:,5) = matriz(:,3);
trunc = 0;
red = 0;

% Finalmente se suma cada valor de la fila, y dependiendo de la columna se redondea o trunca el resultado a 3 digitos
if abs(sum(matriz(1,:))) >= 100 
    trunc = fix(sum(matriz(2,:)));
    red = round(sum(matriz(3,:)));
else 
    if abs(sum(matriz(1,:))) >= 10 
        trunc = (fix(sum(matriz(2,:))*10))/10;
        red = (round(sum(matriz(3,:))*10))/10;
    else 
        trunc = (fix(sum(matriz(2,:))*100))/100;
        red = (round(sum(matriz(3,:))*100))/100;
    end
end

fprintf("\tx\t\t x^2\t\t x^3\t\t6x^2\t\t3x\n");
disp (matrizCuadro);
fprintf("\nValor exacto: %f\nValor truncado a 3 digitos: %.1f\nValor redondeado a 3 digitos: %.1f\n",sum(matriz(1,:)),trunc,red);
erra=abs(sum(matriz(1,:))-trunc);
errr=erra / abs(sum(matriz(1,:)));
fprintf("\nValor truncado:\n\tError absoluto: %f\tError Relativo: %f\n",erra,errr);
erra=abs(sum(matriz(1,:))-red);
errr=erra / abs(sum(matriz(1,:)));
fprintf("\nValor redondeado:\n\tError absoluto: %f\tError Relativo: %f",erra,errr);

fprintf("\n\n");
