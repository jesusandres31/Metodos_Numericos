classdef guia2   
    methods (Static)
        
        %%
        %
        %
        % Ejercicio numero 1
        %
        function ejer1()
            fprintf("\n");
            
            b = input("Ingrese la base del rectangulo: ");
            h = input("Ingrese la altura del rectangulo: ");
            eh = input("Ingrese el error en la medicion de la altura: +/- ");
            eb = input("Ingrese el error en la medicion de la base: +/- ");

            pmax = (b+eb)*2+(h+eh)*2;
            amax = (b+eb)*(h+eh);
            pmin = (b-eb)*2+(h-eh)*2;
            amin = (b-eb)*(h-eh);

            fprintf("\n\nPerimetro aproximado maximo (base +/- %.2f y altura +/- %.2f): %.2f cm",eb,eh,pmax);
            fprintf("\nPerimetro aproximado minimo (base +/- %.2f y altura +/- %.2f): %.2f cm",eb,eh,pmin);

            fprintf("\n\nArea aproximada maxima (base +/- %.2f y altura +/- %.2f): %.2f cm^2",eb,eh,amax);
            fprintf("\nArea aproximada minima (base +/- %.2f y altura +/- %.2f): %.2f cm^2",eb,eh,amin);

            perrorabs = abs(((pmax+pmin)/2)-pmax);
            perrorrel = perrorabs/((pmax+pmin)/2);
            aerrorabs = abs(((amax+amin)/2)-amax);
            aerrorrel = aerrorabs/((amax+amin)/2);

            fprintf("\n\nError Absoluto Perimetro: %.2f cm",perrorabs);
            fprintf("\nError Relativo Perimetro: %.5f",perrorrel);

            fprintf("\n\nError Absoluto Area: %.2f cm^2",aerrorabs);
            fprintf("\nError Relativo Area: %.5f",aerrorrel);

            fprintf("\n\nPerimetro exacto: %.2f cm",(pmax+pmin)/2);
            fprintf("\nArea exacta: %.2f cm^2",(amax+amin)/2);

            fprintf("\n\n");
        end
        
        
        %%
        %
        %
        % Ejercicio numero 2
        %
        function ejer2()
            fprintf("\n");
            
            fprintf("a) Valor exacto: pi");
            fprintf("\n   Valor aproximado: 22/7");
            errabs1 = abs(pi - (22/7));
            fprintf("\n   Error absoluto: %.5f",errabs1);
            fprintf("\n   Error relativo: %.5f",errabs1/pi);

            fprintf("\n\nb) Valor exacto: pi");
            fprintf("\n   Valor aproximado: 3.1416");
            errabs2 = abs(pi - (3.1416));
            fprintf("\n   Error absoluto: %.8f",errabs2);
            fprintf("\n   Error relativo: %.8f",errabs2/pi);

            % e in matlab is exp(1)
            fprintf("\n\nc) Valor exacto: e");
            fprintf("\n   Valor aproximado: 2.718");
            errabs3 = abs(exp(1) - (2.718));
            fprintf("\n   Error absoluto: %.5f",errabs3);
            fprintf("\n   Error relativo: %.5f",errabs3/exp(1));

            fprintf("\n\nd) Valor exacto: (2)^(1/2)");
            fprintf("\n   Valor aproximado: 1.414");
            errabs4 = abs(((2)^(1/2)) - (1.414));
            fprintf("\n   Error absoluto: %.5f",errabs4);
            fprintf("\n   Error relativo: %.5f",errabs4/((2)^(1/2)));

            fprintf("\n\ne) Valor exacto: e^(10)");
            fprintf("\n   Valor aproximado: 22000");
            errabs5 = abs(exp(10) - (22000));
            fprintf("\n   Error absoluto: %.5f",errabs5);
            fprintf("\n   Error relativo: %.5f",errabs5/(exp(10)));

            fprintf("\n\nf) Valor exacto: 8!");
            fprintf("\n   Valor aproximado: 39900");
            errabs6 = abs(factorial(8) - (39900));
            fprintf("\n   Error absoluto: %.5f",errabs6);
            fprintf("\n   Error relativo: %.5f",errabs6/factorial(8));

            fprintf("\n\n");
        end
        
        
        %%
        %
        %
        % Ejercicio numero 3
        %
        function ejer3()
            fprintf("\n");
            
            % a) 133 + 0.921          	= 133.921			=>	0.133921 * 10^(3)
            % b) 133 - 0.499            = 132.501			=>	0.132501 * 10^(3)
            % c) (121 - 119) - 0.327    = 1.673				=>	0.1673 * 10^(1)
            % d) (121 - 0.327) - 119 	= 1.673				=>	0.1673 * 10^(1)
            % e) (2/9) * (9/7)          = 0.28571428571		=>	0.28571428571 * 10^(0)

            fprintf("a) Valor Redondeado: 0.134 * 10^(3) \t Valor Exacto: 0.13392 * 10^(3) ");
            errabs1 = abs((0.13392 * 10^(3)) - (0.134 * 10^(3)));
            errrel1 = abs(errabs1/(0.13392 * 10^(3)));
            fprintf("\n   Error absoluto: %.5f",errabs1);
            fprintf("\n   Error relativo: %.5f",errrel1);
            fprintf("\n\n");

            fprintf("b) Valor Redondeado: 0.133 * 10^(3) \t Valor Exacto: 0.13250 * 10^(3) ");
            errabs2 = abs((0.13250 * 10^(3)) - (0.133 * 10^(3)));
            errrel2 = abs(errabs2/(0.13250 * 10^(3)));
            fprintf("\n   Error absoluto: %.5f",errabs2);
            fprintf("\n   Error relativo: %.5f",errrel2);
            fprintf("\n\n");

            fprintf("c) Valor Redondeado: 0.167 * 10^(1) \t Valor Exacto: 0.16730 * 10^(1) ");
            errabs3 = abs((0.16730 * 10^(1)) - (0.167 * 10^(1)));
            errrel3 = abs(errabs3/(0.16730 * 10^(1)));
            fprintf("\n   Error absoluto: %.5f",errabs3);
            fprintf("\n   Error relativo: %.5f",errrel3);
            fprintf("\n\n");

            fprintf("d) Valor Redondeado: 0.167 * 10^(1) \t Valor Exacto: 0.16730 * 10^(1) ");
            errabs4 = abs((0.16730 * 10^(1)) - (0.167 * 10^(1)));
            errrel4 = abs(errabs4/(0.16730 * 10^(1)));
            fprintf("\n   Error absoluto: %.5f",errabs4);
            fprintf("\n   Error relativo: %.5f",errrel4);
            fprintf("\n\n");

            fprintf("e) Valor Redondeado: 0.286 * 10^(0) \t Valor Exacto: 0.28571 * 10^(0) ");
            errabs5 = abs((0.28571 * 10^(0)) - (0.286 * 10^(0)));
            errrel5 = abs(errabs5/(0.28571 * 10^(0)));
            fprintf("\n   Error absoluto: %.5f",errabs5);
            fprintf("\n   Error relativo: %.5f",errrel5);

            fprintf("\n\n");
        end
        
        
        %%
        %
        %
        % Ejercicio numero 4
        %
        function ejer4()
            fprintf("\n");
            
            % a) 133 + 0.921 			= 133.921			=>	0.133921 * 10^(3)
            % b) 133 - 0.499 			= 132.501			=>	0.132501 * 10^(3)
            % c) (121 - 119) - 0.327 	= 1.673				=>	0.1673 * 10^(1)
            % d) (121 - 0.327) - 119 	= 1.673				=>	0.1673 * 10^(1)
            % e) (2/9) * (9/7) 			= 0.28571428571		=>	0.28571428571 * 10^(0)

            fprintf("\n");
            fprintf("a) Valor Truncado: 0.133 * 10^(3) \t Valor Exacto: 0.13392 * 10^(3) ");
            errabs1 = abs((0.13392 * 10^(3)) - (0.133 * 10^(3)));
            errrel1 = abs(errabs1/(0.13392 * 10^(3)));
            fprintf("\n   Error absoluto: %.5f",errabs1);
            fprintf("\n   Error relativo: %.5f",errrel1);
            fprintf("\n\n");
            
            fprintf("b) Valor Truncado: 0.132 * 10^(3) \t Valor Exacto: 0.13250 * 10^(3) ");
            errabs2 = abs((0.13250 * 10^(3)) - (0.132 * 10^(3)));
            errrel2 = abs(errabs2/(0.13250 * 10^(3)));
            fprintf("\n   Error absoluto: %.5f",errabs2);
            fprintf("\n   Error relativo: %.5f",errrel2);
            fprintf("\n\n");
            
            fprintf("c) Valor Truncado: 0.167 * 10^(1) \t Valor Exacto: 0.16730 * 10^(1) ");
            errabs3 = abs((0.16730 * 10^(1)) - (0.167 * 10^(1)));
            errrel3 = abs(errabs3/(0.16730 * 10^(1)));
            fprintf("\n   Error absoluto: %.5f",errabs3);
            fprintf("\n   Error relativo: %.5f",errrel3);
            fprintf("\n\n");
            
            fprintf("d) Valor Truncado: 0.167 * 10^(1) \t Valor Exacto: 0.16730 * 10^(1) ");
            errabs4 = abs((0.16730 * 10^(1)) - (0.167 * 10^(1)));
            errrel4 = abs(errabs4/(0.16730 * 10^(1)));
            fprintf("\n   Error absoluto: %.5f",errabs4);
            fprintf("\n   Error relativo: %.5f",errrel4);
            fprintf("\n\n");
            
            fprintf("e) Valor Truncado: 0.285 * 10^(0) \t Valor Exacto: 0.28571 * 10^(0) ");
            errabs5 = abs((0.28571 * 10^(0)) - (0.285 * 10^(0)));
            errrel5 = abs(errabs5/(0.28571 * 10^(0)));
            fprintf("\n   Error absoluto: %.5f",errabs5);
            fprintf("\n   Error relativo: %.5f",errrel5);
            
            fprintf("\n\n");
        end
        
        
        %%
        %
        %
        % Ejercicio numero 5
        %
        function ejer5()
            fprintf("\n");
            
            % X1 = (-b + sqrt((b^(2)) - 4 * a * c )) / (2 * a)
            % X2 = (-b - sqrt((b^(2)) - 4 * a * c )) / (2 * a)

            % x1 = -0.01610723 	= -0.1610723 * 10^(-1)
            % x2 = -62.08390	= -0.620839 * 10^(2)

            x1 = -0.1610723 * 10^(-1);
            x2 = -0.620839 * 10^(2);
            fprintf("\n");
            fprintf("a)");
            fprintf("\nValor x1: %.8f", x1);
            fprintf("\nValor x2: %.8f", x2);
            fprintf("\nValor Redondeado a cuatro digitos x1: -0.1610 * 10^(-1) ");
            fprintf("\nValor Redondeado a cuatro digitos x2: -0.6208 * 10^(2) ");
            fprintf("\n");
            errabsX1 = abs((-0.1610723 * 10^(-1)) - (-0.1610 * 10^(-1)));
            errrelX1 = abs(errabsX1/(-0.1610723 * 10^(-1)));
            fprintf("\n   X1:");
            fprintf("\n   Error absoluto: %.5f",errabsX1);
            fprintf("\n   Error relativo: %.5f",errrelX1);
            fprintf("\n");
            errabsX2 = abs((-0.620839 * 10^(2)) - (-0.6208 * 10^(2)));
            errrelX2 = abs(errabsX2/(-0.620839 * 10^(2)));
            fprintf("\n   X2:");
            fprintf("\n   Error absoluto: %.5f",errabsX2);
            fprintf("\n   Error relativo: %.5f",errrelX2);
            fprintf("\n\n");

            %%%%

            fprintf("\n");
            fprintf("b)");
            numeradorX1 = (-62.10 + sqrt((62.10^(2)) - 4 * 1 * 1 )); 
            denominadorX1 = (2 * 1);
            numeradorRacX1 = (-62.10 - sqrt((62.10^(2)) - 4 * 1 * 1 ));
            resultadoX1 = ((numeradorX1/denominadorX1)*(numeradorRacX1/numeradorRacX1));
            % resultadoX1 = -0.01610724 = -0.1610724 * 10^(-1)
            % redond = -0.1611 * 10^(-1)

            numeradorX2 = (-62.10 - sqrt((62.10^(2)) - 4 * 1 * 1 )); 
            denominadorX2 = (2 * 1);
            numeradorRacX2 = (-62.10 + sqrt((62.10^(2)) - 4 * 1 * 1 ));
            resultadoX2 = ((numeradorX2/denominadorX2)*(numeradorRacX2/numeradorRacX2));
            % resultadoX2 = -62.08389276 = -0.620838 * 10^(2)
            % redond = -0.6208 * 10^(2)

            fprintf("\nResultado x1 racionalizando el numerador: %.8f", resultadoX1);
            fprintf("\nResultado x2 racionalizando el numerador: %.8f", resultadoX2);
            fprintf("\n");
            fprintf("\nValor Redondeado a cuatro digitos x1: -0.1611 * 10^(-1) ");
            fprintf("\nValor Redondeado a cuatro digitos x2: -0.6208 * 10^(2) ");
            fprintf("\n");
            errabsX1 = abs((-0.1610724 * 10^(-1)) - (-0.1611 * 10^(-1)));
            errrelX1 = abs(errabsX1/(-0.1610724 * 10^(-1)));
            fprintf("\n   X1:");
            fprintf("\n   Error absoluto: %.5f",errabsX1);
            fprintf("\n   Error relativo: %.5f",errrelX1);
            fprintf("\n");
            errabsX2 = abs((-0.620838 * 10^(2)) - (-0.6208 * 10^(2)));
            errrelX2 = abs(errabsX2/(-0.620838 * 10^(2)));
            fprintf("\n   X2:");
            fprintf("\n   Error absoluto: %.5f",errabsX2);
            fprintf("\n   Error relativo: %.5f",errrelX2);

            fprintf("\n\n");
        end
        
        
        %%
        %
        %
        % Ejercicio numero 6
        %
        function ejer6()
            fprintf("\n");
            
            x = 4.71;
            % Las tres filas de la matriz representan:
            % 1) Valor Real
            % 2) Truncado a tres decimales
            % 3) Redondeado a tres decimales
            matriz = [1,-6,3,-0.149; 1,-6,3,-0.149; 1,-6,3,-0.149]; 
            matrizCuadro = [0,0,0,0,0;0,0,0,0,0;0,0,0,0,0];

            % Recorre todas las columnas de la matriz, 
            for i=1:1:length(matriz(1,:)) 
                % Dependiendo de la columna que se haga referencia (i),
                % se multiplicara la x por si misma (La columna define el
                % exponente al cual esta elevada la variable)
                for j=i:1:length(matriz(1,:)) 
                    if j ~= length(matriz(1,:))  
                        matriz(:,i) = matriz(:,i) * x;
                    end
                    % Se evalua la cantidad de enteros tiene el numero,
                    % se hace esto para eliminar los decimales no deseados
                    if abs(matriz(1,i)) >= 100 
                        matriz(2,i) = fix(matriz(2,i));
                        matriz(3,i) = round(matriz(3,i));
                    else
                        if abs(matriz(1,i)) >= 10 
                            matriz(2,i) = (fix(matriz(2,i)*10))/10;
                            matriz(3,i) = (round(matriz(3,i)*10))/10;
                        else 
                            matriz(2,i) = (fix(matriz(2,i)*100))/100;
                            matriz(3,i) = (round(matriz(3,i)*100))/100;
                        end
                    end
                    % Almacena los valores de la tabla (ver ejercicio)
                    % en la matriz matrizCuadro
                    if i==1 
                        matrizCuadro(:,j) = matriz(:,1);
                    end
                end
            end

            matrizCuadro(:,4) = matriz(:,2)*-1;
            matrizCuadro(:,5) = matriz(:,3);
            trunc = 0;
            red = 0;

            % Finalmente se suma cada valor de la fila, y dependiendo de 
            % la columna se redondea o trunca el resultado a 3 digitos
            if abs(sum(matriz(1,:))) >= 100 
                trunc = fix(sum(matriz(2,:)));
                red = round(sum(matriz(3,:)));
            else 
                if abs(sum(matriz(1,:))) >= 10 
                    trunc = (fix(sum(matriz(2,:))*10))/10;
                    red = (round(sum(matriz(3,:))*10))/10;
                else 
                    trunc = (fix(sum(matriz(2,:))*100))/100;
                    red = (round(sum(matriz(3,:))*100))/100;
                end
            end

            fprintf("\tx\t\t x^2\t\t x^3\t\t6x^2\t\t3x\n");
            disp (matrizCuadro);
            fprintf("\nValor exacto: %f\nValor truncado a 3 digitos: %.1f\nValor redondeado a 3 digitos: %.1f\n",sum(matriz(1,:)),trunc,red);
            erra=abs(sum(matriz(1,:))-trunc);
            errr=erra / abs(sum(matriz(1,:)));
            fprintf("\nValor truncado:\n\tError absoluto: %f\tError Relativo: %f\n",erra,errr);
            erra=abs(sum(matriz(1,:))-red);
            errr=erra / abs(sum(matriz(1,:)));
            fprintf("\nValor redondeado:\n\tError absoluto: %f\tError Relativo: %f",erra,errr);

            fprintf("\n\n");
        end
        
    end
end

