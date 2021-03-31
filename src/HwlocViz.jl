module HwlocViz

using Hwloc, Plots, AbstractTrees, GraphRecipes

const topo = topology_load()

AbstractTrees.children(x::Hwloc.Object) = x.children
# function AbstractTrees.printnode(io::IO, x::Hwloc.Object)
#     x.type_ in (:Core, :PU) ? print(io, "$(x.type_) $(x.logical_index)") : print(io, x.type_)
# end

function AbstractTrees.printnode(io::IO, obj::Hwloc.Object)
    idxstr = obj.type_ in (:Package, :Core, :PU) ? "L#$(obj.logical_index) P#$(obj.os_index) " : ""
    attrstr = string(obj.attr)

    if obj.type_ in (:L1Cache, :L2Cache, :L3Cache)
        tstr = first(string(obj.type_), 2)
        csize = obj.attr.size / 1024
        if csize > 1000
            attrstr = "($(csize / 1024) MB)"
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

plot_topology(; kwargs...) = begin
    return plot(TreePlot(topo), fontsize=10, nodeshape=:circle, nodecolor=:white, size=(800,800), kwargs...)
end

plot_topology(filename::String; kwargs...) = begin
    p = plot_topology(; kwargs...)
    savefig(p, filename)
    return nothing
end

print_topology() = print_tree(topo, maxdepth=12)

export plot_topology, print_topology

end
