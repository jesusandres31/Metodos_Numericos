%ejer 2
exec('FuncionesMetodos.sce',-1);
clc;
xdata = linspace(22,254);
ydata = -0.0013*xdata^3+0.3*xdata^2+8*xdata-372;
plot (xdata,ydata);
funcion_vector = [-372,8,0.3,-0.0013];
xlabel('X');
ylabel('Y = F(X)');
title("Grafico de la Funcion");
strfunc = "f(x) = " + pol2str(poly(funcion_vector, "x","coeff"));
legend(strfunc);
xgrid();
printf("Intervalos donde existen raices: \n     [24,26]     [250,252]");
printf("\nQue error desea que tengan las raices? ");
errbus = input("");
newtonRaph(funcion_vector, [24,26,250,252], errbus);


%ejer 3
exec('FuncionesMetodos.sce',-1);
clc;
xdata = linspace(10,15);
ydata = (2/3)*%pi*xdata^3+30*%pi*xdata^2-15000;
plot (xdata,ydata);
xlabel('X');
ylabel('Y = F(X)');
strfunc = "f(x) = " + pol2str(poly(funcion_vector, "x","coeff"));
title("Grafico de la Funcion");
legend(strfunc);
xgrid();
funcion_vector = [-15000,0,30*%pi,(2/3)*%pi];
printf("Intervalo donde existe raiz: \n     [10,15]");
printf("\n\nQue metodo desea aplicar?\n\t1-Interpolacion Lineal\n\t2-Segundo Orden de Newton: ");
condicion = input("");
printf("\nQue error desea que tengan las raices? ");
errbus = input("");
select condicion
    case 1 then interpolacionLin(funcion_vector, [10,15], errbus);
    case 2 then newtonSegundo(funcion_vector, [10,15], errbus);
        end


        
%ejer 4
function y=valf1(x)
  y=log(400/(500-x));
endfunction

function y=valf2(x)
  y=((5*x-1000)/200);
endfunction

function y=solucion(x)
  y=((5*x-1000)/200)-valorFunc1;
endfunction

clc;

xdata = linspace(200,220);
ydata = log(((500-xdata)/400)^-1);
plot (xdata,ydata,"r");
ydata = ((5*xdata-1000)/200);
plot (xdata,ydata);
legend("f1(x) = ln(400/(500-x))","f2(x) = (5*x-1000)/200");
xlabel('X');
ylabel('Y = F(X)');
title("Grafico de la Funcion");
xgrid();

i = 1;
cont = 1;
printf ("\nMetodo de Iteracion:");
valores = [];
printf("\n\nIngrese el error en el resultado: ");
errbus = input("");
printf("Desea aplicar la aceleracion de Aitken? [S/N]: ");
ak = input("","s");
if (ak == 's' || ak == 'S') then
    band = %t;
else
    band = %f;
end

printf("\nF1(X) = log(400/(500-x))\tF2(X) = ((5*x-1000)/200)\n");

while i < 2
    extremoMenor = 200;
    resultado = 200
    valorFunc1 = valf1(extremoMenor);
    valorFunc2 = valf2(extremoMenor);
    err = abs(extremoMenor);    
    mprintf("\n    X\t\t  F1(X)\t\t  F2(X)\t\tEntorno\t\tError");
    mprintf("\n%f\t%f\t%f\t200\t\t-------",resultado,valorFunc1,valorFunc2);
    valores(cont) = resultado;
    cont = cont + 1;
    while err > errbus
        if valorFunc1 <> valorFunc2
            extremoMenor = resultado;                                 
        end
        err = resultado;
        if band && cont > 3
            resultado = valores(3) - (((valores(3)-valores(2))^2)/(valores(3)-2*valores(2)+valores(1)));
            cont = 1;
        else
            resultado = fsolve(resultado,solucion);
        end
        err = abs(err - resultado);
        valorFunc1 = valf1(resultado);
        valorFunc2 = valf2(resultado);
        if valorFunc1 <> valorFunc2
           mprintf("\n%f\t%f\t%f\t200\t\t%f",resultado,valorFunc1,valorFunc2,err);
           valores(cont) = resultado;
           cont = cont + 1;    
        end          
    end
    printf ("\n\n\t*Punto de interseccion en el entorno 200 con un error de %f= %f\n",errbus, resultado);
    i = i+2;
end


% ejer 5
function y=valf(x,func)
    select func
        case 1 then y=(2*x+2)^(1/3);
        case 2 then y=(2+(2/x))^(1/2);
        case 3 then y=(2/x)+(2/(x^2));
        case 4 then printf("\nF1(X) = x\tF2(X) = (2*x+2)^(1/3)\n"); y=0;
        case 5 then printf("\nF1(X) = x\tF2(X) = (2+(2/x))^(1/2)\n"); y=0;
        case 6 then printf("\nF1(X) = x\tF2(X) = (2/x)+(2/(x^2))\n"); y=0;
    end
  
endfunction

function y=solucion(x)
  y=valorFunc2-x;
endfunction

function iteracion (funcionID, band, errbus)
    while i < 2
        extremoMenor = 1;
        resultado = 1;
        valorFunc1 = 1;
        valorFunc2 = valf(valorFunc1,funcionID);
        err = abs(extremoMenor);    
        mprintf("\n    X\t\t  F1(X)\t\t  F2(X)\t\tIntervalo\tError");
        mprintf("\n%f\t%f\t%f\t(1; 2)\t\t-------",resultado,valorFunc1,valorFunc2);
        valores(cont) = resultado;
        cont = cont + 1;
        while err > errbus
            if valorFunc1 <> valorFunc2
                extremoMenor = resultado;                                 
            end
            err = resultado;
            if band && cont > 3
                resultado = valores(3) - (((valores(3)-valores(2))^2)/(valores(3)-2*valores(2)+valores(1)));
                cont = 1;
            else
                resultado = fsolve(resultado,solucion);
            end
            err = abs(err - resultado);
            valorFunc1 = resultado;
            valorFunc2 = valf(valorFunc1,funcionID);
            if valorFunc1 <> valorFunc2
               mprintf("\n%f\t%f\t%f\t(1; 2)\t\t%f",resultado,valorFunc1,valorFunc2,err);
               valores(cont) = resultado;
               cont = cont + 1;    
            end          
        end
        printf ("\n\n\t*Punto de interseccion en el intervalo (1; 2) con un error de %f= %f\n",errbus, resultado);
        i = i+2;
    end
endfunction

clc;

xdata = linspace(0,3);
ydata = xdata^3-2*xdata-2;
plot (xdata,ydata);
legend("f(x) = x^3-2x-2");
xlabel('X');
ylabel('Y = F(X)');
title("Grafico de la Funcion");
xgrid();

i = 1;
cont = 1;
printf ("\nMetodo de Iteracion:");
valores = [];
printf("\n\nIngrese el error en el resultado: ");
errbus = input("");
printf("Desea aplicar la aceleracion de Aitken? [S/N]: ");
ak = input("","s");
if (ak == 's' || ak == 'S') then
    band = %t;
else
    band = %f;
end

for j=1:1:3
    valf(1,j+3)
    iteracion(j,band,errbus);

end





