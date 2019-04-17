%% PRÁCTICA 3. Señales en tiempo contínuo.
% *Autores:*
%
% *Acosta Villa Cristian Abraham*
%
% *Córdova Fernández Karla Lilia*
%
% *SEÑALES Y SISTEMAS, Grupo 2TV1*

%% Objetivos de la práctica.
% * Manupulación básica de MATLAB.
% * Gráficas de señales reales y complejas contínuas.
% * Transformación de señales contínuas (Escalamientos y traslaciones).
% * Cálculo de energía y potencia de señales contínuas.

%% Introducción.
% Como sabemos, MATLAB es un sofware matemático, el cuál, tiene su
% propio lenguaje de programación (Lenguaje M), y el cuál es multiplataforna.
%%
% Surgió por primera vez en 1984 por Cleve Moler, con el objetivo de
% uaar paquetes de subrutinas escritas en <https://www.ecured.cu/Fortran Fortran> en los cursos
% de Análisis Numérico y Álgebra lineal.
% Su lenguaje fue creado en 1970, el cuál, proporcionó un acceso
% sencillo al sofware de matrices LINPACK y EISPACK, esto sin 
% usar Fortran.
%%
% Existen otras alternativas de sofware libre como <https://www.gnu.org/software/octave/ Octave>
% y <https://www.python.org/ Python>.
% Octave por un lado, viene siendo el equivalente de MATLAB, ya que 
% poseé la mayoría de las características que tiene MATLAB. Por otro
% lado, Python un lenguaje de programación multiparadigma, ya que 
% soporta orientación a objetos y programaci´pon imperativa.

%% 
% Si quieres saber más acerca de estos sofware, puedes abrir los
% siguientes enlaces:
% <https://es.wikipedia.org/wiki/GNU_Octave Características Octave>
% <https://es.wikipedia.org/wiki/Python Caracteristicas Python>

%% Desarrollo.
%
%% Ejercicio 1: 
% Crea una función que se llame _fun1_ y reciba dos parametros $\omega$ y $a$ la función debe regresar la evaluación 
% $F(\omega)=a/(a^2+\omega^2)$, esta función debe trabajar con $a\in R$ y $t\in  R^n$. 
%
%Para este oasi sólo se tiene que crear una nueva función y escribir la ecuación, esto es.
% *function F = fun1 (w,a)*
% *F = a/(a^2 + b^2);*
% *endfunction*
%
%% Ejercicio 2:
% Construya una función que gráfique funciones de
% $f:R\rightarrow R$ en el formato de su elección y pruebe
% su código mostrando la gráfica de $F(\omega)$ vs $\omega$ en el intervalo
% $[-2,2]$ para $a=1$, no debe
% Para realizar esto haremos lo siguiente:

w = [-2:0.0001:2];
a = 1;
f1 = fun1(w,a);
figure
plot (w,f1,'k','LineWidth',2)
title('F(w) = a/(a^2+w^2)')
xlabel('\omega')
grid on
%
%
%% Ejercicio 4.
% * Ejercicio M1.1
f = inline('exp(-t).*cos(2*pi*t)', 't');
t = (-2:0.01:2);

% M1.1 con función anónima
f = @(t) exp(-t).*cos(2*pi*t);
figure
plot(t, f(t), 'r', 'LineWidth', 2); grid on
xlabel('t'); ylabel('f(t)'); title('f(t) = e^{-t}cos(2\pi t)');
%%
% * Ejercicio M1.2
% 
u = inline('(t>=0)', 't'); %escalón
t = (-2:0.01:2);

u = @(t) (t>=0);
figure
plot(t, u(t), 'g', 'LineWidth', 2); grid on
xlabel('t'); ylabel('u(t)'); title('Escalón con función anónima');
axis([-2 2 -0.1 1.1]);


p = inline('(t>=0) & (t<1)', 't'); %pulso unitario
t = (-1:0.01:2);

