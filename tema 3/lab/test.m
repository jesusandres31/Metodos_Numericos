classdef test
    methods (Static)
            
            %%
            %
            %
            % Recibe como parametros un vector, los distintos intervalos
            % (en un array) y el error absoluto que se desea tener 
            % en el resultado.
            %
            % test.newtonRaph([-0.0013, 0.3, 8, -372], [24, 26, 250, 252], 0.001, [-280, 280])
            %
            function newtonRaph(funcion_vector, intervalos, errbus, rango_ejes) 
                import pkg.Metodos.*;
                
                % Obtenemos la derivada de la funcion en forma de vector.
                derivada_vector = polyder(funcion_vector);
                
                % Graficamos la funcion 
                Metodos.plotFunction(funcion_vector, rango_ejes);
                
                % Convertimos el vector en funcion. 
                funcion = poly2sym(funcion_vector);
                % Convertimos la funcion en string.
                strFunc = string(funcion);
                fprintf ("\n* * * METODO DE NEWTON-RAPHSON * * *:\n\nF(x) = %s\n",strFunc);
                
                % Index
                i = 1;
                cant_inter = length(intervalos) + 1;
                
                while i < cant_inter
                    fprintf ("\n* * * CONDICIONES DE FOURIER PARA ANALIZAR LA CONVERGENCIA EN EL METODO DE NEWTON-RAPHSON * * *:\n");
                    
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
                    fprintf ("\n\nIntervalo que se analizara: (%i, %i)\n", extremoMenor, extremoMayor);
                    
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
                        
                        fprintf ("\n\nBusqueda de la raiz en el intervalo (%i, %i)\n",extremoMenor, extremoMayor);
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
                                fprintf("\n%f\t%f\t[%f,%f]\t%f\n",tangen,valorFunc,extremoMenor, extremoMayor,err);
                            else
                                
                                % Si ya no cumple las condiciones de
                                % Fourier calculamos el error una ultima
                                % vez.
                                err = abs(err - tangen);  
                            end           
                        end
                        
                        fprintf ("\n\n\tRaiz en el intervalo (%i, %i) con un error de %f = %f\n",intervalos(i), intervalos(i+1),errbus, tangen);
                        % Pasamos al siguiente intervalo.
                        i = i+2;
                    else
                        
                        % Pasamos al siguiente intervalo.
                        i = i+2;
                    end
                    
                    % Fin del bucle while.
                end
                
                fprintf("\n");
            end
            
    end
end


