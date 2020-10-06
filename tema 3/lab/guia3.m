classdef guia3   
    methods (Static)
        
        %%
        %
        %
        % Ejercicio numero 1
        % Inputs: 
        % funcion_vector: vector de la funcion polinomica.
        % n_raices: numero de raices de la funcion previamente obtenidos por el
        % metodo de Rene Descartes. 
        % x_inicial: X0 o X inicial. 
        % incremento_x: incremento de X.
        % errbus: error buscado.
        % rango_ejes: rango de los ejes cartesianos
        %
        % guia3.ejer1([-pi, 9*pi, 0, -90], 3, -20, 1, 0.001, [-10, 10])
        % guia3.ejer1([-0.0013, 0.3, 8, -372], 3, -50, 1, 0.001, [-280, 280])
        % guia3.ejer1([2*pi, 90*pi, 0, -45000], 3, -45, 1, 0.001, [-50, 50])
        % 
        function ejer1(funcion_vector, n_raices, x_inicial, incremento_x, errbus, rango_ejes) 
            import pkg.Metodos.*;
            
            % Ingresamos la funcion, y los de mas parametros para encontrar
            % los intervalos donde hay reices.
            intervalos = Metodos.tanteos(funcion_vector, n_raices, x_inicial, incremento_x);

            fprintf("\n\nQue metodo desea aplicar?\n\t1-Intervalo Medio\n\t2-Interpolacion Lineal\n\t3-Interpolacion Lineal\n ");
            condicion = input("");
            switch condicion
                case 1 
                    Metodos.intervaloMedio(funcion_vector, intervalos, errbus, rango_ejes);
                case 2
                    Metodos.interpolacionLin(funcion_vector, intervalos, errbus, rango_ejes);
                case 3
                    Metodos.newtonRaph(funcion_vector, intervalos, errbus, rango_ejes);
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
        % funcion_vector: vector de la funcion polinomica. 
        % rango_ejes: rango de los ejes cartesianos. 
        % errbus: error buscado.
        % intervalo: intervalo que se analizara.
        %
        % guia3.ejer2([-0.0013, 0.3, 8, -372], [24, 26, 250, 252], 0.001, [-280, 280])
        % guia3.ejer2([2*pi, 90*pi, 0, -45000], [10, 15], 0.001, [-50, 50])
        %
        function ejer2(funcion_vector, intervalos, errbus, rango_ejes)
            import pkg.Metodos.*;
                            
           
            Metodos.newtonRaph(funcion_vector, intervalos, errbus, rango_ejes);

            fprintf("\n\n");
        end

        
        
        %%
        %
        %
    end
end

