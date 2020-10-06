% a) 133 + 0.921 			= 133.921			=>	0.133921 * 10^(3)
% b) 133 – 0.499 			= 132.501			=>	0.132501 * 10^(3)
% c) (121 – 119) – 0.327 	= 1.673				=>	0.1673 * 10^(1)
% d) (121 – 0.327) – 119 	= 1.673				=>	0.1673 * 10^(1)
% e) (2/9) * (9/7) 			= 0.28571428571		=>	0.28571428571 * 10^(0)

clc;
fprintf("\n");
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