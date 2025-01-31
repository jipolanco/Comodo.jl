using Test, Comodo, GeometryBasics

@testset "dist" verbose = true begin

    v1 = Float64[0, 0, 0]
    v2 = Float64[0, 0, 5]

    result = dist(v1, v2)

    @test result == [0.0 0.0 5.0; 0.0 0.0 5.0; 0.0 0.0 5.0]
end

@testset "gridpoints" verbose = true begin

    @testset "with 1 vector" begin
        a = Float64[1, 2, 3]

        expected = Point3{Float64}[
            [1.0, 1.0, 1.0],
            [1.0, 1.0, 2.0],
            [1.0, 1.0, 3.0],
            [1.0, 2.0, 1.0],
            [1.0, 2.0, 2.0],
            [1.0, 2.0, 3.0],
            [1.0, 3.0, 1.0],
            [1.0, 3.0, 2.0],
            [1.0, 3.0, 3.0],
            [2.0, 1.0, 1.0],
            [2.0, 1.0, 2.0],
            [2.0, 1.0, 3.0],
            [2.0, 2.0, 1.0],
            [2.0, 2.0, 2.0],
            [2.0, 2.0, 3.0],
            [2.0, 3.0, 1.0],
            [2.0, 3.0, 2.0],
            [2.0, 3.0, 3.0],
            [3.0, 1.0, 1.0],
            [3.0, 1.0, 2.0],
            [3.0, 1.0, 3.0],
            [3.0, 2.0, 1.0],
            [3.0, 2.0, 2.0],
            [3.0, 2.0, 3.0],
            [3.0, 3.0, 1.0],
            [3.0, 3.0, 2.0],
            [3.0, 3.0, 3.0],
        ]

        result = gridpoints(a)

        @test result == expected
    end

    @testset "with 2 vectors" begin
        a = Float64[1, 2, 3]
        b = Float64[2, 3, 5]

        expected = Point3{Float64}[
            [1.0, 2.0, 1.0],
            [1.0, 2.0, 2.0],
            [1.0, 2.0, 3.0],
            [1.0, 3.0, 1.0],
            [1.0, 3.0, 2.0],
            [1.0, 3.0, 3.0],
            [1.0, 5.0, 1.0],
            [1.0, 5.0, 2.0],
            [1.0, 5.0, 3.0],
            [2.0, 2.0, 1.0],
            [2.0, 2.0, 2.0],
            [2.0, 2.0, 3.0],
            [2.0, 3.0, 1.0],
            [2.0, 3.0, 2.0],
            [2.0, 3.0, 3.0],
            [2.0, 5.0, 1.0],
            [2.0, 5.0, 2.0],
            [2.0, 5.0, 3.0],
            [3.0, 2.0, 1.0],
            [3.0, 2.0, 2.0],
            [3.0, 2.0, 3.0],
            [3.0, 3.0, 1.0],
            [3.0, 3.0, 2.0],
            [3.0, 3.0, 3.0],
            [3.0, 5.0, 1.0],
            [3.0, 5.0, 2.0],
            [3.0, 5.0, 3.0],
        ]

        result = gridpoints(a, b)

        @test result == expected
    end

    @testset "with 3 vectors" begin
        a = Float64[1, 2, 3]
        b = Float64[2, 3, 5]
        c = Float64[5, 6, 4]

        expected = GeometryBasics.Point3{Float64}[
            [1.0, 2.0, 5.0],
            [1.0, 2.0, 6.0],
            [1.0, 2.0, 4.0],
            [1.0, 3.0, 5.0],
            [1.0, 3.0, 6.0],
            [1.0, 3.0, 4.0],
            [1.0, 5.0, 5.0],
            [1.0, 5.0, 6.0],
            [1.0, 5.0, 4.0],
            [2.0, 2.0, 5.0],
            [2.0, 2.0, 6.0],
            [2.0, 2.0, 4.0],
            [2.0, 3.0, 5.0],
            [2.0, 3.0, 6.0],
            [2.0, 3.0, 4.0],
            [2.0, 5.0, 5.0],
            [2.0, 5.0, 6.0],
            [2.0, 5.0, 4.0],
            [3.0, 2.0, 5.0],
            [3.0, 2.0, 6.0],
            [3.0, 2.0, 4.0],
            [3.0, 3.0, 5.0],
            [3.0, 3.0, 6.0],
            [3.0, 3.0, 4.0],
            [3.0, 5.0, 5.0],
            [3.0, 5.0, 6.0],
            [3.0, 5.0, 4.0],
        ]

        result = gridpoints(a, b, c)

        @test result == expected
    end

    @testset "Equality of several results" begin
        a = Float64[1, 2, 3]

        result1 = gridpoints(a)
        result2 = gridpoints(a, a)
        result3 = gridpoints(a, a, a)

        @test allequal([result1, result2, result3])
    end
