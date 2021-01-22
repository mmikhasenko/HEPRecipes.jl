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

const AbstractVectorReal = AbstractVector{T} where T <: Real

function weightedHistogram(values::V where V <: AbstractVectorReal,
    bins::E where E<:AbstractVector,
    weights::V where V <: AbstractVectorReal)
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

# bins::Integer
weightedHistogram(values::V where V <: AbstractVectorReal,
    bins::E where E<:Integer;
    weights::V where V <: AbstractVectorReal = one.(values)) =
        weightedHistogram(values, range(extrema(values)..., length=bins), weights)

# weights in kw
weightedHistogram(values::V where V <: AbstractVectorReal,
    bins::E where E<:AbstractVector;
    weights::V where V <: AbstractVectorReal = one.(values)) = weightedHistogram(values, bins, weights)

# weights, bins in kw
weightedHistogram(values::V where V <: AbstractVectorReal;
    bins::Union{<:Integer,<:AbstractVector} = 30,
    weights::V where V <: AbstractVectorReal = one.(values)) = weightedHistogram(values, bins, weights=weights)
