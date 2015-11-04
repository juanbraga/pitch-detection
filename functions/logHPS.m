function P=logHPS(S,k)
%logHPS Writting help text undone!

[n,m]=size(S);

aHPS=2*log10(abs(S));

for i=2:k
   aHPS = aHPS + [2*log10(abs(S(1:i:n,:))) ; zeros(n-ceil(n/i),m)];
   figure
   imagesc(aHPS), axis xy;
   pause
end

P=aHPS;

end
