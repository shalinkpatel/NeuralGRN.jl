abstract type GRNProblem end

struct SteadyStateGRNProblem{T <: Real, R <: Real} <: GRNProblem
    g :: SimpleGraph
    names :: Vector{String}
    expression :: Vector{T}
    τ :: Vector{R}
end

struct TemporalGRNProblem{T <: Real, R <: Real} <: GRNProblem
    g :: SimpleGraph
    names :: Vector{String}
    expression :: Matrix{T}
    τ :: Vector{R}
end

function SteadyStateGRNProblem{T, R}(g :: SimpleGraph, expression :: Vector{T}) where {T <: Real, R <: Real}
    return SteadyStateGRNProblem{T, R}(g, string.(1:nv(g)), expression)
end

function SteadyStateGRNProblem{T, R}(g :: SimpleGraph, names :: Vector{String}, expression :: Vector{T}) where {T <: Real, R <: Real}
    @assert length(expression) == nv(g) "Length of expression vector must match number of nodes"

    return SteadyStateGRNProblem{T, R}(g, names, expression, R.(range(0, 1; length = 2)))
end

function TemporalGRNProblem{T, R}(g :: SimpleGraph, expression :: Matrix{T}) where {T <: Real, R <: Real}
    return TemporalGRNProblem{T, R}(g, string.(1:nv(g)), expression)
end

function TemporalGRNProblem{T, R}(g :: SimpleGraph, names :: Vector{String}, expression :: Matrix{T}) where {T <: Real, R <: Real}
    @assert size(expression, 1) == nv(g) "First dimension of expression matrix must match number of nodes"

    return TemporalGRNProblem(g, names, expression, R.(range(0, 1; length = size(expression, 2))))
end

plot_problem_graph(prob :: GRNProblem) = graphplot(prob.g, names=prob.names)
