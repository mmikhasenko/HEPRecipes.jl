struct weightedHistogram{T<:AbstractVector, E<:AbstractVector}
    aow::Vector{T}
    bins::E
end

function weightedHistogram(values::Array{T} where T<:Real,
    bins::E where E<:AbstractVector,
    weights::Array{T} where T<:Real)
    # normalize the weights
    filt = map(x->bins[1]<x<bins[end], values)
    weights_in_range = weights[filt]
    values_in_range = values[filt]
    nweights = weights_in_range ./ sum(weights_in_range) .* length(weights_in_range)
    # 
    weightedHistogram(
        bins,
        [nweights[map(x->l<x<r, values_in_range)]
                    for (l,r) in zip(bins[1:end-1], bins[2:end])]
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
