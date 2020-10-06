classdef Metodos
    methods (Static) 
        

        %%
        %
        %
        % Plot a function from a vector and an interval
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
        %
        % Recibe como parametros un vector, la cantidad de raices de la misma,
        % el primer valor por el que se desea realizar el tanteo y el incremento
        % que va a tomar el procedimiento, y devuelve un array con los intervalos
        % que tienen raices de la funcion.
        function [intervalos] = tanteos(funcion_vector,n_raices,x_inicial,incrX)   
        
            % Crea un polinimoio con el vector recibido por parametro. 
            x = x_inicial;
            vx = incrX;
            i = 1;
            intervalos = [];

            % Define la cantidad de lugares que se deberan disponer en el array
            % "intervalos" para contener a todos los intervalos con raices 
            % (el array en Matlab tiene como primer indice el 1, no el 0).
            %
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
        %
        % Recibe como parametros un vector, los distintos intervalos (en un array)
        % y el error absoluto que se desea tener en el resultado.
        function intervaloMedio(funcion_vector, intervalos, errbus) 
            
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
               fprintf("\nEl metodo realiza %i iteraciones\n\n",iteraciones);
               
               % Pasamos al siguiente intervalo.
               i = i + 2;
            end
            
            fprintf("\n");
        end

        
        
        %%
        %
        %
        % Recibe como parametros un vector, los distintos intervalos (en un array)
        % y el error absoluto que se desea tener en el resultado.
        function interpolacionLin(funcion_vector, intervalos, errbus) 
        	
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
        %
        % Analiza las condiciones de convergencia para el metodo de Newton-Raphson.
        % Recibe la funcion y los distintos intervalos de raices (en un array).
        function [extremo] = convergenciaNR(funcion, intervalo)
            
            % Condicion F(a)*F(b) < 0
            if (polyval((funcion), intervalo(1)) * polyval((funcion), intervalo(2)) >= 0)
                fprintf ("\nNo es posible garantizar la obtencion de la raiz porque no se cumple la condicion de convergencia que F(a)*F(b) < 0 en el intervalo (%i, %i)", intervalo(1) ,intervalo(2));
                    extremo = 0;
            end
            
            % Condicion F'(X) ~= 0
            if (polyval(polyder(funcion), intervalo(1)) == 0) || (polyval(polyder(funcion),intervalo(2)) == 0)
                fprintf ("\nNo es posible garantizar la obtencion de la raiz porque no se cumple la condicion de convergencia que F'(X) ~= 0 para todo valor del intervalo (%i, %i)", intervalo(1) ,intervalo(2));
                    extremo = 0;
            end  
                
            % Condicion F(X0) * F''(X0) > 0
            segDerivada = polyder(polyder(funcion));
            if polyval(funcion,intervalo(1)) * polyval(segDerivada,intervalo(1)) <= 0
                if polyval(funcion,intervalo(2)) * polyval(segDerivada,intervalo(2)) <= 0
                    fprintf ("\n\nNo es posible garantizar la obtencion de la raiz porque no se cumple la condicion de convergencia que F(X0) * F''(X0) > 0 en los extremos del intervalo (%i, %i)", intervalo(1) ,intervalo(2));
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
        %
    end     
end



