module HEPRecipes

using RecipesBase

export weightedHistogram
export entries, contents, bincenters
export yerror, xerror
include("weightedHistogram.jl")

include("recipe.jl")


end # module
