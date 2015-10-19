function dist = gaussian_distance(f, alpha, beta, h, x)

mu = h*f*sqrt(1+(beta*h^2));
sigma = mu*(2^(alpha/1200)-1);

dist=normpdf(x,mu,sigma);