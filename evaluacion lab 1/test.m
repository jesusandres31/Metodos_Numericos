classdef test
    methods (Static)
        
        function ejer
            import pkg.Metodos.*;
            
            % Se ingresa la funcion como vector para luego convertirla en
            % polinomio.
            
          %  funcion_vector = Metodos.ingresoPlnm();
            
             % Graficamos la funcion 
           % Metodos.plotFunction([-pi, 9*pi, 0, -90]);
            
     %       P = input ("\nIngrese un termino del polinomio: "); 
      %      L = [P];
            
            
            %
            
            %P = input ("\nIngrese un termino del polinomio: ");
        
            %L = length(P);
            %funcion_vector = zeros(1, L);
            %funcion_vector = P;
            
        end
        
        
        
        
        %%
        %
        %
        % Ingresa una funcion por teclado
        function [funcion_vector] = ingresoPlnm
            
            % Se crea el vector para almacenar el polinomio.
            funcion_vector = [];
           
            % Ingreso por teclado del polinomio a ser usado.
            res = 's';
            while (res == 's') || (res == 'S')
                n = input ("\nIngrese un termino del polinomio: ");
                funcion_vector = [funcion_vector, n];
                res = input ("\nDesea ingresar otro termino? [S/N]: ","s");
            end

            % mostramos el vector
            fprintf("\nEl vector ingresado es: "); 
            disp(funcion_vector);
            fprintf("\n\n");
            
            funcion_vector = funcion_vector;
        end
        
        
        
        
        
         % Ejercicio numero 1
        function ejer1
            import pkg.Metodos.*;

            % Se ingresa la funcion como vector para luego convertirla en
            % polinomio.
            % funcion_vector = [-pi, 9*pi, 0, -90];
            % Comentado porque ahora ingresamos por teclado
            
            % Definimos el rango de los ejes cartesianos
            rango = [-10 10];
            
            % Graficamos la funcion 
            Metodos.plotFunction(funcion_vector, rango);
            
            % Numero de raices obtenidos por el metodo de Rene Descartes
            n_raices = 3;

            % X0 o X inicial
            x_inicial = -20;
            
            % incremento de X
            incremento_x = 1;
            
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
        
            
    end
end
    

