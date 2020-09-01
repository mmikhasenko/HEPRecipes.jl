module HEPRecipes

using RecipesBase
using QuadGK

export weightedHistogram
export entries, contents, bincenters, nbins
export yerror, xerror
include("weightedHistogram.jl")

export pull
include("recipe.jl")

end # module
