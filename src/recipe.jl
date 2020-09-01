# 
@recipe function f(w::weightedHistogram)
    x := bincenters(w.bins)
    y := sum.(w.aow)
    xerror := bindiffs(w.bins) / 2
    yerror := yerror(w)
    seriestype := :scatter
    ()
end