end


@testset "geosphere(3,1.0)" begin
    F, V = geosphere(3, 1.0)

    @test F isa Vector{TriangleFace{Int64}}
    @test length(F) == 1280

    @test V isa Vector{Point3{Float64}}
    @test length(V) == 642
end

@testset "simplexcenter" begin

    eps = 0.001

    F, V = geosphere(3, 1.0)
    VC = simplexcenter(F, V)

    @test typeof(VC) == Vector{Point3{Float64}}
    @test length(VC) == 1280
    @test isapprox(VC[1], [-0.35520626817942325, 0.0, -0.9299420831107401], atol=eps)

end


@testset "remove unused vertices" begin
    F, V = geosphere(3, 1.0)
    VC = simplexcenter(F, V)
    F = [F[i] for i in findall(map(v -> v[3] > 0, VC))] # Remove some faces
    F, V = remove_unused_vertices(F, V)

    @test F isa Vector{TriangleFace{Int64}}
    @test length(F) == 624

    @test V isa Vector{Point3{Float64}}
    @test length(V) == 337
end


@testset "boundry edges" begin
    F, V = geosphere(3, 1.0)
    VC = simplexcenter(F, V)
    F = [F[i] for i in findall(map(v -> v[3] > 0, VC))] # Remove some faces
    F, V = remove_unused_vertices(F, V)
    Eb = boundaryedges(F)

    @test typeof(Eb) == Vector{LineFace{Int64}}
    @test length(Eb) == 48
    @test Eb[1] == [272, 205]
end

@testset "edges to curve" begin
    F, V = geosphere(3, 1.0)
    VC = simplexcenter(F, V)
    F = [F[i] for i in findall(map(v -> v[3] > 0, VC))] # Remove some faces
    F, V = remove_unused_vertices(F, V)
    Eb = boundaryedges(F)
    ind = edges2curve(Eb)

    @test length(ind) == 49
    @test ind ==
          [272, 205, 329, 168, 309, 184, 270, 145, 306, 220, 334, 223, 305, 138, 320, 204, 292, 232, 336, 234, 311, 203, 269, 115, 303, 194, 321, 133, 312, 207, 271, 164, 308, 209, 330, 231, 307, 154, 327, 206, 301, 240, 335, 229, 310, 196, 304, 208, 272]
end


@testset "mesh" begin
    F, V = geosphere(3, 1.0)
    VC = simplexcenter(F, V)
    F = [F[i] for i in findall(map(v -> v[3] > 0, VC))] # Remove some faces
    F, V = remove_unused_vertices(F, V)

    M = GeometryBasics.Mesh(V, F)

    @test typeof(M) == Mesh{3,Float64,GeometryBasics.Ngon{3,Float64,3,Point3{Float64}},SimpleFaceView{3,Float64,3,Int64,Point3{Float64},TriangleFace{Int64}}}
    @test length(M) == 624
    @test M[1][1] == [-0.5642542117657715, -0.5133754412304479, 0.6465777917977317]

end


@testset "circle points" begin

    @testset "with value" begin
        V1 = circlepoints(1.0, 40)

        @test V1 isa Vector{Point3{Float64}}
        @test length(V1) == 40
        @test V1[1] == [1.0, 0.0, 0.0]
    end

    @testset "with function" begin
        r = 1.0
        n = 40
        rFun(t) = r + 0.5 .* sin(3 * t)
        V2 = circlepoints(rFun, n)

        @test V2 isa Vector{Point3{Float64}}
        @test length(V2) == 40
        @test V2[1] == [1.0, 0.0, 0.0]
    end

end


@testset "platonic solid" begin
    r = 1
    n = 3
    eps = 0.001

    M = platonicsolid(4, r)

    @test M isa Mesh{3,Float64,GeometryBasics.Ngon{3,Float64,3,Point3{Float64}},SimpleFaceView{3,Float64,3,Int64,Point3{Float64},TriangleFace{Int64}}}
    @test length(M) == 20
    @test isapprox(M[1][1], [-0.85065080835204, 0.0, -0.5257311121191336], atol=eps)

