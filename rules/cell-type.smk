def get_parent_fit(wildcards):
    if wildcards.parent != "root":
        parent = markers.loc[wildcards.parent, "parent"]
        return f"analysis/cellassign.{parent}.rds"
    else:
        return []


rule cellassign:
    input:
        sce="analysis/normalized.batch-removed.rds",
        markers=config["celltype"]["markers"],
        fit=get_parent_fit
    output:
        "analysis/cellassign.{parent}.rds"
    conda:
        "../envs/cellassign.yaml"
    script:
        "../scripts/cellassign.R"


rule plot_cellassign:
    input:
        "analysis/cellassign.{parent}.rds"
    output:
        "plots/cellassign.{parent}.svg"
    conda:
        "../envs/heatmap.yaml"
    script:
        "../scripts/plot-cellassign.R"

