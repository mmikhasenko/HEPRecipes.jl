
# poissonquantile(n) = [
#     n==0 ? 0.0 : quantile(Chisq(n), 0.159),
#     quantile(Chisq(2*(n+1)), 1-0.159)] ./ 2
# naivequantile(n) = [n-sqrt(n), n+sqrt(n)]

# const poissonerr = [poissonquantile(n) for n in 0:100];

const poissonerr = [
    [0.0, 1.838851076761905], [0.020123093733916905, 3.296697866399274],
    [0.173163619009189, 4.6345507336608875], [0.4176633833250008, 5.914479679188524],
    [0.7091735948304174, 7.158700455531753], [1.0292239289130758, 8.378108507829323],
    [1.3687423128942924, 9.578992181272188], [1.7225775474312341, 10.765366657764186],
    [2.0874953911076477, 11.93997939698542], [2.461314679469236, 13.104807798135454],
    [2.842484490497317, 14.261330958821924], [3.2298563571383805, 15.410689401090716],
    [3.6225521367066253, 16.553784484708252], [4.019882753118698, 17.69134319130975],
    [4.4212958064674375, 18.823961964764877], [4.826340452880678, 19.952137329234912],
    [5.234643080552287, 21.076287853168505], [5.645889989437562, 22.1967702723296],
    [6.05981476039222, 23.313891564510037], [6.476188851231584, 24.427918152695682],
    [6.894814466904441, 25.539083029472483], [7.315519066300482, 26.647591349142353],
    [7.7381510690369355, 27.753624871980865], [8.16257645681226, 28.85734553605287],
    [8.588676051676018, 29.958898357166845], [9.016343313471642, 31.05841380523435],
    [9.445482540370776, 32.15600976812415], [9.876007385883472, 33.251793187279134],
    [10.307839626891383, 34.34586142974826], [10.740908132665263, 35.438303446756144],
    [11.1751479962014, 36.529200758044915], [11.610499797703657, 37.6186282929761],
    [12.04690897644852, 38.70665511307066], [12.484325292159685, 39.7933450357933],
    [12.922702360783255, 40.87875717559208], [13.361997252478202, 41.962946415224344],
    [13.802170141927066, 43.04596381804241], [14.243184002879087, 44.12785699003307],
    [14.68500434027511, 45.20867039889818], [15.127598954453717, 46.288445656246395],
    [15.570937732864735, 47.36722176797792], [16.01499246546753, 48.445035357136916], 
    [16.45973668060356, 49.521920862843686], [16.905145498634774, 50.597910718371466],
    [17.35119550105274, 51.6730355109793], [17.797864613105833, 52.74732412573457],
    [18.245131998276445, 53.82080387524273], [18.69297796317817, 54.89350061693583],
    [19.141383871642404, 55.96543885934793], [19.590332066931957, 57.03664185861526],
    [20.039805801161457, 58.10713170627818], [20.48978917112495, 59.17692940932434],
    [20.940267059833843, 60.24605496329476], [21.391225083156296, 61.314527419174055],
    [21.8426495410242, 62.382364944698416], [22.294527372738987, 63.44958488064066],
    [22.746846115962978, 64.5162037925661], [23.199593869031663, 65.58223751849708],
    [23.652759256263924, 66.64770121287437], [24.106331395983872, 67.71260938716142],
    [24.560299870999607, 68.77697594739928], [25.01465470131211, 69.84081422898767],
    [25.469386318851708, 70.90413702893844], [25.924485544061053, 71.96695663582253],
    [26.379943564162236, 73.02928485760867], [26.835751912962383, 74.09113304757257],
    [27.29190245206665, 75.15251212843742], [27.748387353380586, 76.21343261489143],
    [28.205199082795303, 77.27390463461316], [28.662330384959226, 78.33393794792454],
    [29.119774269049223, 79.39354196617872], [29.57752399546212, 80.45272576898152],
    [30.03557306335486, 81.51149812033526], [30.49391519896814, 82.56986748378634],
    [30.952544344674045, 83.62784203665086], [31.411454648693663, 84.68542968338575],
    [31.87064045543518, 85.74263806816731], [32.33009629640735, 86.79947458673415],
    [32.789816881666965, 87.8559463975459], [33.24979709176253, 88.91206043230599],
    [33.710031970139326, 89.96782340589162], [34.17051671597401, 91.02324182573192],
    [34.63124667740944, 92.07832200067062], [35.09221734516272, 93.13307004934804],
    [35.55342434648161, 94.18749190813342], [36.01486343942637, 95.24159333863713],
    [36.47653050745587, 96.29537993482926], [36.93842155429842, 97.34885712978978],
    [37.40053269908923, 98.40203020211322], [37.86286017175776, 99.45490428198924],
    [38.325400308649385, 100.50748435697882], [38.78814954836707, 101.55977527750473],
    [39.251104427819676, 102.61178176207308], [39.714261578464416, 103.66350840224206],
    [40.177617722731995, 104.71495966735264], [40.64116967062369, 105.76613990903502],
    [41.10491431647037, 106.81705336550353], [41.568848635844056, 107.86770416565227],
    [42.03296968261348, 108.91809633296259], [42.49727458613543, 109.96823378923257],
    [42.96176054857424, 111.01812035813877]];
# 
# 
yerror_poisson(n) = n ≤ 100 ?
    (poissonerr[n+1] .- n).*[-1, 1] :
    sqrt(n).*[1,1] # error of < 5% when n > 100
