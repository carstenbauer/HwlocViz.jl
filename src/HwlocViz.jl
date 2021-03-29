module HwlocViz

using Hwloc, Plots, AbstractTrees, GraphRecipes

const topo = topology_load()

AbstractTrees.children(x::Hwloc.Object) = x.children
AbstractTrees.printnode(io::IO, x::Hwloc.Object) = x.type_ in (:Core, :PU) ? print(io, "$(x.type_) $(x.logical_index)") : print(io, x.type_)

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
