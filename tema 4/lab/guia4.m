classdef guia4   
    methods (Static)
        
        %%
        %
        %
        % Sistemas No Homogeneos.
        % Metodo de Eliminacion de Gauss
        % p_matriz: matriz conrrespondiente al sistema de ecuaciones.
        %
        % guia4.eliminacionDeGauss([80,15,35,60,230;28,72,57,25,180;20,20,12,20,80;50,10,20,60,160])
        % guia4.eliminacionDeGauss([4.3,3,2,960;1,3,1,510;2,1,3,610])
        %
        function eliminacionDeGauss(p_matriz)
            fprintf("\n\t* * * Metodo de Eliminacion de Gauss * * *");
            fprintf("\n\nMatriz:\n\n");
            disp(p_matriz);
            
            % Obtebemos el numero de filas y de columnas.
            [numRows, numCols] = size(p_matriz);
            
            % Triangulamos la matriz.
            p_matriz = guia4.triangularMatriz(p_matriz);
            
            fprintf("\nSoluciones por sustitucion regresiva: \n\n");
            
            % Creamos variable para mostrar los resultados de las distintos
            % Xs del sistema a medida que los calculamos.
            fila_souluc = zeros(1,numRows);
            
            for i=numRows :-1 :1
                % Seteamos el X a calcular.
                fila_souluc(1,i)= p_matriz(i,numCols);

                for j=numRows :-1 :i
                    if (i==j) 
                        % En el caso que se encuentre con un elemento de la
                        % digonal principal divide el valor acumulado en 
                        % fila_souluc(dependiendo de la variable que se 
                        % este analizando) por el coeficiente asociado a la 
                        % variable que se desea hallar (valores en p_matriz).
                        fila_souluc(1,i)=fila_souluc(1,i)/p_matriz(i,i);   
                    else
                        % En el caso que no sea un elemento de la diagonal 
                        % principal se le resta al valor acumulado en 
                        % fila_souluc por el producto del elemento que se
                        % esta posicionado de la p_matriz de coeficientes 
                        % (definido por i y j) y se lo multiplica por la
                        % variable correspondiente a ese valor.
                        fila_souluc(1,i)=fila_souluc(1,i)- (p_matriz(i,j)*fila_souluc(1,j));
                    end
                end 
                
                % Mostramos el valor del X calculado.  
                fprintf("\tx%i = %f\n",i,fila_souluc(i));     
            end
            fprintf("\n\n")
        end
        
        
        
        %%
        %
        %
        % Triangulacion de matriz
        % Recibe como patrametro la matriz a triangular y devuelve la
        % matriz triangulada.
        %
        function [matriz_result] = triangularMatriz(p_matriz)
            fprintf("\nSe inicia la triangulacion:\n\n");
            disp(p_matriz);
            
            % Obtebemos el numero de filas y de columnas.
            [numRows, numCols] = size(p_matriz);
            
            % Creamos una matriz de las mismas dimensiones que la recibida
            % como parametro pero pero compuesta por ceros.
            matriz_zeros = zeros(numRows,numCols);
            
            for i=1 :1 :numRows - 1
                % Asigna a "fila", la fila que contiene el elemento pivote
                % de la matriz.
                fila = p_matriz(i,:);
                
                for k=numCols :-1 :i
                    % Divide cada elemento de la fila por el pivote.
                    fila(1,k) = fila(1,k)/fila(1,i);
                end
                
                for j=i :1 :numRows - 1
                    % Multiplica la fila alterada por la columna donde esta
                    % el pivote y lo almacena en la matriz de ceros.
                    matriz_zeros(j+1,:) = fila * p_matriz(j+1,i);
                end
                
                % Se resta la original con la generada en el paso anterior.
                p_matriz = p_matriz - matriz_zeros;
                
                % Mostramos el resultado pasajero.
                disp(p_matriz);
                
                % Vueleve a poner a 0 la matriz de ceros.
                matriz_zeros(:,:) = 0;
            end
           
            % Devolvemos la matriz triangulada.
            matriz_result = p_matriz;
        end
         
        
        
        %%
        %
        %
        % Sistemas Homogeneos.
        % Metodo de Faddeev-Leverrier
        % Recibe como parametro la matriz cuadrada A del sistema de
        % ecuaciones y devuelve el polinomio caracteristico asociado a esa
        % matriz.
        %
        % guia4.faddeevLeverrier([3,2,1;1,-2,3;2,0,4])
        % guia4.faddeevLeverrier([2,-0.5,0;-0.5,1,-0.5;0,-0.5,2/3])
        %
        function faddeevLeverrier(p_matriz)
            
            % Obtebemos el numero de filas y de columnas.
            [numRows, numCols] = size(p_matriz);
            
            % Seteamos la matriz A y la matriz B.
            m_a = p_matriz;
            m_b = p_matriz;
            
            % Creamos variable para almacenar el polinomio caracteristico.
            vector_traza = [];
            
            fprintf("\n\t* * * Metodo de Fadeev-Leverrier * * *\n\n");
            % Se asigna a m_i la matriz identidad con las dimensiones de la
            % matriz de entrada.
            m_i = eye(numRows, numCols);
            
            % Creamos la variable traza.
            traza = 0;
            
            % Mostramos la matriz inicial.
            fprintf("A = \n");
            disp(m_a);
            
            for i=1: 1: numRows        
                
                if (i ~= 1)
                    % Bn+1 = A * (Bn - bn * I)
                    m_a = m_b * (m_a - (traza * m_i));
                    % Receteamos la traza para futuros calculos.
                    traza = 0;
                end
                
                % Mostramos la matriz Bn.
                fprintf("\nB%i = \n",i);
                disp(m_a);
                
               % for j=1: 1: numRows
                   % Asigna a traza la suma de la diagonal.
               %    traza = traza + m_a(j,j);    
               % end
               
               % trace: funcion de matlab que calcula la traza.
               traza = trace(m_a);
                
                % Finalizamos el calculo de la traza.
                traza = traza / i;
                % Y la visualizamos
                fprintf("b%i = %.2f\n",i,traza);  
                
                % Guardamos el valor inverso en el vector del polinomio
                % caracteristico.
                vector_traza(numRows-i+1) = -traza;            
            end 
            
            % Agregamos por ultimo el primer valor (1) del polinomio 
            % caracteristico.
            vector_traza(numRows + 1) = 1;

            % Lo multiplicamos por -1 elevado a la dimension de la matriz.
            vector_traza = vector_traza * (-1) ^ numRows;
            
            % Damos vuelta el vector para que tenga el orden correcto
            vector_traza = flip(vector_traza);
 
            % Convertimos el vector en polinomio
            poli_caract = poly2sym(vector_traza);
      
            % Funcion matlab para calcular el polinomio caracteristico
            % polCar = charpoly(p_matriz)
            
            fprintf("\n\nPolinomio Caracteristico de la matriz A: ")
            disp(poli_caract);
        end 
        
        
        
    end
end