end


@testset "coordinates" begin
    r = 1
    n = 3
    eps = 0.001

    M = platonicsolid(4, r)

    V = coordinates(M)

    @test V isa Vector{Point3{Float64}}
    @test length(V) == 12
    @test isapprox(V[1], [0.0, -0.5257311121191336, -0.85065080835204], atol=eps)

end


@testset "faces" begin
    r = 1
    n = 3

    M = platonicsolid(4, r)

    F = faces(M)

    @test F isa Vector{TriangleFace{Int64}}
    @test length(F) == 20
    @test F[1] == TriangleFace(9, 4, 1)
end

@testset "subtri" begin
    r = 1
    n = 3
    eps = 0.001

    M = platonicsolid(4, r)
    V = coordinates(M)
    F = faces(M)

    Fn, Vn = subtri(F, V, n)

    @test Fn isa Vector{TriangleFace{Int64}}
    @test length(Fn) == 1280
    @test Fn[1] == TriangleFace(163, 323, 243)

    @test Vn isa Vector{Point3{Float64}}
    @test length(Vn) == 642
    @test isapprox(Vn[1], [0.0, -0.5257311121191336, -0.85065080835204], atol=eps)
end


@testset "dist(Vn, V)" begin
    r = 1
    n = 3
    eps = 0.001

    M = platonicsolid(4, r)
    V = coordinates(M)
    F = faces(M)

    _, Vn = subtri(F, V, n)

    DD = dist(Vn, V)

    @test DD isa Matrix{Float64}
    @test size(DD) == (642, 12)
    @test isapprox(DD[1, :], [0.0, 1.70130161670408, 2.0, 1.0514622242382672, 1.0514622242382672, 1.70130161670408, 1.70130161670408, 1.0514622242382672, 1.0514622242382672, 1.0514622242382672, 1.70130161670408, 1.70130161670408], atol=eps)
end


@testset "quadsphere" begin
    r = 1.0
    F, V = quadsphere(3, r)
    eps = 0.001

    @test V isa Vector{Point3{Float64}}
    @test length(V) == 386
    @test isapprox(V[1], [-0.5773502691896258, -0.5773502691896258, -0.5773502691896258], atol=eps)

    @test F isa Vector{QuadFace{Int64}}
    @test length(F) == 384
    @test F[1] == [1, 99, 291, 187]
end

@testset "simplexcenter" begin
    eps = 0.001
    F, V = geosphere(2, 1.0)
    VC = simplexcenter(F, V)

    @test V isa Vector{Point3{Float64}}
    @test length(V) == 162
    @test isapprox(V[1], [0.0, -0.5257311121191336, -0.85065080835204], atol=eps)

    @test F isa Vector{TriangleFace{Int64}}
    @test length(F) == 320
    @test F[1] == TriangleFace(43, 83, 63)
end

@testset "normalizevector" begin
    n = normalizevector(Vec{3,Float64}(0.0, 0.0, 1.0))

    @test n isa Vec3{Float64}
    @test n == [0.0, 0.0, 1.0]
end

@testset "extrudecurve" begin
    eps = 0.001
    r = 1
    nc = 16
    d = 3.0
    Vc = circlepoints(r, nc; dir="cw")
    F, V = extrudecurve(Vc, d; s=1, close_loop=true, face_type="quad")

    @test V isa Vector{Point3{Float64}}
    @test length(V) == 128
    @test isapprox(V[1], [1.0, 0.0, 0.0], atol=eps)

    @test F isa Vector{QuadFace{Int64}}
    @test length(F) == 112
    @test F[1] == [17, 18, 2, 1]
end

@testset "cube" begin
    r = 2 * sqrt(3) / 2
    M = cube(r)

    @test M isa Mesh{3,Float64,GeometryBasics.Ngon{3,Float64,4,Point3{Float64}},SimpleFaceView{3,Float64,4,Int64,Point3{Float64},QuadFace{Int64}}}
    @test length(M) == 6
    @test M[1][1] == [-1.0, -1.0, -1.0]
    @test M[1][2] == [-1.0, 1.0, -1.0]
    @test M[1][3] == [1.0, 1.0, -1.0]
    @test M[1][4] == [1.0, -1.0, -1.0]
