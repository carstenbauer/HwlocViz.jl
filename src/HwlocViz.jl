module HwlocViz

using Hwloc, Plots, AbstractTrees, GraphRecipes

const topo = topology_load()

AbstractTrees.children(x::Hwloc.Object) = x.children

function AbstractTrees.printnode(io::IO, obj::Hwloc.Object)
    idxstr = obj.type_ in (:Package, :Core, :PU) ? "L#$(obj.logical_index) P#$(obj.os_index) " : ""
    attrstr = string(obj.attr)

    if obj.type_ in (:L1Cache, :L2Cache, :L3Cache)
        tstr = first(string(obj.type_), 2)
        csize = obj.attr.size ÷ 1024
        if csize > 1000
            attrstr = "($(csize ÷ 1024) MB)"
        else
            attrstr = "($csize KB)"
        end
    elseif obj.type_ == :Package
        tstr = "Package"
        # TODO: add total memory info
    else
        tstr = string(obj.type_)
    end

    print(io, tstr, " ",
        idxstr,
        attrstr)
end

function print_topology()
    # print topology
    print_tree(topo, maxdepth=12)
    # print summary
    h = histmap(topo)
    caches = cachesize() .÷ 1024
    l1 = caches[1] > 1024 ? "$(caches[1] ÷ 1024) MB" : "$(caches[1]) KB"
    l2 = caches[2] > 1024 ? "$(caches[2] ÷ 1024) MB" : "$(caches[2]) KB"
    l3 = caches[3] > 1024 ? "$(caches[3] ÷ 1024) MB" : "$(caches[3]) KB"
    println("\nPackages: $(h[:Package]) \t L3: $l3")
    println("Cores: $(h[:Core]) \t L2: $l2")
    println("PUs: $(h[:PU]) \t L1: $l1")
    return nothing
end

function cachesize()
    l1 = l2 = l3 = zero(Int64)
    fl1 = fl2 = fl3 = false
    for obj in topo
        if obj.type_ == :L1Cache
            l1 = obj.attr.size::Int64
            fl1 = true
        elseif obj.type_ == :L2Cache
            l2 = obj.attr.size::Int64
            fl2 = true
        elseif obj.type_ == :L3Cache
            l3 = obj.attr.size::Int64
            fl3 = true
        end
        (fl1 && fl2 && fl3) && break
    end
    return (l1, l2, l3)
end

plot_topology(; kwargs...) = begin
    return plot(TreePlot(topo), fontsize=10, nodeshape=:circle, nodecolor=:white, size=(800,800), kwargs...)
end

plot_topology(filename::String; kwargs...) = begin
    p = plot_topology(; kwargs...)
    savefig(p, filename)
    return nothing
end

export plot_topology, print_topology

end
