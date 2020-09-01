centers(x) = (x[1:end-1] + x[2:end]) ./ 2
diff(x) = x[2:end]- x[1:end-1]
# 
@recipe function f(w::weightedHistogram)
    x := centers(w.bins)
    y := sum.(w.aow)
    xerror := diff(w.bins) / 2
    yerror := sqrt.(sum.(abs2, w.aow))
    seriestype := :scatter
    ()
end
