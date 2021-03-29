# HwlocViz.jl

[![Build Status](https://github.com/crstnbr/HwlocViz.jl/workflows/CI/badge.svg)](https://github.com/crstnbr/HwlocViz.jl/actions)
[![Coverage](https://codecov.io/gh/crstnbr/HwlocViz.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/crstnbr/HwlocViz.jl)

```julia
julia> using HwlocViz

julia> plot_topology() # show in external window

julia> plot_topology("topology.png") # save to file
```

![topology](https://user-images.githubusercontent.com/187980/112912936-029c8280-90f9-11eb-890c-021de0a79f09.png)


```julia
julia> print_topology()
Machine
└─ Package
   └─ L3Cache
      ├─ L2Cache
      │  └─ L1Cache
      │     └─ Core 0
      │        ├─ PU 0
      │        └─ PU 1
      ├─ L2Cache
      │  └─ L1Cache
      │     └─ Core 1
      │        ├─ PU 2
      │        └─ PU 3
      ├─ L2Cache
      │  └─ L1Cache
      │     └─ Core 2
      │        ├─ PU 4
      │        └─ PU 5
      ├─ L2Cache
      │  └─ L1Cache
      │     └─ Core 3
      │        ├─ PU 6
      │        └─ PU 7
      ├─ L2Cache
      │  └─ L1Cache
      │     └─ Core 4
      │        ├─ PU 8
      │        └─ PU 9
      └─ L2Cache
         └─ L1Cache
            └─ Core 5
               ├─ PU 10
               └─ PU 11
```
