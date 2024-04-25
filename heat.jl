#using PlotlyJS
using Plots

#Plots.default(show=true)
L = 50
f=rand(Float64,(50,50))
#D = 1
#S = 0.5
x = collect(1:1:L)
l1=0.1; l2=0.3
@. f[1:50,1]=exp(-(l1*x))
@. f[1:50,50]=exp(-(l2*x))
alpha=0.5
maxi=200
tol=0.1

#while maxi>tol
while i<50
    global i=i+1 
g=copy(f)

#@. f[L,1:50]=1
#@. f[50,1:50]=0
#s=zeros(L)
#sigma = 4
#@. s=exp(-(x-L/2)^2/(2sigma^2))
#s[2]+=D*f[L]
#s[L-1]+=D*f[L]
#M = [if i==j; (-2*D-S) elseif i==j+1 || i==j-1; -D else 0 end for i=2:L-1, j=2:L-1]
#IM = inv(M)
f[2:L-1,2:L-1]=-alpha*f[2:L-1,2:L-1]+(1+alpha)

global maxi=maximum(abs.(f-g))
print($maxi\n)
end
#p=plot(heatmap(M))
#@time ftcs(f,IA)
#display(p)
#readline()