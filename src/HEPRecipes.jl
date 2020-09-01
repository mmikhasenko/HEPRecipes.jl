module HEPRecipes

using RecipesBase

export weightedHistogram
export entries, contents, bincenters, nbins
export yerror, xerror
include("weightedHistogram.jl")

include("recipe.jl")


end # module
