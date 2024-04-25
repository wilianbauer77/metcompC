#import Pkg; Pkg.add("Plots")
using Plots
Plots.default(show = true)
L=100
tmax=10
k=0.5
x=collect(1:1:L)
f=zeros(L)
g=zeros(L)
sigma=4
@. f=exp(-(x-L/3)^2/(2*sigma^2))
#p=plot(f)
function ftcs(f,g)
t=0.
dt=0.1
while  t< tmax
t+=dt
g[2:end-1]=0.5*(f[1:end-2]+f[3:end])-k*(f[3:end]-f[1:end-2])
#g[2:end-1]=f[2:end-1]-k*(f[3:end]-f[1:end-2])
g[1]=0.5*(f[end]+f[2])-k*(f[2]-f[end])
g[end]=0.5*(f[end-1]+f[1])-k*(f[1]-f[end-1])
f=copy(g)
plot(f)
end
return
end

#@time ftcs(f,g)
plot!(f)
@time ftcs(f,g)
#display(p)
readline()
