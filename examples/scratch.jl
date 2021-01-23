using NeuralGRN, LightGraphs, Plots, StatsPlots, LinearAlgebra, Distributions
theme(:juno)

n = 10
x₀ = rand(Normal(0, 0.2), n)
g = erdos_renyi(n, 0.5)
p = rand(Normal(), n, n)
propogate(u, p, t) = 10 * (u ⋅ p) * cos(5 * t) * exp(-0.5*t)
τ = 0:0.01:3 |> Array

plot(g, names=string.(1:n), fmt = :svg)
plot(generate(GenerativePropODE(x₀, fill(propogate, n), p, g, τ)), fmt = :svg,
    legend=:outertopright)