p = @(t) (t>=0) & (t<1); %pulso unitario
figure
plot(t, p(t), 'g', 'LineWidth', 2); grid on
xlabel('t'); ylabel('p(t)'); title('Pulso unitario con función anónima');
axis([-2 2 -0.1 1.1]);
%%
% * Ejercicio M1.3
g = inline('exp(-t).*cos(2*pi*t).*(t>=0)', 't');
t = (-2:0.01:2);

g = @(t) exp(-t).*cos(2*pi*t).*(t>=0);
figure
plot(t, g(t), 'b', 'LineWidth', 2); grid on
xlabel('t'); ylabel('g(t)'); title('g(t) = e^{-t}cos(2\pi t)*(t>=0)');
figure
plot(t, g(2*t+1), 'b', 'LineWidth', 2); grid on
xlabel('t'); ylabel('g(t)'); title('g(2t + 1)');
figure
plot(t, g(-t+1), 'c', 'LineWidth', 2); grid on
xlabel('t'); ylabel('g(t)'); title('g(-t + 1)');
figure
plot(t, g(2*t+1)+g(-t+1), 'c', 'LineWidth', 2); grid on
xlabel('t'); ylabel('g(t)'); title('g(2t + 1) + g(-t + 1)');
%%
% * Ejercicio M1.4
x = inline('exp(-t).*((t>=0) & (t<1))', 't');
t = (0:0.01:1);
E_x = sum(x(t).*x(t)*0.01);
x_squared = inline('exp(-2*t).*((t>=0) & (t<1))', 't');
E_x = quad(x_squared, 0, 1);
g_squared = inline('exp(-2*t).*((cos(2*pi*t)).^2).*(t>=0)', 't');
t = (0:0.001:100);
E_g = sum(g_squared(t)*0.001);
E_g = quad(g_squared,0,100);

% Con funciones anónimas:
x_squared = @(t) exp(-2*t).*((t>=0) & (t<1));
E_x = quad(x_squared, 0, 1);
g_squared = @(t) exp(-2*t).*((cos(2*pi*t)).^2).*(t>=0);
E_g = quad(g_squared,0,100);
E_g = sum(g_squared(t)*0.001);
%%
% Como se puede notar en este ejercicio, podemos deducir que el uso de
% _inline_ y las funciones anónimas, es exactamente igual, la única
% diferencia es la sintáxis, donde *f = inline('función','variable')* , que
% sería lo mismo a *f = @(variable) expresión* .
%% Ejercicio 5.
%
% Con la señal x(t) mostrada a continuación, graficar:
%% 
% # x(t - 4)
% # x(t/1.5)
% # x(-t)
% # x(2t - 4)
% # x(2 - t)
%
x = @(t) (-t).*((t>=-4) & (t<0))+t.*((t>=0) & (t<2));
t = -10:0.01:10;
figure
plot(t,x(t), 'k', 'LineWidth', 2); grid on
xlabel('t'); ylabel('x(t)'); title('x(t) = -t.*((t>=-4) & (t<0)) + t.*((t>=0) & (t<2)');
%%
% Para la graficación de las señales, únicamente se modifica el argumento
% de la señal anónima dentro del _plot_.
figure
plot(t,x(t-4), 'm', 'LineWidth', 2); grid on % 1)
xlabel('t'); ylabel('x(t)'); title('1. x(t - 4)');
figure
plot(t,x(t/1.5), 'c', 'LineWidth', 2); grid on % 2)
xlabel('t'); ylabel('x(t)'); title('2. x(t/1.5)');
figure
plot(t,x(-t), 'b', 'LineWidth', 2); grid on %3)
xlabel('t'); ylabel('x(t)'); title('3. x(-t)');
figure
plot(t,x(2*t-4), 'y', 'LineWidth', 2); grid on % 4)
xlabel('t'); ylabel('x(t)'); title('4. x(2t - 4)');
figure
plot(t,x(2-t), 'g', 'LineWidth', 2); grid on % 5)
xlabel('t'); ylabel('x(t)'); title('5. x(2 - t)');
%
%% Ejercicio 6.
% El concepto de energía de una señal se determina como $$ E_f = \int_{- \infty}^{\infty}|f(t)|^2 dx$
% 
% En Matlab, la hemos expresado como un archivo función llamado _energia.m_ donde
% quedó expresada como:
%
% <include>energia.m</include>
% 
% Para resolver el cálculo de la energía de una señal _f(t)_.
%
% * *Problema 1.1.3 (Lathi)*
% Encontrar la energía de _*x(t) + y(t)*_ y _*x(t) - y(t)*_ de los siguientes pares de señales _x(t)_ y _y(t)_:
%
%
p = @(dt) (dt>=-0.5) & (dt<0.5); %Se crea una función anónima para la representaión del pulso unitario.
dt = -2:0.001:3;

