# MIT License
# Copyright (c) 2017: Xavier Gandibleux, Anthony Przybylski, Gauthier Soleilhac, and contributors.
type _2UKP
    nSize::Int
    P1::Vector{Int}
    P2::Vector{Int}
    W::Vector{Int}
    C::Int
end

Base.show(io::IO, id::_2UKP) = print("Bi-Objective Knapsack Problem with $(id.nSize) variables.")

set2UKP(n::Int, p1::Vector{Int}, p2::Vector{Int}, w::Vector{Int}, c::Int) = begin
    @assert n == length(p1) == length(p2) == length(w)
    _2UKP(n, p1, p2, w, c)
end
set2UKP(p1::Vector{Int}, p2::Vector{Int}, w::Vector{Int}, c::Int) = begin
    set2UKP(length(p1), p1, p2, w, c)
end

type UKPsolver
    solve::Function#::Function(id::_2LAP) -> ...
end

function vSolve(id::_2UKP, solver::UKPsolver = UKP_Jorge2010())
    solver.solve(id)
end

function UKP_Jorge2010()::UKPsolver
    f = (id::_2UKP) -> begin 
        pb = Bi01KP.problem(id.P1, id.P2, id.W, id.C)
        return Bi01KP.solve(pb)
    end

    return UKPsolver(f)
end

function load2UKP(fname)
    f = open(fname)
    n = parse(readline(f))
    P = parse(readline(f))
    nbC = parse(readline(f))
    p1 = parse.(split(readline(f)))
    p2 = parse.(split(readline(f)))
    w = parse.(split(readline(f)))
    c = parse(readline(f))
    _2UKP(n, p1, p2, w, c)
end