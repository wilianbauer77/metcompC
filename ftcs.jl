import Pkg; Pkg.add("Plots")
using Plots
Plots.default(show = true)
L=100
tmax=40
k=0.5
x=[1;2:L-1;L]
f=zeros(L)
f[1]=1
plot(x,f)
t=0.
dt=0.1
while  t< tmax
global t+=dt
f[2:L-1]=f[2:L-1]+k*(f[1:L-2]+f[3:L]-2f[2:L-1])
end
println(f)
plot!(x,f)
#display(p)

