function [intervalos] = tanteos(funcion_vector,n_raices,primer_val,incrX)   /*Recibe como parametros un vector, la cantidad de raices de la misma, el primer valor por el que se desea realizar el tanteo y el incremento que va a tomar el procedimiento, y devuelve un array con los intervalos que tienen raices de la funcion*/
    vx = incrX;
    funcion = poly(funcion_vector,"x","c"); //Crea un polinimoio con el vector recibido por parametro
    x=primer_val;
    i = 1;
    intervalos = [];
    band = (n_raices * 2)+1; /*Define la cantidad de lugares que se deberan disponer en el array intervalos para contener a todos los intervalos con raices (Se le suma uno de mas porque e l array en Scilab tiene como primer indice el 1, no el 0)*/
    str = pol2str(funcion);
    printf("\n\tMetodo de Tanteos:\n\nRaices halladas en F(x) = %s",str);

    while i < band //Mientras haya lugar en el array se vuelve a iterar
        valorFunc = horner(funcion,x); //Se evalua la funcion en el punto x, punto de comienzo ingresado por el usuario como tambien la funcion
        if valorFunc > 0 then
            while valorFunc > 0 
                intervalos(1,i) = x;
                x = x + vx;
                valorFunc = horner(funcion,x);
            end        
        else
            if valorFunc < 0 then
                while valorFunc < 0
                    intervalos(1,i) = x;
                    x = x + vx;
                    valorFunc = horner(funcion,x);
                end
            else
                intervalos(1,i) = x;
            end               
        end //Evalua si se produce un cambio de signo al ir reemplazando la funcion con distintos valores, guardando antes el valor anterior de x en una posicion del array
        i = i + 1;
        intervalos(1,i) = x;//Luego guarda el valor posterior que se produjo el cambio de signo en la funcion para determinar el intervalo
        printf("\n\t\t*(%.2f, %.2f)",intervalos(1,i-1),intervalos(1,i));
        i = i + 1;
    end
    printf("\n");
    
endfunction

function intervaloMedio(funcion_vector, intervalos, errbus) /*Recibe como parametros un vector, los distintos intervalos (en un array) y el error absoluto que se desea tener en el resultado*/
    i = 1;
    funcion = poly(funcion_vector,"x","c");
    cant_inter = size(intervalos, "c") + 1; //obtiene la cantidad de elementos del array intervalos brindado por el usuario
    str = pol2str(funcion);
    printf ("Metodo del Intervalo Medio:\n\nF(x) = %s",str);
    

    while i < cant_inter
        extremoMenor = intervalos(1,i); //se obtiene del array intervalos el extremo inferior de uno de ellos
        extremoMayor = intervalos(1,i+1);//se obtiene del array intervalos el extremo superior de uno de ellos
        medio = (extremoMenor + extremoMayor)/2; //Se aplica la formula de intervalo medio
        valorFunc = horner(funcion,medio); //Se evalua la funcion en el punto obtenido con el metodo
        err = abs(extremoMayor - extremoMenor);
        n = 1;
        printf ("\n\nBusqueda de la raiz en el intervalo (%i, %i)\n",extremoMenor, extremoMayor);
        mprintf("\n    X\t\t   F(X)\t\t   Intervalo\t\tError");
        mprintf("\n%f\t%f\t[%f,%f]\t-------",medio,valorFunc,extremoMenor, extremoMayor);
        while err > errbus //Dependiendo del error absoluto que tenga x, si este es menor al error proporcionado por el usuario termina el bucle 
            if valorFunc <> 0
                n = n + 1;
                if horner(funcion,extremoMenor) * valorFunc < 0//Dependiendo del signo del producto entre el extremo inferior y el valor obtenido se descarta ese mismo extremo, o el mayor
                    extremoMayor = medio
                else
                    extremoMenor = medio                             
                end     
             end
             err = medio;
             medio = (extremoMayor + extremoMenor)/2;
             err = abs(err - medio);
             valorFunc = horner(funcion, medio);
             if valorFunc <> 0
                mprintf("\n%f\t%f\t[%f,%f]\t%f",medio,valorFunc,extremoMenor, extremoMayor,err);     
             end          
        end
        printf ("\n\n\t*Raiz en el intervalo (%i, %i) con un error de %f= %f\nEl metodo realiza %i iteraciones\n\n",intervalos(i), intervalos(i+1),errbus, medio,n);
        i = i+2;
    end
