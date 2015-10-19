function [G f]=GLogS(fi,ff,fmax,S,F)

[n,m]=size(S);

f=fi;
i=1;
while f(i)<ff
    i=i+1;
    f(i)=f(i-1)*(2^(1/24));
end

aG=zeros(length(f),m);
for i=1:length(f)
    j=1;
    while (j*f(i)<fmax)
        [v,ind]=min(abs(F-j*f(i)));
        aG(i,:)=aG(i,:)+log(abs(S(ind,:)));
        j=j+1;
    end
    aG(i,:)=aG(i,:)/(j-1);
end

G=aG;