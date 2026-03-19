---
name: plot-skill
description: >
  Matplotlib plotting and diagram style with macaron color palette and colorblind-safe
  alternatives. Use when creating any visual output with matplotlib or Python: charts,
  plots, figures, diagrams, flow charts, architecture diagrams, comparison charts,
  pipeline illustrations, performance graphs, roofline plots, benchmark results,
  profiling data visualization. Trigger on: 画图, 画一个, 画个, 可视化, 图表, 流程图,
  架构图, 对比图, 性能图, 柱状图, 折线图, 热力图, 散点图, plot, figure, chart,
  diagram, draw, visualize, matplotlib, bar chart, line chart, heatmap, scatter,
  histogram, pie chart, box plot, violin plot, subplot, savefig.
  Also use when the user asks to save a figure, choose colors for a chart,
  or set up matplotlib style for a project.
---

# Matplotlib Figure Style

Two palette presets: **macaron** (default, for reports/slides) and **colorblind-safe** (for papers/journals).

## Palette: Macaron (default)

Pastel fills with dark borders. Suitable for technical reports, presentations, blog posts.

```python
MACARON = {
    "lilac": "#D4B5D8", "lilac_light": "#E6D2E8",
    "mint": "#A8D8B9",  "mint_light": "#C8E9D4",
    "lemon": "#F7E6A0", "lemon_light": "#FBF0C4",
    "sky": "#A2C4E0",   "sky_light": "#C7DCF0",
    "peach": "#F5C5B8", "coral": "#F5A0A0", "silver": "#E0E0E0",
}
```

Light variants for secondary/repeated elements. Max 5-6 fill colors per figure.

## Palette: Colorblind-safe (for papers)

Use when the figure targets journal submission or needs accessibility.

```python
OKABE_ITO = ['#E69F00', '#56B4E9', '#009E73', '#F0E442',
             '#0072B2', '#D55E00', '#CC79A7', '#000000']
```

For heatmaps: prefer `viridis`, `cividis`, `plasma`. Avoid `jet`, `rainbow`, and red-green diverging maps.

See [K-Dense-AI/claude-scientific-skills](https://github.com/K-Dense-AI/claude-scientific-skills)
for a full publication-ready skill with journal-specific styles (Nature, Science, Cell) and
export scripts.

## Text and Borders

| Element    | Color     |
|:-----------|:----------|
| Main text  | `#222222` |
| Annotation | `#555555` |
| Border     | `#555555` |
| Arrow      | `#444444` |
| Background | `#FFFFFF` |

## Style Defaults

```python
BOX_STYLE = "round,pad=0.03"
BORDER_WIDTH = 0.6
SAVE_KWARGS = dict(dpi=200, bbox_inches="tight", facecolor="white")
```

## Conventions

- All hex colors include `#` prefix
- Rounded rectangles: `boxstyle="round,pad=0.03"`, linewidth 0.6
- Font: default matplotlib sans-serif, color `#222222`
- Save with `dpi=200, bbox_inches="tight", facecolor="white"`
- Flow diagrams: arrows with `#444444`, white background
