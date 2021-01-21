struct weightedHistogram{T<:AbstractVector, E<:AbstractVector}
    aow::Vector{T}
    bins::E
end

bincenters(x::T where T<:AbstractArray) = (x[1:end-1] + x[2:end]) ./ 2
bindiffs(x::T where T<:AbstractArray) = x[2:end]- x[1:end-1]
# 
entries(w::weightedHistogram) = length.(w.aow)
contents(w::weightedHistogram) =  sum.(w.aow)
bincenters(w::weightedHistogram) = bincenters(w.bins)
nbins(w::weightedHistogram) = length(w.bins)-1
yerror(w::weightedHistogram) =  sqrt.(sum.(abs2, w.aow))
xerror(w::weightedHistogram) =  bindiffs(w.bins) ./ 2

function weightedHistogram(values::Array{T} where T<:Real,
    bins::E where E<:AbstractVector,
    weights::Array{T} where T<:Real)
    # normalize the weights
    filt = map(x->bins[1]<x<bins[end], values)
    weights_in_range = weights[filt]
    values_in_range = values[filt]
    # 
    weightedHistogram(
        [weights_in_range[map(x->l<x<r, values_in_range)]
                    for (l,r) in zip(bins[1:end-1], bins[2:end])],
        bins
    )
end

weightedHistogram(values::Array{T} where T<:Real,
    bins::E where E<:Integer;
    weights::Array{T} where T<:Real = one.(values)) =
        weightedHistogram(values, range(extrema(values)..., length=bins), weights)

weightedHistogram(values::Array{T} where T<:Real,
    bins::E where E<:AbstractVector;
    weights::Array{T} where T<:Real = one.(values)) = weightedHistogram(values, bins, weights)

weightedHistogram(values::Array{T} where T<:Real;
    bins::Union{<:Integer,<:AbstractVector} = 30,
    weights::Array{T} where T<:Real = one.(values)) = weightedHistogram(values, bins, weights=weights)
