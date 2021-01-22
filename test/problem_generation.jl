using NeuralGRN, LightGraphs, Plots
using Test

@testset "Problem Construction Test" begin
    g = complete_graph(3)
    @test_throws AssertionError SteadyStateGRNProblem{Int64, Float32}(g, [1, 2])
    @test_throws AssertionError TemporalGRNProblem{Int64, Float32}(g,  [1 2 3; 4 5 6])

    @test TemporalGRNProblem{Int64, Float32}(g, [1 2; 3 4; 5 6]).names == string.(1:3)
end

@testset "Plotting Tests" begin
    g = complete_graph(3)

    @test typeof(plot_problem_graph(TemporalGRNProblem{Int64, Float32}(g,
        [1 2; 3 4; 5 6]))) == Plots.Plot{Plots.GRBackend}
end
