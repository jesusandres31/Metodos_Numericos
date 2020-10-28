classdef test
    methods (Static)
        
        
       % Tabla de diferencias avanzadas
       %
      %   p_matriz: matriz de dos columnas con los valores x e y
      %   Retorna la tabla con las x's, y's y delta y's segun la matriz de 
      %   nx2 que se haya enviado por parametros
       %
        function [tablaY] = tablaDeDifAv(p_matriz)

            % Obtebemos el numero de filas y de columnas.
            [numRows, numCols] = size(p_matriz);
            
            tablaDeltas = p_matriz;
            
            % Cantidad de columnas de la tabla
            colTabla = 2;
            
            % Contador de la cantidad de filas de la ultima columna
            contFilas = numRows; 
            
            fprintf("\n\tTabla de Diferencias Avanzadas: \n");
            
            for i=1 :1 :numRows - 1
               
                 % Incrementa la cantidad de columnas debido a que se hallara 
                 % una nueva columna delta y
                
                colTabla = colTabla + 1;
                for j=2 :1 :contFilas
                    
                    %  Resta entre el valor de yn o delta yn por el valor de 
                    %  yn-1 o delta yn-1 de la columna anterior y lo asigna 
                    %  en una posicion de la nueva columna
                    
                    tablaDeltas(j-1,colTabla) = tablaDeltas(j,colTabla - 1) - tablaDeltas(j - 1,colTabla - 1);
                end
                
                %  Cada columna delta y que se obtiene tiene una fila menos que
                %  la anterior
                
                contFilas = contFilas - 1; 
            end
            
            fprintf("\n");
            % Mostramos la tabla de deltas Y.
            disp(tablaDeltas);
            tablaY = tablaDeltas;
        end
        
        
        
        %%
        %
        %    p_matriz: matriz de dos columnas con los valores x e y
        %    p_x: valor dentro de la tabla que se desea interpolar
        %    p_asc: valor booleano que determina si se desea aplicar Newton Ascendente
        %
        % test.newtonAscDesc([15,0.965962;25,0.9063080;35,0.819752;45,0.707107;55,0.573576;65,0.422618], 17, true)
        
        function newtonAscDesc(p_matriz , p_x, p_asc)

            %Se obtiene la tabla de deltas ys
            tablaCompleta = test.tablaDeDifAv(p_matriz);
            
            %Guardamos la cantidad de columnas que la tabla tiene
             % ncolumnas = size(tablaCompleta,'c');
             % Obtebemos el numero de filas y de columnas.
            [numRows, numCols] = size(tablaCompleta);
            
            %  Obtiene el valor de h que es igual a la distancia entre los puntos 
            %  contiguos de x en la tabla
            
            h = p_matriz(2,1) - p_matriz(1,1);
            
            %  Dependiendo de si la bandera p_asc sea verdadera o falsa se tomaran los 
            %  valores de la primer fila o de las ultimas
            
            if p_asc 
                fprintf("\n\tMetodo de Interpolacion Newton Ascendente: \n\n");
                fila = 1;
            else
                fprintf("\n\tMetodo de Interpolacion Newton Descendente: \n\n");
                [numRows, numCols] = size(tablaCompleta);
                fila = numRows;
            end  
            
            %  Obtiene el valor de u que es igual al cociente entre la resta del valor 
            %  ingresado por parametros menos x0 o xn (dependiendo del valor de p_asc) 
            %  en la tabla y h
            
            u = (p_x - p_matriz(fila,1))/h;
            %Asignamos a resultadoX el primer termino de la formula
            resultadoX = tablaCompleta(fila,2);
            
            %  Se utiliza el contador para determinar por cual valor constante se debe 
            %  restar a u segun corresponda en la formula
            
            cont = 0;
            fprintf("\tP(%f) = %f + ",p_x,resultadoX);
            for i=3 :1 :numCols
                if ~p_asc 
                    
                    %  Si p_asc es falso esto quiere decir que se aplica Newton 
                    %  descendente, entonces la ultima fila cambia en cada iteracion
                    
                    fila = fila - 1;
                end    
                
                %  En cada iteracion se usa un acumulador para hallar los terminos 
                %  restantes de la formula
                
                acum = (tablaCompleta(fila,i) * u)/ factorial(cont+1);
                fprintf("(%f*%f",tablaCompleta(fila,i),u);
                for j=1 :1 :cont
                    
                    %  Dependiendo del termino (despues del 2do) se multiplica a cada 
                    %  termino la resta o suma (dependiendo del valor de p_asc) entre u 
                    %  y la constante que corresponde segun la formula
                    
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
                if (mod(i,2)==0) 
                    fprintf("\n\t");
                end
                cont = cont + 1;
                
                %Se suma al resultado el ultimo termino hallado
                resultadoX = resultadoX + acum;
                acum = 0;
            end
            fprintf("\n\n\tCon un valor de X: %f\n",p_x);
            fprintf("\tSe obtiene un valor de Y: %f\n",resultadoX);
            fprintf("\n");
        end

        
        
        %%
        %
        % test.interpolLinInv([15,0.965962;25,0.9063080;35,0.819752;45,0.707107;55,0.573576;65,0.422618], 0.907285)
        %
        function interpolLinInv(p_matriz ,p_y)
            tablaCompleta = test.tablaDeDifAv(p_matriz);
            fprintf("\n\tInterpolacion Lineal Inversa: \n\n");
            h = tablaCompleta(2,1) - tablaCompleta(1,1);
            
            i = test.findInterval(p_matriz ,p_y);
            
            % Seteamos los valores de acuerdo al indice.
            x0 = tablaCompleta(i,1);
            y0 = tablaCompleta(i,2);
            dy0 = tablaCompleta(i,3);
            
           % res = ((p_y - y0)/dy0)*h + x0;
             
            syms x;
            res = solve( p_y == y0 + ((dy0/h) * (x - x0)) );

            % fprintf("\tX = ((%f - (%f))/%f)*%f + (%f)", p_y, y0, dy0, h, x0);
            fprintf("\t%f = %f + ((%f/%f) * (x - %f)", p_y, y0, dy0, h, x0);
            fprintf ("\n\n\tCon un valor de Y: %f\n", p_y);
            fprintf ("\tSe obtiene un valor de X: %f\n", res);
            fprintf("\n");
        end
        
        %%
        %
        %
        function [extremoMayor] = findInterval(p_matriz ,p_y)
            % obtenemos la columna de valores de Y.
            col = [p_matriz(:,2)];
            % Convertimos la columna en array.
            row = col.';
            % obtenemos el indice.
            extremoMayor = find(row > p_y, 1, 'last');
        end
        

        %%
        %
        %
        % test.interpolCuadInv([15,0.965962;25,0.9063080;35,0.819752;45,0.707107;55,0.573576;65,0.422618], 0.907285)
        %
        function interpolCuadInv(p_matriz ,p_y)
            tablaCompleta = test.tablaDeDifAv(p_matriz);
            fprintf("\n\tInterpolacion Cuadratica Inversa: \n\n");
            h = tablaCompleta(2,1) - tablaCompleta(1,1);
       
            % i and i+1
            i = test.findInterval(p_matriz ,p_y);
            
            x0 = tablaCompleta(i+1,1);
            x1 = tablaCompleta(i+2,1);
            y0 = tablaCompleta(i+1,2);
            d1y0 = tablaCompleta(i+1,3);
            d2y0 = tablaCompleta(i+1,4);
           
           
           % x0 = tablaCompleta(i+1,1)
           % x1 = tablaCompleta(i+2,1)
           % y0 = tablaCompleta(i+1,2)
           % d1y0 = tablaCompleta(i+1,3)
           % d2y0 = tablaCompleta(i+1,4)
           
           % resultadoX2 = d2y0/(factorial(2)*(h^2));
           % resultadoX1 = d1y0/h - x1*d2y0/(2*h^2) - x0*d2y0/(2*h^2);
           % resultadoX0 = y0 - x0*d1y0/h + x0*x1*d2y0/(2*h^2) - p_y;

            syms x;
            res = solve( p_y == (y0) + ((d1y0/h) * (x - x0)) + ((d2y0/(factorial(2)*h^2)) * (x - x0) * (x - x1)) );
            
            fprintf("\t%f = (%f) + ((%f/%f) * (x - %f)) + ((%f/(2!*%f^2)) * (x - %f) * (x - %f))\n", p_y, y0, d1y0, h, x0, d2y0, h, x0, x1);
            % Se obtiene las raices del polinomio cuadratico formado
            
            % Obtebemos el numero de filas y de columnas.
            [numRows, numCols] = size(tablaCompleta);
            cantidadX = numRows;
            
           
            fprintf ("\n\n\tCon un valor de Y: %f\n",p_y);
            
            % Muestra como resultado aquella raiz que se encuentre dentro del intervalo
            if (res(1,1) <= p_matriz(cantidadX,1)) && (res(1,1) >= p_matriz(1,1)) 
                fprintf ("\n\tSe obtiene un valor de X: %f\n",res(1,1));
            else
                fprintf ("\n\tSe obtiene un valor de X: %f\n",res(2,1));
            end  
            fprintf("\n");
        end
        
        
        
        %%
        
        
        %%
        %
        %
        % test.lagrange([0,1;0.4,1.63246;0.75,1.86603;1.5,2.22474;2,2.41421], 1)
        %
        %
        function lagrange(p_matriz ,p_x)
            fprintf("\n\tMetodo de Lagrange: \n\n");
            
            % Obtebemos el numero de filas y de columnas.
            [numRows, numCols] = size(p_matriz);
            
            resultadoY = 0;
            denominador = 1;
            fprintf("\tP(%f) = ", p_x);
            denomText = "(";
            for i=1 :1 :numRows
                
                %  En acum se obtiene cada termino de la formula de Lagrange,
                %  primero asignando el valor de yn a este
                
                acum = p_matriz(i,2);
                fprintf("%f/(", p_matriz(i,2));
                for j=1:1:numRows
                    diferencia = 0;
                    
                    %  Dependiendo la fila y columna se este analizando, si estas
                    %  tienen subindices iguales diferencia es igual al parametro 
                    %  ingresado por el usuario menos el xn correspondiente a 
                    %  ese termino, de lo contrario diferencia es igual a xn 
                    %  (depende del termino) menos el valor x que se esta 
                    %  posicionado
                    
                    if (j == i) 
                        diferencia = p_x - p_matriz(i,1);
                        fprintf("(%.2f - (%.2f))", p_x, p_matriz(i,1));
                    else
                        diferencia = p_matriz(i,1) - p_matriz(j,1);
                        fprintf("(%.2f - (%.2f))", p_matriz(i,1), p_matriz(j,1));
                    end
                    
                    %  Se divide el valor de yn por cada diferencia que se 
                    %  obtiene (la cantidad de diferencia depende de cuantos 
                    %  valores de x tiene la matriz ingresada por el usuario)
                    
                    acum = acum / diferencia;
                end
                if (i ~= numRows) 
                    fprintf(") + ");
                end
                fprintf("\n\t");
                resultadoY = resultadoY + acum;
                
                %  denominador contiene el producto de cada resta entre el x 
                %  ingresado por parametros y cada x de la p_matriz
                
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
    