endfunction

function interpolacionLin(funcion_vector, intervalos, errbus) /*Recibe como parametros un vector, los distintos intervalos (en un array) y el error absoluto que se desea tener en el 
                                                              resultado*/
    i = 1;
    funcion = poly(funcion_vector,"x","c");
    cant_inter = size(intervalos, "c") + 1;
    str = pol2str(funcion);
    printf ("Metodo de Interpolacion Lineal:\n\nF(x) = %s",str);


    while i < cant_inter
        extremoMenor = intervalos(1,i); //se obtiene del array intervalos el extremo inferior de uno de ellos
        extremoMayor = intervalos(1,i+1); //se obtiene del array intervalos el extremo superior de uno de ellos
        funcionMenor = horner(funcion,extremoMenor); //se obtiene el valor de la funcion en el extremo inferior
        funcionMayor = horner(funcion,extremoMayor); //se obtiene el valor de la funcion en el extremo inferior
        rrecta = extremoMenor+(((extremoMayor-extremoMenor)*(funcionMenor*-1))/(funcionMayor-funcionMenor)); //Se aplica la formula de interpolacion lineal
        valorFunc = horner(funcion,rrecta); //Se evalua la funcion en el punto obtenido con el metodo
        err = abs(extremoMayor - extremoMenor);
        
        printf ("\n\nBusqueda de la raiz en el intervalo (%i, %i)\n",extremoMenor, extremoMayor);
        mprintf("\n    X\t\t   F(X)\t\t   Intervalo\t\tError");
        mprintf("\n%f\t%f\t[%f,%f]\t-------",rrecta,valorFunc,extremoMenor, extremoMayor);      
        while err > errbus //Dependiendo del error absoluto que tenga x, si este es menor al error proporcionado por el usuario termina el bucle 
             if valorFunc <> 0
                if horner(funcion,extremoMenor) * valorFunc < 0 //Dependiendo del signo del producto entre el extremo inferior y el valor obtenido se descarta ese mismo extremo, o el mayor
                    extremoMayor = rrecta;
                    funcionMayor = horner(funcion,extremoMayor);
                else
                    extremoMenor = rrecta;
                    funcionMenor = horner(funcion,extremoMenor);                             
                end     
             end
             err = rrecta;
             rrecta = extremoMenor+(((extremoMayor-extremoMenor)*(funcionMenor*-1))/(funcionMayor-funcionMenor));
             err = abs(err - rrecta);
             valorFunc = horner(funcion, rrecta);
             if valorFunc <> 0
                mprintf("\n%f\t%f\t[%f,%f]\t%f",rrecta,valorFunc,extremoMenor, extremoMayor,err);
             end               
        end
        printf ("\n\n\t*Raiz en el intervalo (%i, %i) con un error de %f= %f\n",intervalos(i), intervalos(i+1),errbus, rrecta);
        i = i+2;
    end
endfunction