figure
plot(dt, p((dt-1)/2), 'r', 'LineWidth', 2); grid on
xlabel('t'); ylabel('x(t)'); title('x_a(t)');
figure
plot(dt, p(dt-0.5)-p(dt-1.5), 'r', 'LineWidth', 2); grid on
xlabel('t'); ylabel('y(t)'); title('y_a(t)');

dt = -2:0.001:3*pi; figure
plot(dt, sin(dt).*p((dt-pi)/(2*pi)), 'b', 'LineWidth', 2); grid on
xlabel('t'); ylabel('x(t)'); title('x_b(t)');
figure
plot(dt, p((dt-pi)/(2*pi)), 'b', 'LineWidth', 2); grid on
xlabel('t'); ylabel('y(t)'); title('y_b(t)');

dt = -2:0.001:2*pi; figure
plot(dt, sin(dt).*p((dt-pi/2)/pi), 'g', 'LineWidth', 2); grid on
xlabel('t'); ylabel('x(t)'); title('x_c(t)');
figure
plot(dt, p((dt-pi/2)/pi), 'g', 'LineWidth', 2); grid on
xlabel('t'); ylabel('y(t)'); title('y_c(t)');
%%
% Las señales de la forma *x(t) + y(t)* quedan:

dt = -2:0.001:3; figure
plot(dt, p((dt-1)/2) + p(dt-0.5)- p(dt-1.5), 'r', 'LineWidth', 2);
grid on
xlabel('t'); title('x_a(t) + y_a(t)');

dt = -2:0.001:3*pi; figure
plot(dt, sin(dt).*p((dt-pi)/(2*pi))+p((dt-pi)/(2*pi)), 'b', 'LineWidth', 2);
grid on
xlabel('t'); title('x_b(t) + y_b(t)');

dt = -2:0.001:2*pi; figure
plot(dt, sin(dt).*p((dt-pi/2)/pi)+p((dt-pi/2)/pi), 'g', 'LineWidth', 2);
grid on
xlabel('t'); title('x_c(t) + y_c(t)');
%%
% Para el cálculo de la energía, el método elegido consiste en tomar como
% vectores los trozos de la señal (uno de intervalos y el otro de las
% expresiones), donde el vector de expresiones se transforma en simbólica.
% En las variables _"E"_ se almacena el resultado de la integral.

syms t

Aa1 = [0 1];
f_a1 = [2]; f_a1 = sym(f_a1);
E_a1 = energia(f_a1, Aa1)

A_b1 = [0 2*pi];
f_b1 = [sin(t)+1]; f_b1 = sym(f_b1);
E_b1 = energia(f_b1, A_b1)

A_c1 = [0 pi];
f_c1 = [sin(t)+1]; f_c1 = sym(f_c1);
E_c1 = energia(f_c1, A_c1)

%%
% Las señales de la forma *x(t) - y(t)* quedan:

dt = -2:0.001:3; figure
plot(dt, p((dt-1)/2) - p(dt-0.5) + p(dt-1.5), 'r', 'LineWidth', 2);
grid on
xlabel('t'); title('x_a(t) - y_a(t)');

dt = -2:0.001:3*pi; figure
plot(dt, sin(dt).*p((dt-pi)/(2*pi)) - p((dt-pi)/(2*pi)), 'b', 'LineWidth', 2);
grid on
xlabel('t'); title('x_b(t) - y_b(t)');

