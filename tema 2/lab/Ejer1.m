clc;
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