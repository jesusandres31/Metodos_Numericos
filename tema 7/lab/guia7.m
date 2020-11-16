classdef guia7   
	methods (Static)
%% Metodos de integracion 
        
        %% 
        %
        %
        % Metodo de Euler
        %
        % ecuacDif: ecuacion diferencial.
        % valorY0: valor inicial de Y.
        % valorX0: valor inicial de X.
        % increm: incremento de x (h).
        % valorXN: valor ultimo de X.
        %
        %
        % ejer 1 a
        % guia7.euler(@(x,y) ((x^2)+(y^2)), 1, 0, 0.2, 0.6)
        %
        %
        % ejer 2 
        % guia7.euler(@(x,y) ((3*y)-(0.1*y^2)), 5, 0, 0.50, 2)
        % guia7.euler(@(x,y) ((3*x)-(0.1*x^2)), 5, 0, 0.25, 2)
        %
        function [tablaValores] = euler(ecuacDif, valorY0, valorX0, increm, valorXN)

            fprintf("\n\n\tMetodo de Euler: \n\n");
            
            % Creamos un vector donde almacenar los valores de la tabla.
            tablaValores = [];
            
            % Contador para identificar en que fila de la tabla
            % almacenar los valores.
            cont = 1;

            % Guardamos la ecuacion diferencial en la variable f.
            f = ecuacDif;
            
            % Guardamos el primer valor de Y.
            y = valorY0;
            
            % Creamos variable resultado.
            resultadoEc = 0;
            
            fprintf("\tX\t\tY\t\tY'\n");
            
            % Obtenemos en cada iteracion el valor incrementado (h) de X.
            for i=valorX0 :increm :valorXN
                
                % Evalua la ecuacion diferencial en los valores de X e Y 
                % correspondientes para esa iteracion.
                % feval: evalua la ecuacion f con los valores actuales de i
                % e y.
                resultadoEc = feval(f, i, y);
                
                % Imprimimos una columna de la tabla.
                fprintf("\t%.2f\t%.4f\t%.4f\n",i, y , resultadoEc);
                
                % Se almacenan los valores en la fila que indique el
                % contador.
                tablaValores(cont,:) = [i, y, resultadoEc];
                
                cont = cont + 1;
                
                % Obtencion del valor de Y(i+1) segun el Metodo de Euler.
                y = y + resultadoEc * increm;      
            end
            fprintf("\n");
        end
        
        
        
        %% 
        %
        %
        % Metodo de Euler Modificado
        %
        % ecuacDif: ecuacion diferencial.
        % valorY0: valor inicial de Y.
        % valorX0: valor inicial de X.
        % increm: incremento de x (h).
        % valorXN: valor ultimo de X.
        % correcciones: cantidad de veces que se desea corregir.
        %
        %
        % ejer 1 b
        % guia7.eulerModificado(@(x,y) ((x^2)+(y^2)), 1, 0, 0.2, 0.6, 2)
        %
        %
        % ejer 5 a
        % guia7.eulerModificado(@(x,y) ((3*x)+(3*y)), 1, 0, 0.1, 0.3, 1)
        % guia7.eulerModificado(@(x,y) ((3*x)+(3*y)), 1, 0, 0.05, 0.3, 1)
        %
        function [tablaValores] = eulerModificado(ecuacDif, valorY0, valorX0, increm, valorXN, correcciones)

            fprintf("\n\n\tMetodo de Euler Modificado: \n\n");

            % Creamos un vector donde almacenar los valores de la tabla.
            tablaValores = [];
            
            % Contador para identificar en que fila de la tabla
            % almacenar los valores.
            cont = 1;

            % Guardamos la ecuacion diferencial en la variable f.
            f = ecuacDif;
            
            % Creamos los titulos de la tabla de acuerdo a la cantidad de
            % correciones.
            fprintf ("\tX\t\tP(Y)\tP(Y')");
            for j=0 :1 :correcciones-1
                fprintf ("\tC%i(Y)\tC%i(Y')",j,j);
            end 
            fprintf("\n");
            
            % Calculamos el valor de  P(y'0) con los valores x0 e y0 segun 
            % la ecuacion recibida por parametros
            % feval: evalua la ecuacion f con los valores de x0 e y0.
            pPrima = feval(f, valorX0, valorY0);
            
            % Se almacenan los valores en la fila que indique el contador.
            % En este caso la primera.
            tablaValores(cont,:) = [valorX0, valorY0 , pPrima];
            
            % Incrementamos el contador para pasar a la siguiente fila.
            cont = cont + 1;
            
            % Imprimimos los valores de una columna de la tabla.
            fprintf ("\t%.2f\t%.4f\t%.4f\n",valorX0, valorY0 , pPrima);
            
            % Creamos variable p y le asignamos el valor de y0.
            p = valorY0;
            
            % Obtenemos en cada iteracion el valor incrementado (h) de X.
            for i=valorX0+increm :increm :valorXN
                
                % Asignamos a pAnt, el valor de yi para poder luego 
                % realizar correcciones al valor de y.
                pAnt = p;
                
                % Para hallar P(y(i+1)) aplicamos la formula Euler Modificado.
                p = p + pPrima * increm;
                
                % Asignamos a pPrimaAnt, el valor de y'i para poder luego  
                % realizar correcciones al valor de y.       
                pPrimaAnt = pPrima;
                
                % Calculamos el valor de P(y'(i+1)) con los valores x(i+1)
                % y P(y(i+1)).
                pPrima = feval(f, i, p);
                
                % Se almacenan los valores en la fila que indique el
                % contador.
                tablaValores(cont,:) = [i, p, pPrima];
                
                % Incrementamos el contador para pasar a la siguiente fila.
                cont = cont + 1;       
                
                % Imprimimos los valores una columna de la tabla.
                fprintf("\t%.2f\t%.4f\t%.4f",i, p , pPrima);
                
                % Aplicamos la formula de Euler Modificado para hallar C(y(i+1)).        
                c = pAnt + (pPrimaAnt+pPrima)*(increm/2);
                
                % Segun el numero de correcciones ingresado, itera y
                % realizara la correccion del valor de y(i+1) con los 
                % sucesivos C(y'(i+1)) obtenidos.
                for j=1 :1 :correcciones
                    
                    % feval: evalua la ecuacion f con los valores de i y c.
                    cPrima = feval(f, i, c); 
                    
                    % Se asignan los valores C y C' en la tabla.
                    tablaValores(cont-1,2) = c;
                    tablaValores(cont-1,3) = cPrima;   
                    
                    % Imprimimos los valores de C y C'.
                    fprintf ("\t%.4f\t%.4f", c, cPrima);
                    
                    % Igualamos P a C, y P a C'
                    p = c;
                    pPrima = cPrima; 
                    
                    % Aplicamos la formula de Euler Modificado para hallar
                    % C(y(i+1)).
                    c = pAnt + (pPrimaAnt+cPrima)*(increm/2);
                end                 
                fprintf("\n");      
            end    
        end
        
        
        
        %% 
        %
        %
        % Metodo de Runge Kutta de 2do Orden
        %
        % ecuacDif: ecuacion diferencial.
        % valorY0: valor inicial de Y.
        % valorX0: valor inicial de X.
        % increm: incremento de x (h).
        % valorXN: valor ultimo de X.
        %
        %
        % ejer 3 a
        % guia7.rungeKutta2do(@(x,y) ((x^2)+(y^2)), 1, 0, 0.2, 0.6)
        %
        function [tablaValores] = rungeKutta2do(ecuacDif, valorY0, valorX0, increm, valorXN)
            
            fprintf("\n\n\tMetodo de Runge Kutta de Segundo Orden: \n\n");
            
            % Creamos un vector donde almacenar los valores de la tabla.
            tablaValores = [];
            
            % Contador para identificar en que fila de la tabla
            % almacenar los valores.
            cont = 1;

            % Guardamos la ecuacion diferencial en la variable f.
            f = ecuacDif;
            
            % Creamos variable resultado.
            resultadoEc = 0;
            
            % Seteamos el valor de Y0 en la variable y.
            y = valorY0;
            
            fprintf("\tX\t\tY\t\tY'\n");
            fprintf("");
            
            % Obtenemos en cada iteracion el valor incrementado (h) de X.
            for i=valorX0 :increm :valorXN
                
                % feval: evalua la ecuacion f con los valores de i e y.
                resultadoEc = feval(f, i, y);
                
                % Imprimimos los valores de una columna de la tabla.
                fprintf ("\t%.2f\t%.4f\t%.4f\n", i, y , resultadoEc);        
                
                % Se almacenan los valores en la fila que indique el
                % contador.
                tablaValores(cont,:) = [i, y, resultadoEc];
                
                % Incrementamos el contador para pasar a la siguiente fila.
                cont = cont + 1;
                
                % Calculamos k1 y k2 segun el metodo de Runge-Kutta.
                k1 = resultadoEc*increm;
                k2 = feval(f, i+increm, y+k1)*increm;
                
                % Calculamos Y aplicando el metodo de Runge-Kutta.
                y = y + (k1+k2)*(1/2);      
            end
            fprintf("\n");      
        end
        
             
        
        %% 
        %
        %
        % Metodo de Runge Kutta de 4to Orden
        %
        % ecuacDif: ecuacion diferencial.
        % valorY0: valor inicial de Y.
        % valorX0: valor inicial de X.
        % increm: incremento de x (h).
        % valorXN: valor ultimo de X.
        %
        %
        % ejer 3 a
        % guia7.rungeKutta4to(@(x,y) ((x^2)+(y^2)), 1, 0, 0.2, 0.6)
        %
        function [tablaValores] = rungeKutta4to(ecuacDif, valorY0, valorX0, increm, valorXN)
            
            fprintf("\n\n\tMetodo de Runge Kutta de Cuarto Orden: \n\n");
            
            % Creamos un vector donde almacenar los valores de la tabla.
            tablaValores = [];
            
            % Contador para identificar en que fila de la tabla
            % almacenar los valores.
            cont = 1;

            % Guardamos la ecuacion diferencial en la variable f.
            f = ecuacDif;
            
            % Creamos variable resultado.
            resultadoEc = 0;
            
            % Seteamos el valor de Y0 en la variable y.
            y = valorY0;
            
            fprintf("\tX\t\tY\t\tY'\n");
            
            % Obtenemos en cada iteracion el valor incrementado (h) de X.
            for i=valorX0 :increm :valorXN
                
                % feval: evalua la ecuacion f con los valores de i e y.
                resultadoEc = feval(f, i, y);
                
                % Imprimimos los valores de una columna de la tabla.
                fprintf ("\t%.2f\t%.4f\t%.4f\n", i, y , resultadoEc);        
                
                % Se almacenan los valores en la fila que indique el
                % contador.
                tablaValores(cont,:) = [i, y, resultadoEc];
                
                % Incrementamos el contador para pasar a la siguiente fila.
                cont = cont + 1;
                
                % Calculamos k1, k2, k3 y k4 segun el metodo de Runge-Kutta.
                k1 = resultadoEc*increm;
                k2 = feval(f, i+(increm/2), y+(k1/2))*increm;
                k3 = feval(f, i+(increm/2), y+(k2/2))*increm;
                k4 = feval(f, i+increm, y+k3)*increm;
                
                % Calculamos Y aplicando el metodo de Runge-Kutta.
                y = y + (k1+2*k2+2*k3+k4)*(1/6);      
            end
            fprintf("\n");      
        end
        
        
        
        %% 
        %
        %
        % Metodo de Milne
        %
        % ecuacDif: ecuacion diferencial.
        % increm: incremento de x (h).
        % valorXN: valor ultimo de X (valor buscado).
        % correcciones: cantidad de veces que se desea corregir.
        % tablaValores: tabla de valores obtenida por algun metodo que
        % comienza por si mismo.
        %
        %
        % ejer 4 a, x = 0.8 ^ x = 1
        % tablaEjer3 = guia7.rungeKutta4to(@(x,y) ((x^2)+(y^2)), 1, 0, 0.2, 0.6)
        % tablaEjer4 = guia7.milne(@(x,y) ((x^2)+(y^2)), 0.2, 0.8, 2, tablaEjer3)
        % guia7.milne(@(x,y) ((x^2)+(y^2)), 0.2, 1, 1, tablaEjer4)
        %
        %
        % ejer 5 b, x = 0.20
        % tablaEjer5 = guia7.eulerModificado(@(x,y) ((3*x)+(3*y)), 1, 0, 0.05, 0.15, 1)
        % guia7.milne(@(x,y) ((3*x)+(3*y)), 0.05, 0.20, 2, tablaEjer5)
        %
        % ejer 5 b, x = 0.25
        % tablaEjer5 = guia7.eulerModificado(@(x,y) ((3*x)+(3*y)), 1, 0, 0.05, 0.20, 1)
        % guia7.milne(@(x,y) ((3*x)+(3*y)), 0.05, 0.25, 2, tablaEjer5)
        %
        function [tablaValores] = milne(ecuacDif, increm, valorXN, correcciones, tablaValores)   
            
            fprintf("\n\n\tMetodo de Milne: \n\n");
            
            % Guardamos la ecuacion diferencial en la variable f.
            f = ecuacDif;
            
            % Creamos los titulos de la tabla de acuerdo a la cantidad de
            % correciones.
            fprintf ("\tX\t\tP(Y)\tP(Y')");
            for j=0 :1 :correcciones-1
                fprintf ("\tC%i(Y)\tC%i(Y')",j,j);
            end 
            fprintf("\n");

            % Obtebemos el numero de filas y de columnas de la tabla.
            % Para utilizar el valor de la ultima fila.
            [ultimaFila, numCols] = size(tablaValores);
            
            % Contador para identificar en que fila de la tabla almacenar
            % los nuevos valores obtenidos por el metodo de Milne.
            cont = ultimaFila + 1;
            
            % Obtenemos el ultimo valor de X de la tabla.
            ultimoXTabla = tablaValores(ultimaFila,1);
            
            % Obtenemos en cada iteracion el valor incrementado (h) de X.
            for i=ultimoXTabla+increm: increm: valorXN
                
                % Obtenemos los valores necesarios que usaremos en la
                % formula del metodo de Milne.
                y3= tablaValores(cont - 4,2);
                yp= tablaValores(cont - 1,3);
                yp1= tablaValores(cont - 2,3);
                yp2= tablaValores(cont - 3,3);
                
                % Calculamos P(Yi+1).
                p = y3 + (4*increm/3)*(2*yp-yp1+2*yp2);
                
                % Calculamos  P(Y'i+1).
                % feval: evalua la ecuacion f con los valores de i y p.
                pPrima = feval(f, i, p);
                
                % Se almacenan los valores en la fila que indique el
                % contador.
                tablaValores(cont,:) = [i, p, pPrima];   
                
                % Imprimimos los valores de una columna de la tabla.
                fprintf ("\t%.2f\t%.4f\t%.4f",i, p , pPrima);
                
                % Seteamos el nuevo valor de y1.
                y1 = tablaValores(cont - 2, 2);
                
                % Calculamos C(Yi+1).
                c = y1 + (increm/3)*(yp1+4*yp+pPrima);
                
                % Segun el numero de correcciones ingresado, itera y
                % realizara la correccion del valor de y(i+1) con los 
                % sucesivos C(y'(i+1)) obtenidos.
                for j=1 :1 :correcciones  
                    
                    % feval: evalua la ecuacion f con los valores de i y c.
                    cPrima = feval(f, i, c);
                    
                    % Se asignan los valores C y C' en la tabla.
                    tablaValores(cont,2) = c;
                    tablaValores(cont,3) = cPrima;
                    
                    % Imprimimos los valores de C y C'.
                    fprintf ("\t%.4f\t%.4f",c , cPrima);
                    
                    % Calculamos C^n(Yi+1).
                    c = y1 + (increm/3)*(yp1+4*yp+cPrima);             
                end                 
                
                % Incrementamos el contador para pasar a la siguiente fila.
                cont = cont + 1;      
            end
            fprintf("\n"); 
        end 

        
        
    end
end