dt = -2:0.001:2*pi; figure
plot(dt, sin(dt).*p((dt-pi/2)/pi) - p((dt-pi/2)/pi), 'g', 'LineWidth', 2);
grid on
xlabel('t'); title('x_c(t) - y_c(t)');
%%
% La energía de las señales _x(t)_ - _y(t)_ es:
Aa1 = [1 2];
f_a1 = [2]; f_a1 = sym(f_a1);
E_a1 = energia(f_a1, Aa1)

A_b1 = [0 2*pi];
f_b1 = [sin(t)-1]; f_b1 = sym(f_b1);
E_b1 = energia(f_b1, A_b1)

A_c1 = [0 pi];
f_c1 = [sin(t)-1]; f_c1 = sym(f_c1);
E_c1 = energia(f_c1, A_c1)

%% Ejercicio 7.
% El concepto de potencia de una señal se determina como $$ P_f =
% \frac{1}{T} \int_{- T/2}^{T/2}|f(t)|^2 dx$ para toda señal de Potencia.
% Cabe mencionar que toda señal Periódica es de Potencia.
% 
% En Matlab, la hemos expresado como un archivo función llamado _potencia.m_ donde
% quedó expresada como:
%
% <include>potencia.m</include>
% 
% Para resolver el cálculo de la potencia de una señal _f(t)_.
%
% * *Problema 1.1.4 (Lathi)*
% Encontrar la potencia de la señal periódica _x(t)_ (abajo se muestra graficada la señal
% contínua en un solo período), y sus variantes:
%%
% 
% # -x(t)
% # 2x(t)
% # cx(t)
%
% Como se puede observar en el punto 3, la señal está siendo multiplicada
% por un valor _"c"_; para poder utilizarlo en matlab, es necesario crear una
% variable simbólica _"c"_.
%%
%
dt = -4:0.001:4; figure
plot(dt, (dt.^3).*p(dt/4), 'y', 'LineWidth', 2); grid on
xlabel('t'); ylabel('x(t)'); title('x(t)');
%%
% La potencia de las señal x(t )quedaría como:
%
%%
syms t c
T = 4;
A = [-2 2];
fx = [t^3]; fx = sym(fx);
P = potencia(fx, T, A)
%%
% Para las modificaciones de la señal x(t), podemos observar las gráficas de las señales
% en un solo período (Nota: para la graficación de la señal número 3, se tomará el valor c = \frac{1}{2}):
%%
%
figure
plot(dt, (-dt.^3).*p(dt/4), 'c', 'LineWidth', 2); grid on
xlabel('t'); ylabel('x(t)'); title('- x(t)');
figure
plot(dt, (2*dt.^3).*p(dt/4), 'b', 'LineWidth', 2); grid on
xlabel('t'); ylabel('x(t)'); title('2x(t)');
figure
plot(dt, (0.5*dt.^3).*p(dt/4), 'LineWidth', 2); grid on
xlabel('t'); ylabel('x(t)'); title('c*x(t)');
%%
% Al calcular las potencias de las variantes de la señal x(t), éstas
% quedan:
%
fx1 = [-t^3]; fx1 = sym(fx1);
P1 = potencia(fx1, T, A)
fx2 = [2*t^3]; fx2 = sym(fx2);
P2 = potencia(fx2, T, A)
fx3 = [c*t^3]; fx3 = sym(fx3);
P2 = potencia(fx3, T, A)
%% Referencias.
% * EduRed, _MATLAB_, autor desconocido, fecha desconocida, de EcuRed, sitio web: https://www.ecured.cu/MATLAB
% * The MathWorks(2013), Publishing MATLAB Code from the Editor, 2013, de Matlab, sitio web: https://www.youtube.com/watch?v=CWgl5Ylltxk
% * Wikipedia (2001), GNU Octave, 2019, de Wikipedia, sitio web: https://es.wikipedia.org/wiki/GNU_Octave
% * Wikipedia (2001), Python, 2019, de Wikipedia, sitio web: https://es.wikipedia.org/wiki/Python
% * https://www.youtube.com/watch?v=cBTGMNaGGW4