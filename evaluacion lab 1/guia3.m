classdef guia3   
    methods (Static)
        
        %%
        %
        %
        % Ejercicio numero 1
        % Inputs: 
        % funcion_vector: vector de la funcion polinomica. = [-pi, 9*pi, 0, -90]
        % rango_ejes: rango de los ejes cartesianos. = [-10, 10]
        % n_raices: numero de raices de la funcion previamente obtenidos por el
        % metodo de Rene Descartes. = 3
        % x_inicial: X0 o X inicial. = -20 
        % incremento_x: incremento de X. = 1
        %
        % >> guia3.ejer1([-pi, 9*pi, 0, -90], [-10, 10], 3, -20, 1)
        %
        function ejer1(funcion_vector, rango_ejes, n_raices, x_inicial, incremento_x) 
            import pkg.Metodos.*;
            
            % Graficamos la funcion 
            Metodos.plotFunction(funcion_vector, rango_ejes);
            
            % Ingresamos la funcion, y los de mas parametros
            intervalos = Metodos.tanteos(funcion_vector, n_raices, x_inicial, incremento_x);

            fprintf("\n\nQue metodo desea aplicar?\n\t1-Intervalo Medio\n\t2-Interpolacion Lineal\n ");
            condicion = input("");
            fprintf("\nQue error desea que tengan las raices?: ");
            errbus = input("");
            
            switch condicion
                case 1 
                    Metodos.intervaloMedio(funcion_vector, intervalos, errbus);
                case 2
                    Metodos.interpolacionLin(funcion_vector, intervalos, errbus);
                otherwise
                    fprintf('\nSelect a valid option!');
            end
            
            fprintf("\n\n");
        end
        
        
        
        %%
        %
        %
        % Ejercicio numero 2
        % Inputs: 
        % funcion_vector: vector de la funcion polinomica. = [-0.0013, 0.3, 8, -372]
        % rango_ejes: rango de los ejes cartesianos. = [ ]
        % intervalo: intervalo que se analizara. = [24,26] y [250,252]
        %
        % >> guia3.ejer2([-0.0013, 0.3, 8, -372], [24, 26], [-50, 50])
        %
        function ejer2(funcion_vector, intervalo, rango_ejes)
            import pkg.Metodos.*;

            % Graficamos la funcion 
            Metodos.plotFunction(funcion_vector, rango_ejes);
            
            fprintf ("\n* * * CONDICIONES DE FOURIER PARA ANALIZAR LA CONVERGENCIA EN EL METODO DE NEWTON-RAPHSON * * *:\n");
            % Pasamos la funcion y el intervalo para comprobar las
            % condiciones de convergencia del metodo de Newton-Raphson,
            % segun las condiciones de Fourier.
            fprintf ("\n\nIntervalo que se analizara: (%i, %i)", intervalo(1) ,intervalo(2));
            extremo1 = Metodos.convergenciaNR(funcion_vector, intervalo);
            if extremo1 ~= 0
                fprintf ("\nEs posible garantizar la obtencion de la raiz en el extremo %i del intervalo (%i, %i)",extremo1,intervalo(1),intervalo(2));
            end

            fprintf("\n\n");
        end
        
    end
end

