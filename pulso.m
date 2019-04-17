function [ salida ] = pulso( t )

salida = 1*escalon(t+0.5)-1*escalon(t-0.5);

end

