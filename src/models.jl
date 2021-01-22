
abstract type PropODE end

struct GenerativePropODE{T <: Real, R <: Real, S <: Real} <: PropODE
    x₀ :: Vector{T}
    F :: Vector{Function}
    p :: Matrix{R}
    τ :: Vector{S}
end

abstract type InferablePropODE <: PropODE end

struct ModelPropODE{T <: Real, R <: Real} <: InferablePropODE
    x₀ :: Vector{T}
    F :: Vector{Function}
    p :: Vector{R}
    prob :: GRNProblem
end

struct DeepPropODE{T <: Real} <: InferablePropODE
    x₀ :: Vector{T}
    F :: Vector{FastChain}
    prob :: GRNProblem
end

function generate()
