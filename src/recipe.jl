# 
@recipe function f(w::weightedHistogram)
    x := bincenters(w.bins)
    y := sum.(w.aow)
    xerror --> bindiffs(w.bins) / 2
    yerror := yerror(w)
    seriestype := :scatter
    ()
end

struct pull
    wh::weightedHistogram
    g::Function
end

@recipe function f(p::pull)
    integrals = [quadgk(p.g, l, r)[1] for (l,r) in zip(p.wh.bins[1:end-1], p.wh.bins[2:end])]
    x := bincenters(p.wh)
    y := (contents(p.wh) .- integrals) ./ yerror(p.wh)
    xerror --> xerror(p.wh)
    yerror := one.(yerror(p.wh))
    seriestype := :scatter
    ()
end
