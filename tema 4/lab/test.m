classdef test
    methods (Static)
        
        %%
        %
        %
        % Metodo de Faddeev-Leverrier
        % Recibe como parametro la matriz cuadrada A del sistema de
        % ecuaciones y devuelve el polinomio caracteristico asociado a esa
        % matriz.
        %
        % guia4.faddeevLeverrier([3,2,1;1,-2,3;2,0,4])
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
                
                % Mostramos la matriz Bn
                fprintf("\nB%i = \n",i);
                disp(m_a);
                
                for j=1: 1: numRows
                   % Asigna a traza la suma de la diagonal.
                   traza = traza + m_a(j,j);    
                end
                
                % Finalizamos el calculo de la traza (ver formula).
                traza = traza / i;
                % Y la visualizamos
                fprintf("b%i = %f\n",i,traza);  
                
                % Guardamos el valor inverso en el vector del polinomio
                % caracteristico.
                vector_traza(numRows-i+1) = -traza;            
            end 
            
            % Agregamos por ultimo el primer valor (1) del polinomio caracteristico.
            vector_traza(numRows + 1) = 1;

            % Lo multiplicamos por -1 elevado a la dimension de la matriz.
            vector_traza = vector_traza * (-1) ^ numRows;
            
            % Damos vuelta el vector para que tenga el orden correcto
            vector_traza = flip(vector_traza);
 
            % Convertimos el vector en polinomio
            poli_caract = poly2sym(vector_traza);
      
            fprintf("\nPolinomio Caracteristico: ")
            disp(poli_caract);
        end 
       
            
    end
end
    

