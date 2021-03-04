module HEPRecipes

using RecipesBase
using QuadGK

export weightedHistogram
export entries, contents, bincenters, nbins
export yerror_sqrtn, yerror_poisson
export xerror
include("weightedHistogram.jl")


export pull
include("poisson_errors.jl")
include("recipe.jl")

end # module
