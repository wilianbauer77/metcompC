using Plots

function iterate_and_display_heatmaps(f, g, alpha, tol)
    L = size(f, 1)
    iter = 0
    #g=copy(f)
    while true #Explicito
        iter += 1
        for i in 2:L-1, j in 2:L-1
         g[i, j] = -alpha*f[i,j]+(1+alpha)*(g[i-1, j] + f[i+1, j] + g[i, j-1] + f[i, j+1]) / 4
        end
#a linha abaixo não funcionou corretamente comparado com a de cima e um programa equivalente em fortran90
#	f[2:L-1, 2:L-1] = (f[1:L-2, 2:L-1] + f[3:L, 2:L-1] + f[2:L-1,1:L-2] + f[2:L-1, 3:L]) / 4
        maxi = maximum(abs.(f - g))
	f= copy(g)
	print("$iter, $maxi\n")
#   	 g=copy(f)
        if maxi <= tol
	#    title = "Iteration $iter (MaxDif: $(string(round(maxi,digits=4))))"
        #    p = heatmap(f,  title=title, xlabel="x", ylabel="y")
        #    display(p)
            break
        end
	title = "Iteration $i (MaxDif: $(string(round(maxi,digits=7))))"
        p = heatmap(f,  title=title, xlabel="x", ylabel="y")
        display(p)
        sleep(0.1)
    end
    return f
end

L = 100
f = rand(Float64, L, L)
#f = zeros(Float64,L,L)
#f = ones(Float64,L,L)
@. f[1, 1:L] = 1
@. f[L, 1:L] = 0
x = collect(1:1:L)
l1 = 0.1; l2 = 0.3
@. f[1:L, 1] = exp(-(l1 * x))
@. f[1:L, L] = exp(-(l2 * x))
g = copy(f)
alpha = 0.935 #valor que minimiza o número de iterações
#alpha = 0.5
tol = 0.00001

@time iterate_and_display_heatmaps(f, g, alpha, tol)
readline()
