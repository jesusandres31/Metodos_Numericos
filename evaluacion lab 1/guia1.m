classdef guia1   
    methods (Static)
        
        %%
        %
        %
        % Ejercicio numero 1
        %
        function ejer1()
            fprintf("\n");
            
            res = 's';
            acum = 0;
            while (res == 's') || (res == 'S')
                n = input ("Ingrese un numero: ");
                acum = acum + n;
                res = input ("Desea sumar otro numero al resultado? [S/N]: ","s");
            end
            fprintf ("El resultado de la suma es: %.2f\n", acum);

            fprintf("\n\n");
        end
        
        
        %%
        %
        %
        % Ejercicio numero 2
        %
        function ejer2()
            fprintf("\n");
            
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

            fprintf("\n\n");
        end
        
        
        %%
        %
        %
        % Ejercicio numero 3
        %
        function ejer3()
            fprintf("\n");
            
            fprintf("Valores de X que satisfacen la ecuacion: 3X + 1 = 5X + 3(X^2)");
            res = sqrt(2^2 - 4*3*(-1));
            fprintf("\n\nX1 = %f\nX2 = %f",(-2+res)/(2*3),(-2-res)/(2*3));

            fprintf("\n\n");
        end
        
        
        %%
        %
        %
        % Ejercicio numero 4
        %
        function ejer4()
            fprintf("\n");
            
            fprintf("Balance 05/07: 512.33\n\n");
            acum = 512.33;
            fprintf("Movimientos 06/07:\nDepositos: 220.13\tRetiros: 327.26\n");
            acum = acum +220.13-327.26;
            fprintf("Balance 06/07: %.2f\n\n",acum);
            fprintf("Movimientos 07/07:\nDepositos: 216.80\tRetiros: 378.62\n");
            acum = acum +216.8 -378.62;
            fprintf("Balance 06/07: %.2f\n\n",acum);
            fprintf("Movimientos 08/07:\nDepositos: 320.25\tRetiros: 106.80\n");
            acum = acum +320.25 -106.8;
            fprintf("Balance 08/07: %.2f\n\n",acum);

            fprintf("\n\n");
        end
        
        
        %%
        %
        %
        % Ejercicio numero 5
        %
        function ejer5()
            fprintf("\n");
            
            l = 1 + 0.3 + 0.05 - 0.4 - 0.2 - 1.4 - 2.3 - 0.35;
            t = abs(l);
            fprintf("Por dia se debe tomar %.2f litros de agua", t);

            fprintf("\n\n");
        end
        
        
        %%
        %
        %
        % Ejercicio numero 6
        %
        function ejer6()
            fprintf("\n");
            
            n = input("Ingrese el valor de N: ");
            e=0;
            for i=0:+1:n
                fact = factorial(i);
                e = e + (1/fact);
            end
            fprintf ("El valor de e es %f", e);

            fprintf("\n\n");
        end
        
        
        %%
        %
        %
        % Ejercicio numero 7
        %
        function ejer7()
            fprintf("\n");
            
            n = input ("Ingrese la cantidad de cifras decimales exactas desea: ");
            % toma el valor de pi y lo multiplica por 10 elevado a la
            % cantidad de posiciones decimales ingresadas por el usuario
            P = int32(pi*10^n); 
            aprox = 0;
            band = 1;
            cont = 1;
            serie = 0;
            % cuando el valor de la sucesion llegue al mismo valor
            % solicitado por el usuario termina el bucle
            while int32((aprox*4)*10^n) ~= P 
                if band == 1
                    aprox = aprox + (1/cont);
                    band = 0;
                else
                    aprox = aprox - (1/cont);
                    band = 1;
                end
                cont = cont + 2;
                % por cada iteracion se suma un valor en serie para saber
                % cuantos terminos de la serie de Taylor fueron necesarios
                serie = serie + 1; 
            end
            fprintf("Cantidad de terminos de la serie de Taylor necesarios para obtener 3.%i = %i",pi-3*10^n,serie);

            fprintf("\n\n");
        end
        
        
        %%
        %
        %
        % Ejercicio complementario numero 1
        %
        function ejer_comp1()
            fprintf("\n");
            
            i = 0;
            while (((-1)^i)/((2*i)+1)) ~= (1/17)
                i = i + 1;       
            end
            fprintf ("La solucion tiene %i terminos",i);
            fprintf ("\n\n");

            fprintf("\n\n");
        end
    end
end

