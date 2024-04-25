using Plots
Plots.default(show=true)
L = 100
D = 1
S = 0.5
x = collect(1:1:L)
f=zeros(L)
f[1]=0
f[L]=0
s=zeros(L)
sigma = 4
@. s=exp(-(x-L/2)^2/(2sigma^2))
s[2]+=D*f[L]
s[L-1]+=D*f[L]
M = [if i==j; (-2*D-S) elseif i==j+1 || i==j-1; -D else 0 end for i=2:L-1, j=2:L-1]
IM = inv(M)
f[2:L-1]=-IM*s[2:L-1]
p=plot(f)
@time ftcs(f,IA)
display(p)
readline()