function newtonRaph(funcion_vector, intervalos, errbus) /*Recibe como parametros un vector, los distintos intervalos (en un array) y el error absoluto que se desea tener en el resultado*/
    i = 1;
    funcion = poly(funcion_vector,"x","c");
    derivada = derivat(funcion); //se obtiene la derivada de la funcion entregada por el usuario
    if derivada == 0 then //Se evalua si la derivada es igual a 0 (condicion de convergencia del metodo)
        printf ("\nNo es posible obtener la raiz porque no se cumple la condicion de convergencia que la derivada de F(X) sea distinta de 0 para todo valor del intervalo");
        pause;
    end
    cant_inter = size(intervalos, "c") + 1;
    str = pol2str(funcion);
    printf ("Metodo de Newton Raphson:\n\nF(x) = %s",str);
    while i < cant_inter
        extremoMenor = intervalos(1,i); //se obtiene del array intervalos el extremo inferior de uno de ellos
        extremoMayor = intervalos(1,i+1);//se obtiene del array intervalos el extremo superior de uno de ellos
        convergencia = convergenciaNR(funcion, [extremoMenor, extremoMayor]);//llama a la funcion convergenciaNR, que controla que se cumplan todas las condiciones de convergencia en el punto
        
        if convergencia <> 0             
            printf ("\n\n\t\tLa funcion cumple las condiciones de convergencia:\n");
            if convergencia == 1 //Dependiendo de si se cumplen en el extremo inferior o superior (1 inferior, 2 superior) se aplica el metodo de Newton Raphson
                printf("\n\t1)f(%.2f)*f(%.2f) < 0\n\t2)f''(x) <> 0\n\t3)f(%.2f)*f''''(%.2f) > 0",extremoMenor,extremoMayor,extremoMenor,extremoMenor);
                valorFunc = horner(funcion,extremoMenor); 
                valorDerv = horner(derivada,extremoMenor);
                tangen = extremoMenor - (valorFunc/valorDerv);
            else
                printf("\n\t1)f(%.2f)*f(%.2f) < 0\n\t2)f''(x) <> 0\n\t3)f(%.2f)*f''''(%.2f) > 0",extremoMayor,extremoMenor,extremoMayor,extremoMayor);
                valorFunc = horner(funcion,extremoMayor);
                valorDerv = horner(derivada,extremoMayor);
                tangen = extremoMayor - (valorFunc/valorDerv);
            end 
            valorFunc = horner(funcion,tangen);           
            err = abs(extremoMayor - extremoMenor);
            printf ("\n\nBusqueda de la raiz en el intervalo (%i, %i)\n",extremoMenor, extremoMayor);
            mprintf("\n    X\t\t   F(X)\t\t   Intervalo\t\tError");
            mprintf("\n%f\t%f\t[%f,%f]\t-------",tangen,valorFunc,extremoMenor, extremoMayor);      
            while err > errbus
                err = tangen;            
                if valorFunc <> 0
                    if horner(funcion,extremoMenor) * valorFunc < 0 //Dependiendo del signo del producto entre el extremo inferior y el valor obtenido se descarta ese mismo extremo, o el mayor
                        extremoMayor = tangen;
                    else
                        extremoMenor = tangen;
                    end 
                    convergencia = convergenciaNR(funcion, [extremoMenor, extremoMayor]);
                    if convergencia == 1
                        valorFunc = horner(funcion,extremoMenor);
                        valorDerv = horner(derivada,extremoMenor);
                        tangen = extremoMenor - (valorFunc/valorDerv);
                     else
                        valorFunc = horner(funcion,extremoMayor);
                        valorDerv = horner(derivada,extremoMayor);
                        tangen = extremoMayor - (valorFunc/valorDerv);
                     end 
                     valorFunc = horner(funcion,tangen); 
                     err = abs(err - tangen); 
                     mprintf("\n%f\t%f\t[%f,%f]\t%f",tangen,valorFunc,extremoMenor, extremoMayor,err);
                 else
                     err = abs(err - tangen);  
                 end           
            end
            printf ("\n\n\t*Raiz en el intervalo (%i, %i) con un error de %f= %f\n",intervalos(i), intervalos(i+1),errbus, tangen);
            i = i+2;
        else
            i = i+2;
        end
    end
endfunction

function extremo = convergenciaNR(funcion, intervalo)
     if (horner((derivat(funcion),intervalo(1))) == 0) or (horner((derivat(funcion),intervalo(2))) == 0)
        printf ("\nNo es posible obtener la raiz porque no se cumple la condicion de convergencia que la derivada de F(X) <> 0 para todo valor del intervalo (%i, %i)", intervalo(1) ,intervalo(2));
            extremo = 0;
        else
            segDerivada = derivat(derivat(funcion));
            if horner(funcion,intervalo(1)) * horner(segDerivada,intervalo(1)) <= 0
                
                if horner(funcion,intervalo(2)) * horner(segDerivada,intervalo(2)) <= 0
                    printf ("\n\nNo es posible garantizar la obtencion de la raiz porque no se cumple la condicion de convergencia que F(X0) * F''''(X0) > 0 en los extremos del intervalo (%i, %i)", intervalo(1) ,intervalo(2));
                    extremo = 0;
                else
                   extremo = 2; 
                end
            else
                extremo = 1;
            end
        end
