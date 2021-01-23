
abstract type PropODE end

struct GenerativePropODE{T <: Real, R <: Real, S <: Real, M <: Function} <: PropODE
    x₀ :: Vector{T}
    F :: Vector{M}
    p :: Matrix{R}
    g :: SimpleGraph
    τ :: Vector{S}
end

abstract type InferablePropODE <: PropODE end

struct ModelPropODE{T <: Real, R <: Real, S <: Real, M <: Function} <: InferablePropODE
    x₀ :: Vector{T}
    F :: Vector{M}
    p :: Matrix{R}
    prob :: GRNProblem
    τ :: Vector{S}
end

struct DeepPropODE{T <: Real, R <: Real, S <: Real} <: InferablePropODE
    x₀ :: Vector{T}
    F :: Vector{FastChain}
    p :: Matrix{R}
    prob :: GRNProblem
    τ :: Vector{S}
end

### Generative Portion ###

get_graph(prop :: GenerativePropODE) = prop.g
get_graph(prop :: T) where {T <: InferablePropODE} = prop.prob.g

function generate(g :: PropODE)
    function dynamic_system!(du, u, p, t)
        for (i, f) ∈ enumerate(g.F)
            n = neighbors(get_graph(g), i)
            du[i] = f(u[n], p[i, n], t)
        end
    end

    tspan = (g.τ[1], g.τ[end])
    prob = ODEProblem(dynamic_system!, g.x₀, tspan, g.p, saveat = g.τ)
    return solve(prob)
end

### Inference Portion ###
