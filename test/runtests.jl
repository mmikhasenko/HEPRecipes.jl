using Test
using HEPRecipes
using Plots

sample = rand(100)
bins = -1:0.3:2
weights = rand(length(sample))
weights .= weights ./ sum(weights) .* length(weights)
# 
w0 = weightedHistogram(sample, bins=bins, weights=one.(weights))

@testset "weightedHistogram" begin
    @test w0.bins == bins
    @test sum(sum, w0.aow) ≈ sum(length, w0.aow)
    
    w1 = weightedHistogram(sample, range(bins[1],bins[end],length=length(bins)))
    @test prod(w0.aow .≈ w1.aow)

    @test sum(weights) ≈ length(weights)
    w2 = weightedHistogram(sample;  bins=bins, weights=weights)
    @test sum(sum, w2.aow) ≈ sum(length, w2.aow)

    w3 = weightedHistogram(sample, bins; weights=weights)
    @test prod(w3.aow ≈ w2.aow)
end

# errorhist(randn(1000), bins=range(-3,3, length=100))

@testset "interfaces" begin
    @test nbins(w0) == length(bins)-1
    @test prod(entries(w0) .== length.(w0.aow))
    @test prod(contents(w0) .≈ sum.(w0.aow))
    @test prod(bincenters(w0) .≈ (w0.bins[2:end] + w0.bins[1:end-1]) / 2)
    @test prod(yerror_sqrtn(w0) .≈ sqrt.(sum.(abs2, w0.aow)))
    @test prod(xerror(w0) .≈ (w0.bins[2:end] - w0.bins[1:end-1]) / 2)
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
    # savefig(joinpath("plots","example.png"))
    @test true
end


@testset "pull" begin
    f(x;μ=0.5,σ=0.1) = 1/sqrt(2π)/σ * exp(-(x-μ)^2/2/σ^2)
    sample = rand(10_000)
    w5 = weightedHistogram(sample, bins=10, weights=f.(sample))
    g(x) = f(x)*sum(entries(w5))
    p = pull(w5, g)
    @test hasproperty(p, :wh)
    @test hasproperty(p, :g)
    @test sum(plot(p)[1][3][:y])/nbins(w5) < 1
end

