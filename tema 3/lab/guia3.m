classdef guia3   
    methods (Static)
        
        %%
        %
        %
        % Ejercicio numero 1
        % Metodo de Tanteos.
        % Metodo del Intervalo Medio.
        % Metodo de Interpolacion Lineal.
        %
        % Parametros: 
        % funcion_vector: vector de la funcion polinomica.
        % n_raices: numero de raices de la funcion previamente obtenidos
        % con la regla de Rene Descartes. 
        % x_inicial: X0 o X inicial. 
        % incremento_x: incremento de X.
        % errbus: error buscado.
        % rango_ejes: rango de los ejes cartesianos.
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

            fprintf("\n\nQue metodo desea aplicar?\n\t1-Intervalo Medio\n\t2-Interpolacion Lineal\n\t3-Newton-Raphson\n ");
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
        % Metodo de Newton-Raphson.
        %
        % Parametros:
        % funcion_vector: vector de la funcion polinomica.
        % intervalos: donde se encuentran las raices.
        % errbus: error buscado.
        % rango_ejes: rango de los ejes cartesianos.
        %
        % guia3.ejer2([-0.0013, 0.3, 8, -372], [24, 26, 250, 252], 0.001, [-280, 280])
        % guia3.ejer2([2*pi, 90*pi, 0, -45000], [10, 15], 0.001, [-50, 50])
        %
        function ejer2(funcion_vector, intervalos, errbus, rango_ejes)
            import pkg.Metodos.*;
            
            Metodos.newtonRaph(funcion_vector, intervalos, errbus, rango_ejes);
        end
        
        
        
        %%
        %
        %
        % Ejercicio numero 3
        % Metodo de Interpolacion Lineal.
        %
        % Parametros:
        % funcion_vector: vector de la funcion polinomica.
        % intervalos: donde se encuentran las raices.
        % errbus: error buscado.
        % rango_ejes: rango de los ejes cartesianos.
        %
        % guia3.ejer3([2*pi, 90*pi, 0, -45000], [10, 15], 0.001, [-50, 50])
        %
        function ejer3(funcion_vector, intervalos, errbus, rango_ejes)
            import pkg.Metodos.*;
            
            Metodos.interpolacionLin(funcion_vector, intervalos, errbus, rango_ejes);
        end
        
        
        
        %%
        %
        %
        % Ejercicio numero 4
        % Metodo de Iteracion del Punto Fijo y Aceleracion de Aitken.
        %
        % Parametros: 
        % x_inicial: X0 o X inicial. 
        % errbus: error buscado.
        % rango_ejes: rango de los ejes cartesianos.
        % funcion: funcion a iterar en forma de 'function_handle' 
        % (Symbolic), ej : @(x) cos(x)
        %
        % guia3.ejer4(0, 0.001, [0, 1], @(x) cos(x))
        % guia3.ejer4(200, 0.0001, [198, 215], @(x) 40.*log(400./(500-x))+200)
        % guia3.ejer4(1, 0.0001, [-5, 5], @(x) (2.*x+2).^(1./3))
        %
        function ejer4(x_inicial, errbus, rango_ejes, funcion)
            import pkg.Metodos.*;
            
            Metodos.iteracionPtoFijo(x_inicial, errbus, rango_ejes, funcion);
        end
        
        
        
        %%
        %
        %
        % Ejercicio numero 5
        % Verificar cual g(X) es mas ventajosa para aplicar el metodo de 
        % Iteracion del Punto.
        %
        % Here we are using Symbolic expressions.
        % (Polynomial differentiation = polyder)
        % (Symbolic differentiation = diff)
        %
        % guia3.ejer5(["(2*x+2)^(1/3)", "(2+(2/x))^(1/2)", "((2/x)+(2/(x^2)))"], 1)
        %
        function ejer5(funciones_vector, x0)
            import pkg.Metodos.*;
            
            Metodos.gXmasVentajosa(funciones_vector, x0);
        end
        
        
        
        %%
        %
        %
    end
end

