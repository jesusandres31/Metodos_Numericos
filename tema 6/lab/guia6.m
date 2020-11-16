classdef guia6   
    methods (Static)
%%
%
%
%%%%%%%%%% Diferenciación e Integración.
%
        %% Ejercicios
        %
        % ejer 1
        % guia6.newtonGregoryDerivada([12,0.96262;13,0.94718;14,0.93108;15,0.92221;16,0.91181;17,0.90151], 12, true)
        % guia6.newtonGregoryDerivada([12,0.96262;13,0.94718;14,0.93108;15,0.92221;16,0.91181;17,0.90151], 12.4, true)
        % guia6.newtonGregoryDobleDerivada([12,0.96262;13,0.94718;14,0.93108;15,0.92221;16,0.91181;17,0.90151], 17, false)
        %
        % ejer 2
        % A = guia6.trapecios([0;0.1;0.2;0.3;0.4;0.5],[0.0;0.15;0.3;0.55;0.73;0.81])
        % guia6.simpsonUnTercioMasTresOctavos([0;0.1;0.2;0.3;0.4;0.5],[0.0;0.15;0.3;0.55;0.73;0.81])
        %
        % ejer 3
        % A = guia6.trapecios([12;13;14;15;16;17],[0.96262;0.94718;0.93108;0.92221;0.91181;0.90151])
        %
        % ejer 4
        % guia6.simpsonUnTercioMasTresOctavos([12;13;14;15;16;17],[0.96262;0.94718;0.93108;0.92221;0.91181;0.90151])
        %
        % ejer 5
        % A = guia6.trapecios([0;5;10;15;20;25;30;35;40],[10;22;35;47;55;58;52;40;37])
        % A = guia6.simpsonUnTercio([0;5;10;15;20;25;30;35;40],[10;22;35;47;55;58;52;40;37])
        %
        
        
        
        %%
        %
        %
        % Tabla de diferencias avanzadas
        %
        % p_matriz: matriz de dos columnas con los de valores X e Y.
        % Devuelve la tabla de diferencias avanzadas.
        %
        function [tablaY] = tablaDiferenciasAv(p_matriz)

            % Obtebemos el numero de filas y de columnas.
            [numRows, numCols] = size(p_matriz);
            
            tablaDeltas = p_matriz;
            
            % Cantidad de columnas de la tabla.
            colTabla = 2;
            
            % Contador de la cantidad de filas de la ultima columna.
            contFilas = numRows; 
            
            fprintf("\n\tTabla de Diferencias Avanzadas: \n");
            
            for i=1 :1 :numRows - 1
               
                % Incrementa la cantidad de columnas debido a que se hallara 
                % una nueva columna delta Y.
                colTabla = colTabla + 1;
                for j=2 :1 :contFilas
                    
                    % Resta entre el valor de Yi o delta Yi por el valor de 
                    % Yi-1 o delta Yi-1 de la columna anterior y lo asigna 
                    % en una posicion de la nueva columna.
                    tablaDeltas(j-1,colTabla) = tablaDeltas(j,colTabla - 1) - tablaDeltas(j - 1,colTabla - 1);
                end
                
                % Cada columna delta y que se obtiene, tiene una fila menos 
                % que la anterior.
                contFilas = contFilas - 1; 
            end
            
            fprintf("\n");
            % Mostramos la tabla de deltas Y.
            disp(tablaDeltas);
            tablaY = tablaDeltas;
        end
        
        
        
        %% 
        %
        %
        % Metodo de Newton-Gregory Derivada Ascendente y Descendente
        % para intervalos regularmente espaciados.
        %
        % p_matriz: matriz de dos columnas con los de valores X e Y.
        % p_x: valor de X de la tabla que se desea interpolar.
        % p_asc: booleano que determina si se aplica el metodo Ascendente.
        %
        % ejer 1
        % guia6.newtonGregoryDerivada([12,0.96262;13,0.94718;14,0.93108;15,0.92221;16,0.91181;17,0.90151], 12, true)
        % guia6.newtonGregoryDerivada([12,0.96262;13,0.94718;14,0.93108;15,0.92221;16,0.91181;17,0.90151], 12.4, false)
        %
        function newtonGregoryDerivada(p_matriz, p_x, p_asc)

            % Se obtiene la tabla de diferencias avanzadas.
            tablaCompleta = guia6.tablaDiferenciasAv(p_matriz);
            
            % Obtebemos el numero de filas y de columnas de la tabla.
            [numRows, numCols] = size(tablaCompleta);
            
            % Obtiene el valor de h que es igual a la distancia entre dos
            % puntos contiguos de X en la tabla.
            h = p_matriz(2,1) - p_matriz(1,1);
            
            % Dependiendo de si la bandera p_asc sea verdadera o falsa se 
            % tomaran los valores de la primer fila o de las ultimas.
            if p_asc 
                fprintf("\n\tMetodo Derivado de Interpolacion Newton Ascendente: \n\n");
                fila = 1;
            else
                fprintf("\n\tMetodo Derivado de Interpolacion Newton Descendente: \n\n");
                fila = numRows;
            end  
            
            % Obtiene el valor de U = (X - Xo) / h.
            u = (p_x - p_matriz(fila,1))/h;
            
            % Guardamos el valor de u en otra variable para remplazarlo una
            % vez que terminen de calcularse las derivadas parciales.
            valor_u = u;
            
            % Asignamos ecuacion el primer termino de la formula.
            ecuacion = tablaCompleta(fila,3);
            
            % Contador que determina cual valor constante se debe restar a 
            % u segun corresponda en la formula.
            cont = 0;
            
            for i=3 :1 :numCols
                if ~p_asc 
                    % Si p_asc es falso significa que se aplica el metodo 
                    % descendente, entonces la ultima fila cambia en cada
                    % iteracion.
                    fila = fila - 1;
                end    
                
                % En cada iteracion se usa un acumulador para hallar los  
                % terminos restantes de la formula.
                acum = (tablaCompleta(fila,i) * u)/ factorial(cont+1);
                
                for j=1 :1 :cont
                    % Dependiendo del termino (despues del 2do) se 
                    % multiplica a cada termino la resta o suma 
                    % (dependiendo del valor de p_asc) entre u y la 
                    % constante que corresponde segun la formula.
                    if p_asc 
                        acum = acum * (u-j);
                    else
                        acum = acum * (u+j);
                    end 
                end
                
                % Calculamos la derivada parcial con respecto a u.
                syms u
                acum = diff(acum, u);
             
                cont = cont + 1;
        
                % Se suma en la ecuación el ultimo termino hallado.
                ecuacion = ecuacion + acum;
                acum = 0;
            end
            
            % Imprimimos la ecación.
            fprintf("\n\tEcuacion: P'(%f) = %s", p_x, ecuacion);            
            
            % Remplazamos la variable symbolica u por el verdadero valor de
            % u, y resolvemos la ecuación.
            resolv = subs(ecuacion,u,valor_u);
            
            % Pasamos el valor de symbolico a double.
            result = double(resolv);
            
            fprintf("\n\n\tCon un valor de X: %f\n", p_x);
            fprintf("\tSe obtiene un valor de Y: %f\n", result);
            fprintf("\n");
        end

        
        
        %% 
        %
        %
        % Metodo de Newton-Gregory Doble Derivada Ascendente y Descendente
        % para intervalos regularmente espaciados.
        %
        % p_matriz: matriz de dos columnas con los de valores X e Y.
        % p_x: valor de X de la tabla que se desea interpolar.
        % p_asc: booleano que determina si se aplica el metodo Ascendente.
        %
        % ejer 1
        % guia6.newtonGregoryDobleDerivada([12,0.96262;13,0.94718;14,0.93108;15,0.92221;16,0.91181;17,0.90151], 17, false)
        %
        function newtonGregoryDobleDerivada(p_matriz, p_x, p_asc)

            % Se obtiene la tabla de diferencias avanzadas.
            tablaCompleta = guia6.tablaDiferenciasAv(p_matriz);
            
            % Obtebemos el numero de filas y de columnas de la tabla.
            [numRows, numCols] = size(tablaCompleta);
            
            % Obtiene el valor de h que es igual a la distancia entre dos
            % puntos contiguos de X en la tabla.
            h = p_matriz(2,1) - p_matriz(1,1);
            
            % Dependiendo de si la bandera p_asc sea verdadera o falsa se 
            % tomaran los valores de la primer fila o de las ultimas.
            if p_asc 
                fprintf("\n\tMetodo Doble Derivado de Interpolacion Newton Ascendente: \n\n");
                fila = 1;
            else
                fprintf("\n\tMetodo Doble Derivado de Interpolacion Newton Descendente: \n\n");
                fila = numRows;
            end  
            
            % Obtiene el valor de U = (X - Xo) / h.
            u = (p_x - p_matriz(fila,1))/h;
            
            % Guardamos el valor de u en otra variable para remplazarlo una
            % vez que terminen de calcularse las derivadas parciales.
            valor_u = u;
            
            % Asignamos ecuacion el primer termino de la formula.
            ecuacion = tablaCompleta(fila,3);
            
            % Contador que determina cual valor constante se debe restar a 
            % u segun corresponda en la formula.
            cont = 0;
            
            for i=3 :1 :numCols
                if ~p_asc 
                    % Si p_asc es falso significa que se aplica el metodo 
                    % descendente, entonces la ultima fila cambia en cada
                    % iteracion.
                    fila = fila - 1;
                end    
                
                % En cada iteracion se usa un acumulador para hallar los  
                % terminos restantes de la formula.
                acum = (tablaCompleta(fila,i) * u)/ factorial(cont+1);
                
                for j=1 :1 :cont
                    % Dependiendo del termino (despues del 2do) se 
                    % multiplica a cada termino la resta o suma 
                    % (dependiendo del valor de p_asc) entre u y la 
                    % constante que corresponde segun la formula.
                    if p_asc 
                        acum = acum * (u-j);
                    else
                        acum = acum * (u+j);
                    end 
                end
                
                % Calculamos la doble derivada parcial con respecto a u.
                syms u
                acum = diff(acum, u);
                acum = diff(acum, u);

                cont = cont + 1;
        
                % Se suma en la ecuación el ultimo termino hallado.
                ecuacion = ecuacion + acum;
                acum = 0;
            end
            
            % Imprimimos la ecación.
            fprintf("\n\tEcuacion: P''(%f) = %s", p_x, ecuacion);            
            
            % Remplazamos la variable symbolica u por el verdadero valor de
            % u, y resolvemos la ecuación.
            resolv = subs(ecuacion,u,valor_u);
            
            % Pasamos el valor de symbolico a double.
            result = double(resolv);
            
            fprintf("\n\n\tCon un valor de X: %f\n", p_x);
            fprintf("\tSe obtiene un valor de Y: %f\n", result);
            fprintf("\n");
        end
        
        
        
        %%
        %
        %
        % Metodo de los Trapecios
        %
        %
        % ejer 2
        % guia6.trapecios([0;0.1;0.2;0.3;0.4;0.5],[0.0;0.15;0.3;0.55;0.73;0.81])
        %
        % ejer 3
        % guia6.trapecios([12;13;14;15;16;17],[0.96262;0.94718;0.93108;0.92221;0.91181;0.90151])
        %
        % ejer 5
        % guia6.trapecios([0;5;10;15;20;25;30;35;40],[10;22;35;47;55;58;52;40;37])
        %
        function [resultado] = trapecios(vectorX, vectorY)

            fprintf("\n\n\tMetodo de Trapecios: \n\n");
            
            % Obtebemos el numero de filas y de columnas de la tabla.
            [cantidadY, numCols] = size(vectorY);

            if cantidadY < 2 
                fprintf ("\tNo existe area debajo de tan solo un punto.");
                resultado = 0;
            else
                % Se obtiene el valor de h = x1 - x0.
                valorH = vectorX(2,1) - vectorX(1,1);
                % Se obtiene el valor de E, que es sumar los ys de los
                % extremos.
                valorE = vectorY(1,1) + vectorY(cantidadY,1);
                valorP = 0;
                valorI = 0;
                fprintf("\tE = %.4f + %.4f = %.4f\n\n", vectorY(1,1), vectorY(cantidadY,1), valorE);
                fprintf("\tI = ");
                
                % Para obtener el valor de I (impares) se suma cada valor  
                % de Y cuyo subindice sea impar (en este caso seran pares  
                % porque el indice de los arreglos en Matlab comienzan en
                % 1).
                for i=2 :2 :cantidadY-1
                    valorI = valorI + vectorY(i,1);
                    fprintf ("%.4f ",vectorY(i,1));
                    if ((i + 2) < cantidadY-1)
                        fprintf ("+ ");
                    end
                end
                
                fprintf ("= %.4f\n\n",valorI);
                fprintf("\tP = ");
                
                % Para obtener el valor de I (impares) se suma cada valor  
                % de Y cuyo subindice sea par.
                for i=3 :2 :cantidadY-1
                    valorP = valorP + vectorY(i,1);
                    fprintf ("%.4f ",vectorY(i,1));
                    if ((i + 2) < cantidadY-1)
                        fprintf ("+ ");
                    end
                end
                
                fprintf ("= %.4f\n\n",valorP);
                
                % Finalmente se halla el resultado al aplicar la formula 
                % de Trapecios.
                resultado = (valorE + 2*valorI + 2*valorP)*(valorH/2);
                fprintf ("\tArea = (%.4f/2)*(%.4f + 2*%.4f + 2*%.4f) = %f\n",valorH,valorE,valorI,valorP,resultado);
            end
        end


        
        %%
        %
        %
        % Metodo de Simpson 1/3
        %
        %
        % ejer 2_b
        % A2 = guia6.simpsonUnTercio([0.3;0.4;0.5],[0.55;0.73;0.81])
        % ejer 2_c
        % A = A1 + A2
        %
        % ejer 4_b
        % A2 = guia6.simpsonUnTercio([15;16;17],[0.92221;0.91181;0.90151])
        % ejer 4_c
        % A = A1 + A2
        %
        % ejer 5
        % guia6.simpsonUnTercio([0;5;10;15;20;25;30;35;40],[10;22;35;47;55;58;52;40;37])
        %
        function [resultado] = simpsonUnTercio(vectorX, vectorY)

            fprintf("\n\n\tMetodo de Simpson 1/3: \n\n");
            
            % Obtebemos el numero de filas y de columnas de la tabla.
            [cantidadY, numCols] = size(vectorY);
       
            if cantidadY < 2
                fprintf ("\tNo existe un area debajo de tan solo un punto!");
                resultado = 0;
            else
                if mod(cantidadY,2) == 0
                    fprintf ("\tNo es posible aplicar Simpson porque la cantidad de intervalos ingresados es par!");
                    resultado = 0;
                else
                    % Se obtiene el valor de h = x1 - x0.
                    valorH = vectorX(2,1) - vectorX(1,1);
                    % Se obtiene el valor de E, que es sumar los Ys de los 
                    % extremos.
                    valorE = vectorY(1,1) + vectorY(cantidadY,1);
                    valorP = 0;
                    valorI = 0;
                    fprintf("\tE = %.4f + %.4f = %.4f\n\n", vectorY(1,1), vectorY(cantidadY,1), valorE);
                    fprintf("\tI = ");
                    
                    % Para obtener el valor de I (impares) se suma cada
                    % valor de Y cuyo subindice sea impar (en este caso 
                    % seran pares porque el indice de los arreglos en 
                    % Matlab comienzan en 1).
                    for i=2 :2 :cantidadY-1
                        valorI = valorI + vectorY(i,1);
                        fprintf ("%.4f ",vectorY(i,1));
                        if ((i + 2) < cantidadY-1)
                            fprintf ("+ ");
                        end
                    end
                    
                    fprintf ("= %.4f\n\n",valorI);
                    fprintf("\tP = ");
                    
                    % Para obtener el valor de I (impares) se suma cada 
                    % valor de Y cuyo subindice sea par.
                    for i=3 :2 :cantidadY-1
                        valorP = valorP + vectorY(i,1);
                        fprintf ("%.4f ",vectorY(i,1));
                        if ((i + 2) < cantidadY-1)
                            fprintf ("+ ");
                        end
                    end
                    
                    fprintf ("= %.4f\n\n",valorP);
                    
                    % Finalmente se halla el resultado al aplicar la 
                    % formula de Simpson 1/3.
                    resultado = (valorE + 4*valorI + 2*valorP)*(valorH/3);
                    fprintf ("\tArea = (%.4f/3)*(%.4f + 4*%.4f + 2*%.4f) = %f\n",valorH,valorE,valorI,valorP,resultado);
                end
            end
        end

        
        
        %%
        %
        %
        % Metodo de Simpson 3/8
        %
        %
        % ejer 2_a
        % A1 = guia6.simpsonTresOctavos([0;0.1;0.2;0.3],[0.0;0.15;0.3;0.55])
        %
        % ejer 4_a
        % A1 = guia6.simpsonTresOctavos([12;13;14;15],[0.96262;0.94718;0.93108;0.92221])
        %
        function [resultado] = simpsonTresOctavos(vectorX, vectorY)
 
            fprintf("\n\n\tMetodo de Simpson 3/8: \n\n");

            % Obtebemos el numero de filas y de columnas de la tabla.
            [numRow, numCols] = size(vectorY);
            
            if numRow ~= 4 
                fprintf ("\tEs necesario que se ingresen solo 4 puntos!");
                resultado = 0;
            else
                
                %Se obtiene el valor de h = x1 - x0.
                valorH = vectorX(2,1) - vectorX(1,1);
                
                for i=1 :1 :numRow
                    fprintf("\tY%i = %.4f\n\n",i-1,vectorY(i,1));
                end
                
                % Finalmente se halla el resultado al aplicar la formula de 
                % Simpson 3/8.
                resultado = (valorH*3/8) * (vectorY(1,1) + 3*vectorY(2,1) + 3*vectorY(3,1) + vectorY(4,1));
                
                fprintf("\tArea = (%.4f*3/8)*(%.4f + 3*%.4f + 3*%.4f + %.4f) = %f\n",valorH,vectorY(1,1),vectorY(2,1),vectorY(3,1),vectorY(4,1),resultado);
            end
        end

        
        
        %%
        %
        %
        % Metodo de Simpson 1/3 y 3/8
        %
        %
        % guia6.simpsonUnTercioMasTresOctavos([0;0.1;0.2;0.3;0.4;0.5],[0.0;0.15;0.3;0.55;0.73;0.81])
        %
        % guia6.simpsonUnTercioMasTresOctavos([12;13;14;15;16;17],[0.96262;0.94718;0.93108;0.92221;0.91181;0.90151])
        %
        function simpsonUnTercioMasTresOctavos(vectorX, vectorY)
                    
            % Recortamos los vectores de X y Y correspondientes al metodo
            % de Simpson de 3/8.
            new_vectX1 = vectorX(1:4);
            new_vectY1 = vectorY(1:4);
            
            % Recortamos los vectores de X y Y correspondientes al metodo
            % de Simpson de 1/3.
            new_vectX2 = vectorX(4:6);
            new_vectY2 = vectorY(4:6);
        
            % Llamamos a las funciones y almacenamos los valores en A1 y A2.
            A1 = guia6.simpsonTresOctavos(new_vectX1, new_vectY1);    
            A2 = guia6.simpsonUnTercio(new_vectX2, new_vectY2);
            
            % Sumamos las dos areas.
            A = A1 + A2;
            
            fprintf("\n\n\tMetodo de Simpson Combinado 1/3 y 3/8: \n");
            fprintf("\n\tEl area A1 es: %f\n", A1);
            fprintf("\n\tEl area A2 es: %f\n", A2);
            fprintf("\n\tEl area total A es: %f\n", A)
            fprintf("\n\n");
        end

        
        
    end
end