end

@testset "mergevertices" begin
    eps = 0.001
    r = 2 * sqrt(3) / 2
    M = cube(r)

    F = togeometrybasics_faces(faces(M))
    V = togeometrybasics_points(coordinates(M))
    F, V, _ = mergevertices(F, V)

    @test V isa Vector{Point3{Float64}}
    @test length(V) == 8
    @test isapprox(V[1], [-1.0, -1.0, -1.0], atol=eps)

    @test F isa Vector{QuadFace{Int64}}
    @test length(F) == 6
    @test F[1] == [1, 2, 3, 4]
end

@testset "seperate vertices" begin

    eps = 0.001
    r = 2 * sqrt(3) / 2
    M = cube(r)

    F = togeometrybasics_faces(faces(M))
    V = togeometrybasics_points(coordinates(M))
    F, V, _ = mergevertices(F, V)

    Fn, Vn = seperate_vertices(F, V)

    @test Vn isa Vector{Point3{Float64}}
    @test length(Vn) == 24
    @test isapprox(Vn[1], [-1.0, -1.0, -1.0], atol=eps)

    @test Fn isa Vector{QuadFace{Int64}}
    @test length(Fn) == 6
    @test Fn[1] == [1, 2, 3, 4]
end

@testset "icosahedron" begin

    eps = 0.001
    M = icosahedron()

    @test M isa Mesh{3,Float64,GeometryBasics.Ngon{3,Float64,3,Point3{Float64}},SimpleFaceView{3,Float64,3,Int64,Point3{Float64},TriangleFace{Int64}}}
    @test length(M) == 20
    @test isapprox(M[1][1], [-0.85065080835204, 0.0, -0.5257311121191336], atol=eps)
    @test isapprox(M[1][2], [0.0, 0.5257311121191336, -0.85065080835204], atol=eps)
    @test isapprox(M[1][3], [0.0, -0.5257311121191336, -0.85065080835204], atol=eps)

end

@testset "dodecahedron" begin

    eps = 0.001
    M = dodecahedron()


    @test M isa Mesh{3,Float64,GeometryBasics.Ngon{3,Float64,5,Point3{Float64}},SimpleFaceView{3,Float64,5,Int64,Point3{Float64},NgonFace{5,Int64}}}
    @test length(M) == 12
    @test isapprox(M[1][1], [0.0, 0.9341723589627159, 0.35682208977309], atol=eps)
    @test isapprox(M[1][2], [-0.5773502691896258, 0.5773502691896258, 0.5773502691896258], atol=eps)
    @test isapprox(M[1][3], [-0.35682208977309, 0.0, 0.9341723589627159], atol=eps)
end


@testset "interp_biharmonic_spline" begin
	eps = 0.001
    x = range(0, 9, 9) # Interval definition
    y = 5.0 * cos.(x .^ 2 ./ 9.0)
    n = 50
    xi = range(-0.5, 9.5, n) # Interval definition

    yi = interp_biharmonic_spline(x, y, xi; extrapolate_method="linear", pad_data="linear")

    expected = Float64[
        5.021936470288651, 5.012982808946344, 5.004029147604038, 5.003883984828356, 5.013423891770618, 5.016926459732009, 5.008877412957425, 4.986252200086639, 4.949095584901485, 4.900712801046797, 4.827338182066324, 4.718702733147323, 4.565299270988856, 4.355206727041269, 4.0643384202727155, 3.690302768049275, 3.2486120048531575, 2.741142656288753, 2.162741179324234, 1.4930428723452422, 0.6894521660239601, -0.17909936207112054, -1.066850736215498, -1.9394165202437383, -2.7620787973653123, -3.4863618240707703, -4.084745304595619, -4.548097090450917, -4.844487814719076, -4.919816101979883, -4.660991193954443, -3.8522496267669797, -2.7401507061437558, -1.4800073431767586, -0.17052435774788544, 1.0996489364430322, 2.2142992537631168, 3.1162872228104126, 3.812960510488512, 4.267335427319159, 4.415016001115535, 4.129059686282873, 3.1623787726296135, 1.7686560575217602, 0.11532807455604117, -1.6929812437232494, -3.556979551860928, -5.26268898629401, -6.833883823784279, -8.405078661274548
    ]
    @test yi isa Vector{Float64}
    @test length(yi) == 50
    @test isapprox(yi, expected, atol=eps)
end