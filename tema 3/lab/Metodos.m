classdef Metodos
    methods (Static) 
        

        %%
        %
        % Plot a function from a vector and an interval of axis range.
        %
        function plotFunction(funcion_vector, ran)
            funcion = poly2sym(funcion_vector);
            strFunc = string(funcion);
            
            % plot the function
            fplot(funcion);
            xlim([ran(1) ran(2)])
            ylim([ran(1) ran(2)])
            title(strFunc);
            hold off
            grid on
            xlabel('x');
            ylabel('y');
            ax = gca;
            ax.XAxisLocation = 'origin';
            ax.YAxisLocation = 'origin';
        end
                
        
        
        %%
        %
        % Metodo de Tanteos.
        %
        % Parametros: 
        % funcion_vector: vector de la funcion polinomica.
        % n_raices: numero de raices de la funcion previamente obtenidos
        % con la regla de Rene Descartes. 
        % x_inicial: X0 o X inicial. 
        % incremento_x: incremento de X.
        %
        % intervalos = Metodos.tanteos([-pi, 9*pi, 0, -90], 3, -20, 1)
        %
        function [intervalos] = tanteos(funcion_vector, n_raices, x_inicial, incremento_x)   
        
            % Crea un polinimoio con el vector recibido por parametro. 
            x = x_inicial;
            vx = incremento_x;
            i = 1;
            intervalos = [];

            % Define la cantidad de lugares que se deberan disponer en el array
            % "intervalos" para contener a todos los intervalos con raices.
            long_interv = (n_raices * 2);
            
            strFunc = string(poly2sym(funcion_vector));
            fprintf("\n\t* * * METODO DE TANTEO * * *\n\nRaices halladas en F(x) = %s",strFunc);

                % Mientras haya lugar en el array se vuelve a iterar.
                while i < long_interv    

                    % Se evalua la funcion en el punto x, punto de comienzo
                    % ingresado por el usuario como tambien la funcion.
                    valorFunc = polyval(funcion_vector,x);    
                    
                    % Evalua si se produce un cambio de signo al ir reemplazando 
                    % la funcion con distintos valores, guardando antes el valor
                    % anterior de x en una posicion del array.
                    if valorFunc > 0 
                        while valorFunc > 0 
                            intervalos(1,i) = x;
                            x = x + vx;
                            valorFunc = polyval(funcion_vector,x);
                        end        
                    else
                        if valorFunc < 0 
                            while valorFunc < 0
                                intervalos(1,i) = x;
                                x = x + vx;
                                valorFunc = polyval(funcion_vector,x);
                            end
                        else
                            intervalos(1,i) = x;
                        end
                    end   
                    
                    % Luego guarda el valor posterior de donde se produjo el cambio
                    % de signo en la funcion para determinar el intervalo.
                    i = i + 1;
                    intervalos(1,i) = x;    
                    fprintf("\n\t\t*(%.2f, %.2f)",intervalos(1,i-1),intervalos(1,i));
                    
                    % Pasamos a buscar el siguiente intervalo.
                    i = i + 1;
                end

            fprintf("\n");
        end
        
        
        
        %%
        %
        % Metodo del Intervalo Medio.
        %
        % Parametros:
        % funcion_vector: vector de la funcion polinomica.
        % intervalos: donde se encuentran las raices.
        % errbus: error buscado.
        % rango_ejes: rango de los ejes cartesianos.
        %
        % Metodos.intervaloMedio([2*pi, 90*pi, 0, -45000], [10, 15], 0.001)
        %
        function intervaloMedio(funcion_vector, intervalos, errbus, rango_ejes) 
            
            % Graficamos la funcion 
            Metodos.plotFunction(funcion_vector, rango_ejes);
            
            % obtiene la cantidad de elementos del array intervalos
            % brindado por el usuario.
            cant_inter = length(intervalos);
            i = 1;

            strFunc = string(poly2sym(funcion_vector));
            fprintf ("\n* * * METODO DE INTERVALO MEDIO * * *\n\nF(x) = %s",strFunc);

            while i < cant_inter
                
                % Se obtiene del array intervalos el extremo inferior de
                % uno de ellos.
                extremoMenor = intervalos(1,i); 
                
                % Se obtiene del array intervalos el extremo superior de
                % uno de ellos.
                extremoMayor = intervalos(1,i+1);
                
                fprintf ("\n\nBusqueda de la raiz en el intervalo (%i, %i)\n",extremoMenor,extremoMayor);
                
                % se calculan las cantidad de iteraciones necesarias con la
                % formula del Error en el metodo del intervalo medio.
                iterac_err = (log(extremoMayor - extremoMenor) - log(errbus))/log(2);
                fprintf ("\nSon necesarias %1.f iteraciones para calcular la raiz con un error menor a %f\n", iterac_err, errbus);
                
                % Se aplica la formula de intervalo medio.
                medio = (extremoMenor + extremoMayor)/2; 
                
                % Se evalua la funcion en el punto obtenido con el metodo.
                valorFunc = polyval(funcion_vector,medio); 
                
                % Se calcula el error.
                err = abs(extremoMayor - extremoMenor);
                
                fprintf("\n    X\t\t   F(X)\t\t   Intervalo\t\tError");
                fprintf("\n%f\t%f\t[%f,%f]\t-------",medio,valorFunc,extremoMenor,extremoMayor);
                
                iteraciones = 1;
                
                % Dependiendo del error absoluto que tenga x, si este es menor 
                % al error proporcionado por el usuario termina el bucle. 
                while err > errbus 
                    if valorFunc ~= 0
                        iteraciones = iteraciones + 1;
                        
                        % Dependiendo del signo del producto entre el extremo inferior
                        % y el valor obtenido se descarta ese mismo extremo, o el mayor.
                        % De esta forma la condicion funciona si la funcion es crecinete o 
                        % decreciente indistintamente.
                        if polyval(funcion_vector,extremoMenor) * valorFunc < 0 
                            extremoMayor = medio;
                        else
                            extremoMenor = medio;                            
                        end     
                    end
                    
                    % Seteamos err con el valor actual de medio para luego
                    % calcular el nuevo error con el nuevo medio.
                    err = medio;
                    medio = (extremoMayor + extremoMenor)/2;
                    err = abs(err - medio);
                    valorFunc = polyval(funcion_vector,medio);
                    if valorFunc ~= 0
                        fprintf("\n%f\t%f\t[%f,%f]\t%f",medio,valorFunc,extremoMenor,extremoMayor,err);     
                    end          
                end
                
               fprintf("\n\n\t*Raiz en el intervalo (%i, %i) con un error de %f= %f",intervalos(i),intervalos(i+1),errbus,medio);
               fprintf("\n\nEl metodo realiza %i iteraciones\n\n",iteraciones);
               
               % Pasamos al siguiente intervalo.
               i = i + 2;
            end
            
            fprintf("\n");
        end

        
        
        %%
        %
        % Metodo de Interpolacion Lineal.
        %
        % Parametros:
        % funcion_vector: vector de la funcion polinomica.
        % intervalos: donde se encuentran las raices.
        % errbus: error buscado.
        % rango_ejes: rango de los ejes cartesianos.
        %
        % Metodos.interpolacionLin([2*pi, 90*pi, 0, -45000], [10, 15], 0.001, [-50, 50])
        %
        function interpolacionLin(funcion_vector, intervalos, errbus, rango_ejes) 
        	
            % Graficamos la funcion 
            Metodos.plotFunction(funcion_vector, rango_ejes);
            
            % obtiene la cantidad de elementos del array intervalos
            % brindado por el usuario.
            cant_inter = length(intervalos);
            i = 1;
            
            strFunc = string(poly2sym(funcion_vector));
            fprintf ("\n* * * METODO DE INTERPOLACION LINEAL * * *:\n\nF(x) = %s",strFunc);

            while i < cant_inter
                
                % Se obtiene del array intervalos el extremo inferior de
                % uno de ellos.
                extremoMenor = intervalos(1,i); 
                
                % Se obtiene del array intervalos el extremo superior de
                % uno de ellos.
                extremoMayor = intervalos(1,i+1); 
                
                % Se obtiene el valor de la funcion en el extremo inferior.
                funcionMenor = polyval(funcion_vector,extremoMenor); 
                
                % Se obtiene el valor de la funcion en el extremo superior.
                funcionMayor = polyval(funcion_vector,extremoMayor); 
                
                % Se aplica la formula de interpolacion lineal. Y así
                % obtener el nuevo Xn mas proximo a la raiz.
                raiz_recta = ((extremoMenor * funcionMayor)-(extremoMayor * funcionMenor))/(funcionMayor-funcionMenor); 
                
                % Se evalua la funcion en el punto obtenido con el metodo.
                valorFunc = polyval(funcion_vector,raiz_recta); 
                
                % Se calcula el error.
                err = abs(extremoMayor - extremoMenor);

                fprintf ("\n\nBusqueda de la raiz en el intervalo (%i, %i)\n",extremoMenor,extremoMayor);
                fprintf("\n    X\t\t   F(X)\t\t   Intervalo\t\tError");
                fprintf("\n%f\t%f\t[%f,%f]\t-------",raiz_recta,valorFunc,extremoMenor,extremoMayor);      
                
                % Dependiendo del error absoluto que tenga x, si este es menor
                % al error proporcionado por el usuario, termina el bucle.
                while err > errbus 
                     if valorFunc ~= 0
                         
                        % Dependiendo del signo del producto entre el extremo 
                        % inferior y el valor obtenido se descarta ese
                        % mismo extremo, o el mayor.
                        if polyval(funcion_vector,extremoMenor) * valorFunc < 0 
                            extremoMayor = raiz_recta;
                            funcionMayor = polyval(funcion_vector,extremoMayor);
                        else
                            extremoMenor = raiz_recta;
                            funcionMenor = polyval(funcion_vector,extremoMenor);                             
                        end     
                     end
                     
                     % Seteamos err con el valor actual del Xn o Raiz para luego
                     % calcular el nuevo error con el nuevo valor de Xn.
                     err = raiz_recta;
                     raiz_recta = ((extremoMenor * funcionMayor)-(extremoMayor * funcionMenor))/(funcionMayor-funcionMenor);
                     err = abs(err - raiz_recta);
                     valorFunc = polyval(funcion_vector, raiz_recta);
                     if valorFunc ~= 0
                        fprintf("\n%f\t%f\t[%f,%f]\t%f",raiz_recta,valorFunc,extremoMenor,extremoMayor,err);
                     end               
                end
                
                fprintf ("\n\n\t*Raiz en el intervalo (%i, %i) con un error de %f= %f\n",intervalos(i),intervalos(i+1),errbus,raiz_recta);
                i = i+2;
            end
            
            fprintf("\n");
        end
        
        
        
        %%
        %
        % Analisis de convergencia en el metodo de Newton-Raphson
        % (Condiciones de Fourier).
        %
        % Parametros:
        % funcion: vector de la funcion polinomica.
        % extremos: de los intervalos donde se encuentran las raices.
        %
        function [extremo] = convergenciaNR(funcion, extremos)
            
            % Condicion F(a)*F(b) < 0
            if (polyval((funcion), extremos(1)) * polyval((funcion), extremos(2)) >= 0)
                fprintf ("\nNo es posible garantizar la obtencion de la raiz porque no se cumple la condicion de convergencia que F(a)*F(b) < 0 en el intervalo (%i, %i)", extremos(1) ,extremos(2));
                    extremo = 0;
            end
            
            % Condicion F'(X) ~= 0
            if (polyval(polyder(funcion), extremos(1)) == 0) || (polyval(polyder(funcion),extremos(2)) == 0)
                fprintf ("\nNo es posible garantizar la obtencion de la raiz porque no se cumple la condicion de convergencia que F'(X) ~= 0 para todo valor del intervalo (%i, %i)", extremos(1) ,extremos(2));
                    extremo = 0;
            end  
                
            % Condicion F(X0) * F''(X0) > 0
            segDerivada = polyder(polyder(funcion));
            if polyval(funcion,extremos(1)) * polyval(segDerivada,extremos(1)) <= 0
                if polyval(funcion,extremos(2)) * polyval(segDerivada,extremos(2)) <= 0
                    fprintf ("\n\nNo es posible garantizar la obtencion de la raiz porque no se cumple la condicion de convergencia que F(X0) * F''(X0) > 0 en los extremos del intervalo (%i, %i)", extremos(1) ,extremos(2));
                        extremo = 0;
                else
                    extremo = 2; 
                end
            else
                extremo = 1;
            end
            
            fprintf("\n");
        end
        
        
        
        %%
        %
        % Metodo de Newton-Raphson.
        %
        % Parametros:
        % funcion_vector: vector de la funcion polinomica.
        % intervalos: donde se encuentran las raices.
        % errbus: error buscado.
        % rango_ejes: rango de los ejes cartesianos.
        %
        % Metodos.newtonRaph([-0.0013, 0.3, 8, -372], [24, 26, 250, 252], 0.001, [-280, 280])
        % Metodos.newtonRaph([2*pi, 90*pi, 0, -45000], [10, 15], 0.001, [-50, 50])
        %
        function newtonRaph(funcion_vector, intervalos, errbus, rango_ejes)
              
            % Graficamos la funcion 
            Metodos.plotFunction(funcion_vector, rango_ejes);
               
            % Obtenemos la derivada de la funcion en forma de vector.
            derivada_vector = polyder(funcion_vector);

            % Convertimos el vector en funcion. 
            funcion = poly2sym(funcion_vector);
            % Convertimos la funcion en string.
            strFunc = string(funcion);
            fprintf ("\n* * * METODO DE NEWTON-RAPHSON * * *:\n\nF(x) = %s\n",strFunc);
            fprintf("------------------------------------------------------------------------------");
            
            % Index
            i = 1;
            cant_inter = length(intervalos) + 1;
             
            while i < cant_inter
                fprintf ("\n\n\n* * * CONDICIONES DE FOURIER PARA ANALIZAR LA CONVERGENCIA EN EL METODO DE NEWTON-RAPHSON * * *:");
                   
                % Se obtiene del array intervalos el extremo inferior
                % de uno de ellos.
                extremoMenor = intervalos(1,i); 
                % Se obtiene del array intervalos el extremo superior
                % de uno de ellos.
                extremoMayor = intervalos(1,i+1);
                    
                % Pasamos la funcion y el intervalo para comprobar las
                % condiciones de convergencia del metodo de Newton-Raphson,
                % segun las condiciones de Fourier.
                % Nos devuelve el extremo que cumpla las condiciones.
                extremo = Metodos.convergenciaNR(funcion_vector, [extremoMenor, extremoMayor]);
                fprintf ("\nIntervalo que se analizara: (%i, %i)\n", extremoMenor, extremoMayor);
                    
                % Si existe un extremo que cumpla con las condiciones
                % de Fourier, pasamos a aplicar el metodo de
                % Newton-Raphson en ese punto.
                if extremo ~= 0
                    fprintf ("\nEs posible garantizar la obtencion de la raiz en el extremo %i del intervalo (%i, %i)\n", extremo, extremoMenor, extremoMayor);
                        
                    % Dependiendo de si se cumplen en el extremo 
                    % inferior o superior (1 inferior, 2 superior)...

                    % Para extremo inferior.
                    if extremo == 1 
                           
                        fprintf("\n\t1)F(%.2f)*F(%.2f) < 0\n\t2)F'(x) ~= 0\n\t3)F(%.2f)*F''(%.2f) > 0 \n",extremoMenor,extremoMayor,extremoMenor,extremoMenor);
                        % Evaluamos la funcion.
                        valorFunc = polyval(funcion_vector, extremoMenor); 
                        % Evaluamos la derivada de la funcion.
                        valorDeriv = polyval(derivada_vector, extremoMenor);
                        % Obtenemos el valor de la tangente.
                        tangen = extremoMenor - (valorFunc/valorDeriv);
                            
                    % Para extremo superior.
                    else
                            
                        fprintf("\n\t1)F(%.2f)*F(%.2f) < 0\n\t2)F'(x) ~= 0\n\t3)F(%.2f)*F''(%.2f) > 0 \n",extremoMayor,extremoMenor,extremoMayor,extremoMayor);
                        % Evaluamos la funcion.
                        valorFunc = polyval(funcion_vector, extremoMayor);
                        % Evaluamos la derivada de la funcion.
                        valorDeriv = polyval(derivada_vector, extremoMayor);
                        % Obtenemos el valor de la tangente.
                        tangen = extremoMayor - (valorFunc/valorDeriv);
                            
                    end
                        
                    % Evaluamos la funcion para conocer el valor
                    % aproximado de la raíz.
                    valorFunc = polyval(funcion_vector,tangen); 
                    % Calculamos el error.
                    err = abs(extremoMayor - extremoMenor);
                       
                    fprintf ("\n\n\nBusqueda de la raiz en el intervalo (%i, %i)\n",extremoMenor, extremoMayor);
                    % Imprimimos.
                    fprintf("\n    X\t\t   F(X)\t\t   Intervalo\t\t\tError");
                    fprintf("\n%f\t%f\t[%f,%f]\t-------", tangen, valorFunc, extremoMenor, extremoMayor);      
                        
                    while err > errbus
                            
                        % Seteamos err con el valor actual de la tangente.
                        err = tangen; 
                            
                        if valorFunc ~= 0
                            % Dependiendo del signo del producto entre
                            % el extremo inferior y el valor obtenido
                            % se descarta ese mismo extremo, o el mayor
                            if polyval(funcion_vector,extremoMenor) * valorFunc < 0 
                                extremoMayor = tangen;
                            else
                                extremoMenor = tangen;
                            end 
                                
                            % Volvemos a calcular las condiciones de
                            % Fourier pero con los nuevos extremos.
                            extremo = Metodos.convergenciaNR(funcion_vector, [extremoMenor, extremoMayor]);
                                
                            % Para extremo inferior.
                            if extremo == 1
                               valorFunc = polyval(funcion_vector,extremoMenor);
                               valorDeriv = polyval(derivada_vector,extremoMenor);
                               tangen = extremoMenor - (valorFunc/valorDeriv);
                                  
                            % Para extremo superior.
                            else
                               valorFunc = polyval(funcion_vector,extremoMayor);
                               valorDeriv = polyval(derivada_vector,extremoMayor);
                               tangen = extremoMayor - (valorFunc/valorDeriv);
                            end 
                                 
                            % Evaluamos la funcion para conocer el
                            % nuevo valor aproximado de la raíz.
                            valorFunc = polyval(funcion_vector,tangen); 
                            % Calculamos el nuevo error.
                            err = abs(err - tangen); 
                            % Imprimimos.
                            fprintf("\n%f\t%f\t[%f,%f]\t%f",tangen,valorFunc,extremoMenor, extremoMayor,err);
                        else
                                
                            % Si ya no cumple las condiciones de
                            % Fourier calculamos el error una ultima
                            % vez.
                            err = abs(err - tangen);  
                        end           
                    end
                        
                    fprintf("\n\n\n\tRaiz en el intervalo (%i, %i) con un error de %f = %f\n\n",intervalos(i), intervalos(i+1),errbus, tangen);
                    fprintf("------------------------------------------------------------------------------");
                    % Pasamos al siguiente intervalo.
                    i = i+2;
                else
                      
                    % Pasamos al siguiente intervalo.
                    i = i+2;
                end
                  
                % Fin del bucle while.
            end
                
            fprintf("\n\n");
        end
        
        
        
        %%
        %
        % Plot a function and its iterations till we find the roots,
        % from a function_handle and an interval of axis range.
        %
        function plotIterations(func_g, ran)
            str = func2str(func_g);
            strFunc = erase(str,"@(x)");
            
            fplot(func_g);
            xlim([ran(1) ran(2)])
            ylim([ran(1) ran(2)])
            title(strFunc);
            hold on
            grid on
            xlabel('x');
            ylabel('y');
            fplot(@(x)x);
            ax = gca;
            ax.XAxisLocation = 'origin';
            ax.YAxisLocation = 'origin';
        end
        
        
        
        %%
        %
        % Metodo de Iteracion del Punto Fijo y Aceleracion de Aitken.
        %
        % Parametros: 
        % x_inicial: X0 o X inicial. 
        % errbus: error buscado.
        % rango_ejes: rango de los ejes cartesianos.
        % funcion: funcion a iterar en forma de 'function_handle' 
        % (Symbolic), ej : @(x) cos(x)
        %
        % Warning: Function behaves unexpectedly on array inputs...properly vectorize your function
        % Answer: 
        % Link 1) https://www.mathworks.com/matlabcentral/answers/446689-fixing-a-plot-with-error-message-function-behaves-unexpectedly-on-array-inputs-properly-vectoriz
        % You will need to change all of the matrix operators for array operators, e.g:
        % * to .*
        % ^ to .^
        % / to ./
        % etc.
        % Link 2) https://www.mathworks.com/help/matlab/matlab_prog/array-vs-matrix-operations.html
        % Link 3) https://www.mathworks.com/help/matlab/matlab_prog/vectorization.html
        %
        % Metodos.iteracionPtoFijo(0, 0.001, [0, 1], @(x) cos(x))
        % Metodos.iteracionPtoFijo(200, 0.0001, [198, 215], @(x) 40.*log(400./(500-x))+200)
        % Metodos.iteracionPtoFijo(1, 0.0001, [-5, 5], @(x) (2.*x+2).^(1./3))
        %
        function iteracionPtoFijo(x_inicial, errbus, rango_ejes, funcion)
            
            str = func2str(funcion);
            strFunc = erase(str,"@(x)");
            fprintf("\n\t* * * METODO DE INTERACION DEL PUNTO FIJO * * *\n\n\tF(x) = %s\n",strFunc);
            
            %# You function here: g = @(x) cos(x);
            g = funcion;
            
            %# Start out iteration loop. x1 = x and x2 = y.
            x1 = x_inicial;
            x2 = g(x1);

            %# iteration counter.
            iterations = 0;

            % Graficamos las iteraciones.
            Metodos.plotIterations(g, rango_ejes);
            
            fprintf("\nDesea aplicar la aceleracion de Aitken? [S/N]: ");
            answer = input("","s");
                
            if (answer == 's' || answer == 'S') 
                band = true;
                fprintf("\nMetodo de Iteracion aplicando Aceleracion de Aitken:\n");
            else
                fprintf("\nMetodo de Iteracion:\n");
                band = false;
            end
            
            % Contador en caso de aplicar aceleracion de Aitken.
            cont = 1;
            
            fprintf("\n\tX\t\t\tF(X)\t\t\tError");
            
            while (abs(x2-x1) > errbus && iterations<100)
                plot([x1 x1], [x1 x2], 'k-')
                plot([x1 x2], [x2 x2], 'k--')
                %pause    
                
                % Antes de seguir mostramos los valores actuales.
                fprintf("\n%f\t\t%f\t\t%f",x1,x2,abs(x2-x1))
                
                if band && cont > 3
                    % Calculamos una mas. Xn+1
                    x3 = g(x2);
                    
                    % Antes de seguir mostramos los valores actuales.
                    fprintf("\n%f\t\t%f\t\t%f",x2,x3,abs(x3-x2))
                    
                    % Aplicamos la aceleracion de Aitken.
                    ait = x3 - (((x3-x2)^2)/(x3-2*x2+x1));
                    
                    % Seteamos los nuevos valores de X e Y
                    x1 = ait;
                    x2 = g(x1);
                    
                    % Que no vuelva a entrar al loop hasta que calcule dos
                    % aproximaciones mas.
                    cont = 1;
                    
                    iterations = iterations + 1;
                else
                    % Seteamos los nuevos valores de X e Y
                    x1 = x2;
                    x2 = g(x1);
                end
                
                % Sumamos 1 a iterations y a cont.
                cont = cont + 1;
                iterations = iterations + 1;
            end
            
            fprintf("\n\nCantidad de iteraciones: %i: \n\n", iterations);
            fprintf("\n");
        end
        
        
        
        %%
        % 
        % Verificar cual g(X) es mas ventajosa para aplicar el metodo de 
        % Iteracion del Punto.
        %
        % Parametros:
        % funciones_vector: vector de las funciones polinomica en forma de string.
        % x0: numero real que se va a usar para evaluar la derivada de las funciones.
        %
        % Here we are using Symbolic expressions.
        % (Polynomial differentiation = polyder)
        % (Symbolic differentiation = diff)
        %
        % Metodos.gXmasVentajosa(["(2*x+2)^(1/3)", "(2+(2/x))^(1/2)", "((2/x)+(2/(x^2)))"], 1)
        %   
        function gXmasVentajosa(funciones_vector, x0)
            
            % Index.
            cant = length(funciones_vector);
            
            % Vector de resultados de pendientes.
            m = [];
            
            fprintf("\nFunciones y sus derivadas:\n");
            
            % Iteramos para cada funcion.
            for i=1: 1: cant
                
                func_i = funciones_vector(i);
                
                % Trabajamos con expresion simbolica.
                % Convertimos el string en funcion.
                syms x;
                funcion = str2sym(func_i);
                
                % Obtenemos la derivada.
                derivada = diff(funcion,x);
                
                fprintf("\n\t%i) g(x) = %s\t\t=>\t\tg'(x) = %s", i, func_i, derivada);
                
                % Evaluamos la funcion en x0.
                expr = subs(derivada,x,x0);
                
                % Convertimos a float.
                pend = vpa(expr);
               
                % Cargamos en el vector de resultados.
                m = [m, pend];
            end
            
            % Seteamos el valor minimo del vector de resultados.
            min_m = find(m == min(m));
            func_ventaj = funciones_vector(min_m);
            
            fprintf("\n\n\tg(x) = %s es la funcion mas ventajosa para encontrar la raiz \n", func_ventaj);
            fprintf("\tpor el metodo de Iteracion del Punto Fijo porque es la de derivada \n");
            fprintf("\tcon menor pendiente en x = %.2f \n", x0);
           
            fprintf("\n\n");
        end
        
        
        
        %%
        %
        %
    end     
end



