# 
# @recipe function f(w::weightedHistogram)
#     x := bincenters(w.bins)
#     y := sum.(w.aow)
#     xerror --> bindiffs(w.bins) / 2
#     yerror := yerror_sqrtn(w)
#     seriestype := :scatter
#     ()
# end

@recipe function f(w::weightedHistogram; errortype=:poisson)
    x := bincenters(w.bins)
    y := sum.(w.aow)
    xerror --> bindiffs(w.bins) / 2
    # 
    if errortype == :poisson
        pois = yerror_poisson.(length.(w.aow))
        yerror = (getindex.(pois,1), getindex.(pois,2))
    elseif errortype == :sqrtn
        yerror = yerror_sqrtn(w)
    end
    # 
    yerror := yerror
    seriestype := :scatter
    ()
end


@userplot ErrorHist

@recipe function f(h::ErrorHist)
    w = haskey(plotattributes,:bins) ?
        weightedHistogram(h.args..., bins=plotattributes[:bins]) :
        weightedHistogram(h.args...)
    delete!(plotattributes, :bins)
    (w,)
end

struct pull
    wh::weightedHistogram
    g::Function
end

@recipe function f(p::pull; errortype=:sqrtn)
    integrals = [quadgk(p.g, l, r)[1] for (l,r) in zip(p.wh.bins[1:end-1], p.wh.bins[2:end])]
    x := bincenters(p.wh)
    y := (contents(p.wh) .- integrals) ./ yerror_sqrtn(p.wh)
    xerror --> xerror(p.wh)
    yerror := one.(yerror_sqrtn(p.wh))
    seriestype := :scatter
    ()
end
# 

