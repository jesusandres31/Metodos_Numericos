clc;

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

%
%
%

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


