classdef guia6   
    methods (Static)
%%
%
%
%%%%%%%%%% Diferenciación e Integración.
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
                
                % Calculamos la doble derivada parcial con respecto a u.
                syms u
                acum = diff(acum, u);
                acum = diff(acum);
                
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
        
        
        
    end
end