endfunction

function newtonSegundo(funcion_vector, intervalos, errbus)
    i = 1;
    funcion = poly(funcion_vector,"x","c");
    derivada = derivat(funcion);
    segderivada = derivat(derivada);
    if derivada == 0 then
        printf ("\nNo es posible obtener la raiz porque no se cumple la condicion de convergencia que la derivada de F(X) sea distinta de 0 para todo valor del intervalo");
        pause;
    end
    cant_inter = size(intervalos, "c") + 1;
        str = pol2str(funcion);
    printf ("Metodo Segundo Orden de Newton:\n\nF(x) = %s",str);

    while i < cant_inter
        extremoMenor = intervalos(1,i); //se obtiene del array intervalos el extremo inferior de uno de ellos
        extremoMayor = intervalos(1,i+1); //se obtiene del array intervalos el extremo superior de uno de ellos
        convergencia = convergenciaNR(funcion, [extremoMenor, extremoMayor]); //llama a la funcion convergenciaNR, que controla que se cumplan todas las condiciones de convergencia en el punto
        
        if convergencia <> 0
            if convergencia == 1
                valorFunc = horner(funcion,extremoMenor);
                valorDerv = horner(derivada,extremoMenor);
                valorSegDerv = horner(segderivada,extremoMenor);
                tangen = extremoMenor - (valorFunc/(valorDerv-((valorSegDerv*valorFunc)/(2*valorDerv))));
            else
                valorFunc = horner(funcion,extremoMayor);
                valorDerv = horner(derivada,extremoMayor);
                valorSegDerv = horner(segderivada,extremoMayor);
                tangen = extremoMayor - (valorFunc/(valorDerv-((valorSegDerv*valorFunc)/(2*valorDerv))));
            end 
            valorFunc = horner(funcion,tangen);           
            err = abs(extremoMayor - extremoMenor);
            printf ("\n\nBusqueda de la raiz en el intervalo (%i, %i)\n",extremoMenor, extremoMayor);
            mprintf("\n    X\t\t   F(X)\t\t   Intervalo\t\tError");
            mprintf("\n%f\t%f\t[%f,%f]\t-------",tangen,valorFunc,extremoMenor, extremoMayor);      
            while err > errbus
                            
                if valorFunc <> 0
                    if horner(funcion,extremoMenor) * valorFunc < 0
                        extremoMayor = tangen;
                    else
                        extremoMenor = tangen;
                    end     
                 end
                 err = tangen;
                 convergencia = convergenciaNR(funcion, [extremoMenor, extremoMayor]);
                 if convergencia == 1 //Dependiendo de si se cumplen en el extremo inferior o superior (1 inferior, 2 superior) se aplica el metodo Segumdo de Newton
                    valorFunc = horner(funcion,extremoMenor);
                    valorDerv = horner(derivada,extremoMenor);
                    valorSegDerv = horner(segderivada,extremoMenor);
                    tangen = extremoMenor - (valorFunc/(valorDerv-((valorSegDerv*valorFunc)/(2*valorDerv))));
                 else
                    valorFunc = horner(funcion,extremoMayor);
                    valorDerv = horner(derivada,extremoMayor);
                    valorSegDerv = horner(segderivada,extremoMayor);
                    tangen = extremoMayor - (valorFunc/(valorDerv-((valorSegDerv*valorFunc)/(2*valorDerv))));
                 end 
                 valorFunc = horner(funcion,tangen);
                 err = abs(err - tangen);
                 if valorFunc <> 0
                    mprintf("\n%f\t%f\t[%f,%f]\t%f",tangen,valorFunc,extremoMenor, extremoMayor,err);
                 end               
            end
            printf ("\n\n\t*Raiz en el intervalo (%i, %i) con un error de %f= %f\n",intervalos(i), intervalos(i+1),errbus, tangen);
            i = i+2;
        else
            i = i+2;
        end
    end
endfunction
