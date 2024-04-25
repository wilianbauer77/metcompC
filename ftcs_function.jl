#import Pkg; Pkg.add("Plots")
using Plots
Plots.default(show = true)
L=100
tmax=500
k=0.5
#x=Vector[1:1:L]
f=zeros(L)
f[1]=1
#p=plot(f)
function ftcs(f,L)
t=0.
dt=0.1
while  t< tmax
t+=dt
f[2:end-1]=f[2:end-1]+k*(f[1:end-2]+f[3:end]-2f[2:end-1])
end
return
end

@time ftcs(f,L)
#p=plot!(f)
@time ftcs(f,L)
#display(p)
