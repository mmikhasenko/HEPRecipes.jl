# HEPRecipes

[![Build Status](https://travis-ci.com/mmikhasenko/HEPRecipes.jl.svg?branch=master)](https://travis-ci.com/mmikhasenko/HEPRecipes.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/mmikhasenko/HEPRecipes.jl?svg=true)](https://ci.appveyor.com/project/mmikhasenko/HEPRecipes-jl)
[![Codecov](https://codecov.io/gh/mmikhasenko/HEPRecipes.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/mmikhasenko/HEPRecipes.jl)


provides the tools for weighted histograms and a plotting recipe.

```julia
w = weightedHistogram(rand(1000), bins = 30)
plot(w)

sample = 2 .* rand(1000) .- 1
weights = randm(1000) * 0.3

plot(weightedHistogram(rand(1000), bins = 30, weights = weights))
```
<img src="plots/example.png" alt="gauss wights" style="width: 300px;"/>