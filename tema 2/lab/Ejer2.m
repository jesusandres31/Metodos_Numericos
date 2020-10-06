clc;
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
