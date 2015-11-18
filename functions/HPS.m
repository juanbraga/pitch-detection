function P=HPS(S,k)
%HPS Writting help text undone!

[n,m]=size(S);

aHPS=abs(S);

for i=2:k
   aHPS=aHPS.*[abs(S(1:i:n,:)) ; ones(n-ceil(n/i),m)];
%    figure
%    imagesc(10*log10(aHPS)), axis xy;
%    pause
end

P=aHPS;

end