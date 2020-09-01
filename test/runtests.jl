using Test
using HEPRecipes
using Plots

sample = rand(100)
bins = -1:0.3:2
weights = rand(length(sample))
# 
w0 = weightedHistogram(sample, bins=bins, weights=one.(weights))

@testset "weightedHistogram" begin
    @test w0.bins == bins
    @test sum(sum, w0.aow) ≈ sum(length, w0.aow)
    
    w1 = weightedHistogram(sample, range(bins[1],bins[end],length=length(bins)))
    @test prod(w0.aow .≈ w1.aow)

    w2 = weightedHistogram(sample;  bins=12, weights=weights)
    @test sum(sum, w2.aow) ≈ sum(length, w2.aow)

    w3 = weightedHistogram(sample, 12; weights=weights)
    @test prod(w3.aow ≈ w2.aow)
end

@testset "recipe" begin
    p = plot(w0)
    @test length(p[1][1][:x]) == (length(bins)-1)*3 # x markers
    @test length(p[1][2][:y]) == (length(bins)-1)*3 # y markers
    @test length(p[1][3][:x]) == length(bins)-1 # dot markers
end

@testset "saveplot" begin
    sample = 2 .* rand(1000) .- 1
    weights = map(x->exp(-x^2/2/0.3^2), sample)
    # 
    plot(weightedHistogram(sample, bins = 30, weights = weights))
    savefig(joinpath("plots","example.png"))
    @test true
end