classdef guia5   
    methods (Static)
%%
%
%
%%%%%%%%%% Interpolación y Ajuste.
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
            
            % Contador de la cantidad de filas de la ultima columna
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
        % Metodo de Newton-Gregory Ascendente y Descendente
        % para intervalos regularmente espaciados.
        %
        % p_matriz: matriz de dos columnas con los de valores X e Y.
        % p_x: valor de X de la tabla que se desea interpolar.
        % p_asc: booleano que determina si se aplica el metodo Ascendente.
        %
        % ejer1 a
        % guia5.newtonGregory([15,0.965962;25,0.9063080;35,0.819752;45,0.707107;55,0.573576;65,0.422618], 17, true)
        %
        % ejer1 b
        % guia5.newtonGregory([15,0.965962;25,0.9063080;35,0.819752;45,0.707107;55,0.573576;65,0.422618], 60, false)
        %
        % ejer2
        % guia5.newtonGregory([0.25,0.003;0.75,0.049;1.25,0.7;1.75,1.88;2.25,6], 1.8, false)
        %
        % ejer3 a
        % guia5.newtonGregory([0,0;pi/4,2^(-1/2);pi/2,1;3*pi/4,2^(-1/2);pi,0], 0.75, true)
        %
        % ejer5 b
        % guia5.newtonGregory([0.5,0.479426;0.6,0.564642;0.7,0.644218;0.8,0.717356;0.9,0.783327;1.0,0.841471], 0.534, true)
        %
        % ejer7
        % guia5.newtonGregory([0,1.792;5,1.519;10,1.308;15,1.140], 8, true)
        %
        % ejer7
        % guia5.newtonGregory([0,1.792;5,1.519;10,1.308;15,1.140], 8, false)
        %
        function newtonGregory(p_matriz, p_x, p_asc)

            % Se obtiene la tabla de diferencias avanzadas.
            tablaCompleta = guia5.tablaDiferenciasAv(p_matriz);
            
            % Obtebemos el numero de filas y de columnas de la tabla.
            [numRows, numCols] = size(tablaCompleta);
            
            % Obtiene el valor de h que es igual a la distancia entre dos
            % puntos contiguos de X en la tabla.
            h = p_matriz(2,1) - p_matriz(1,1);
            
            % Dependiendo de si la bandera p_asc sea verdadera o falsa se 
            % tomaran los valores de la primer fila o de las ultimas.
            if p_asc 
                fprintf("\n\tMetodo de Interpolacion Newton Ascendente: \n\n");
                fila = 1;
            else
                fprintf("\n\tMetodo de Interpolacion Newton Descendente: \n\n");
                fila = numRows;
            end  
            
            % Obtiene el valor de U = (X - Xo) / h
            u = (p_x - p_matriz(fila,1))/h;
            % Asignamos a resultadoX el primer termino de la formula.
            resultadoX = tablaCompleta(fila,2);
            
            % Contador que determina cual valor constante se debe restar a 
            % u segun corresponda en la formula.
            cont = 0;
            % Empezamos a imprimir la ecuacion.
            fprintf("\tP(%f) = %f + ",p_x,resultadoX);
            
            for i=3 :1 :numCols
                if ~p_asc 
                    % Si p_asc es falso significa que se aplica el metodo 
                    % descendente, entonces la ultima fila cambia en cada
                    % iteracion
                    fila = fila - 1;
                end    
                
                % En cada iteracion se usa un acumulador para hallar los  
                % terminos restantes de la formula
                acum = (tablaCompleta(fila,i) * u)/ factorial(cont+1);

                % Imprimimos cada termino de la ecuación.
                fprintf("(%f*%f",tablaCompleta(fila,i),u);
                
                for j=1 :1 :cont
                    % Dependiendo del termino (despues del 2do) se 
                    % multiplica a cada termino la resta o suma 
                    % (dependiendo del valor de p_asc) entre u y la 
                    % constante que corresponde segun la formula.
                    if p_asc 
                        acum = acum * (u-j);
                        fprintf("*(%f-(%i))",u,j);
                    else
                        acum = acum * (u+j);
                        fprintf("*(%f+(%i))",u,j);
                    end 
                end
                fprintf("/%i!)",cont+1);
                if (i ~= numCols) 
                    fprintf(" + ");
                end
                
                % mod: operador de modulo.
                % (para ir salteando de renglon).
                if (mod(i,2)==0) 
                    fprintf("\n\t");
                end
                cont = cont + 1;
                
                % Se suma al resultado el ultimo termino hallado.
                resultadoX = resultadoX + acum;
                acum = 0;
            end
            fprintf("\n\n\tCon un valor de X: %f\n",p_x);
            fprintf("\tSe obtiene un valor de Y: %f\n",resultadoX);
            fprintf("\n");
        end

        

        %%
        %
        %
        % Encuentra el intervalo.
        % para hallar un valor de X dado un valor de Y.
        %
        % p_matriz: matriz de dos columnas con los de valores X e Y.
        % p_y: valor de Y de la tabla que se desea interpolar.
        % Devuelve el intervalo donde se encuentra esa Y.
        %
        function [extremoMayor] = findInterval(p_matriz, p_y)
            
            % Obtenemos la columna de valores de Y.
            col = [p_matriz(:,2)];
            
            % Convertimos la columna en array.
            row = col.';
         
            % Dependiendo de si le vector de valores de Y está ordenado o
            % no (de menor a mayor)...
            if (issorted(row))
                extremoMayor = find(row <= p_y, 1, 'last');
            else
                extremoMayor = find(row >= p_y, 1, 'last');
            end  
            
            % 2.5
            
            % y = [1 2 3 4 5 6]
            
            % y = [6 5 4 3 2 1]
        end
        
        

        %%
        %
        %
        % Interpolacion Lineal Inversa.
        % para hallar un valor de X dado un valor de Y.
        %
        % p_matriz: matriz de dos columnas con los de valores X e Y.
        % p_y: valor de Y de la tabla que se desea interpolar.
        %
        % ejer1 c
        % guia5.interpolLinInv([15,0.965962;25,0.9063080;35,0.819752;45,0.707107;55,0.573576;65,0.422618], 0.907285)
        %
        % ejer5 d
        % guia5.interpolLinInv([0.5,0.479426;0.6,0.564642;0.7,0.644218;0.8,0.717356;0.9,0.783327;1.0,0.841471], 1/2)
        %
        function interpolLinInv(p_matriz, p_y)
            
            % Se obtiene la tabla de diferencias avanzadas.
            tablaCompleta = guia5.tablaDiferenciasAv(p_matriz);
            
            fprintf("\n\tInterpolacion Lineal Inversa: \n\n");
            
            % Obtiene el valor de h que es igual a la distancia entre dos
            % puntos contiguos de X en la tabla.
            h = tablaCompleta(2,1) - tablaCompleta(1,1);
            
            % Obtenemos el indice del intervalo de la tabla correspondiente 
            % a utilizar.
            i = guia5.findInterval(p_matriz, p_y);
            
            % Seteamos los valores de las variables acuerdo al indice.
            x0 = tablaCompleta(i,1);
            y0 = tablaCompleta(i,2);
            dy0 = tablaCompleta(i,3);
            
            % Aplicamos la formula.
            % solve: func de matlab para hallar las raices de una ecuación.
            syms x;
            res = solve( p_y == y0 + ((dy0/h) * (x - x0)) );
            
            % Imprimimos la formula.
            fprintf("\t%f = %f + ((%f/%f) * (x - %f)", p_y, y0, dy0, h, x0);
            
            fprintf ("\n\n\tCon un valor de Y: %f\n", p_y);
            fprintf ("\tSe obtiene un valor de X: %f\n", res);
            fprintf("\n");
        end
        
        
        
        %%
        %
        %
        % Interpolacion Cuadratica Inversa.
        %
        % p_matriz: matriz de dos columnas con los de valores X e Y.
        % p_y: valor de Y de la tabla que se desea interpolar.
        %
        % ejer1 c
        % guia5.interpolCuadInv([15,0.965962;25,0.9063080;35,0.819752;45,0.707107;55,0.573576;65,0.422618], 0.907285)
        %
        % ejer5 d
        % guia5.interpolCuadInv([0.5,0.479426;0.6,0.564642;0.7,0.644218;0.8,0.717356;0.9,0.783327;1.0,0.841471], 1/2)
        %
        function interpolCuadInv(p_matriz, p_y)
            
            % Se obtiene la tabla de diferencias avanzadas.
            tablaCompleta = guia5.tablaDiferenciasAv(p_matriz);
            
            fprintf("\n\tInterpolacion Cuadratica Inversa: \n\n");

            % Obtiene el valor de h que es igual a la distancia entre dos
            % puntos contiguos de X en la tabla.
            h = tablaCompleta(2,1) - tablaCompleta(1,1);
       
            % Obtenemos el indice del intervalo de la tabla correspondiente 
            % a utilizar.
            i = guia5.findInterval(p_matriz ,p_y);
            
            % Seteamos los valores de las variables acuerdo al indice.
            x0 = tablaCompleta(i,1);
            x1 = tablaCompleta(i+1,1);
            y0 = tablaCompleta(i,2);
            d1y0 = tablaCompleta(i,3);
            d2y0 = tablaCompleta(i,4);
           
            % Aplicamos la formula.
            % solve: func de matlab para hallar las raices de una ecuación.
            syms x;
            res = solve( p_y == (y0) + ((d1y0/h) * (x - x0)) + ((d2y0/(factorial(2)*h^2)) * (x - x0) * (x - x1)) );
            
            % Imprimimos la formula.
            fprintf("\t%f = (%f) + ((%f/%f) * (x - %f)) + ((%f/(2!*%f^2)) * (x - %f) * (x - %f))\n", p_y, y0, d1y0, h, x0, d2y0, h, x0, x1);
            
            % Obtebemos el numero de filas y de columnas.
            [numRows, numCols] = size(tablaCompleta);
            cantidadX = numRows;
           
            fprintf ("\n\n\tCon un valor de Y: %f\n",p_y);
            
            % Muestra como resultado aquella raiz que se encuentre dentro 
            % del intervalo.
            if (res(1,1) <= p_matriz(cantidadX,1)) && (res(1,1) >= p_matriz(1,1)) 
                fprintf ("\n\tSe obtiene un valor de X: %f\n",res(1,1));
            else
                fprintf ("\n\tSe obtiene un valor de X: %f\n",res(2,1));
            end  
            fprintf("\n");
        end
        
        

        %%
        %
        %
        % Formula de Lagrange.
        % para intervalos irregularmente espaciados.
        %
        % p_matriz: matriz de dos columnas con los de valores X e Y.
        % p_x: valor de X de la tabla que se desea interpolar.
        %
        % ejer4 a
        % guia5.lagrange([0,1;0.4,1.63246;0.75,1.86603;1.5,2.22474;2,2.41421], 1)
        %
        % ejer4 b
        % guia5.lagrange([0,1;0.4,1.63246;0.75,1.86603;1.5,2.22474;2,2.41421], 0.45)
        % 
        % ejer5 a
        % guia5.lagrange([0.5,0.479426;0.6,0.564642;0.7,0.644218;0.8,0.717356;0.9,0.783327;1.0,0.841471], 0.534)
        %
        % ejer6
        % guia5.lagrange([102,0.564642;245,0.644218;327,0.717356;423,0.783327;565,0.853329], 275)
        %
        function lagrange(p_matriz, p_x)
            
            % Obtebemos el numero de filas y de columnas.
            [numRows, numCols] = size(p_matriz);
            
            fprintf("\n\tMetodo de Lagrange: \n\n");
            
            resultadoY = 0;
            denominador = 1;
            
            % Empezamos a imprimir la ecuacion.
            fprintf("\tP(%f) = ", p_x);
            denomText = "(";
            
            for i=1 :1 :numRows
                % En acum se obtiene cada termino de la formula de Lagrange,
                % primero asignando el valor de Yi a este.
                acum = p_matriz(i,2);
                fprintf("%f/(", p_matriz(i,2));
                
                for j=1 :1 :numRows
                    diferencia = 0;    
                    
                    % Dependiendo la fila y columna se este analizando, si 
                    % estas tienen subindices iguales diferencia es igual 
                    % al parametro ingresado por el usuario menos el Xi 
                    % correspondiente a ese termino, de lo contrario 
                    % diferencia es igual a Xi (depende del termino) menos  
                    % el valor X que se está posicionado.
                    if (j == i) 
                        diferencia = p_x - p_matriz(i,1);
                        fprintf("(%.2f - (%.2f))", p_x, p_matriz(i,1));
                    else
                        diferencia = p_matriz(i,1) - p_matriz(j,1);
                        fprintf("(%.2f - (%.2f))", p_matriz(i,1), p_matriz(j,1));
                    end
                    
                    % Se divide el valor de yn por cada diferencia que se 
                    % obtiene (la cantidad de diferencia depende de cuantos 
                    % valores de x tiene la matriz ingresada por el usuario)
                    acum = acum / diferencia;
                end
                if (i ~= numRows) 
                    fprintf(") + ");
                end
                fprintf("\n\t");
                resultadoY = resultadoY + acum;
                
                % Denominador contiene el producto de cada resta entre el X 
                % ingresado por parametros y cada X de p_matriz.
                denomText = denomText + "(" + string(p_x) + "-" + string(p_matriz(i,1)) + ")";
                denominador = denominador * (p_x-p_matriz(i,1));
                acum = 0;
            end
            denomText = denomText + ")";
            fprintf("*%s",denomText);
            
            fprintf ("\n\n\tCon un valor de X: %f\n",p_x);
            fprintf ("\tSe obtiene un valor de Y: %f\n",resultadoY*denominador);
            fprintf("\n");
        end
    
    
        
    end
end
