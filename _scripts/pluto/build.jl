# Build site pages from the Pluto tutorial notebooks.
#
# Usage (from the repository root):
#
#     julia --project=_scripts/pluto _scripts/pluto/build.jl [notebook_dir]
#
# `notebook_dir` defaults to ../Omega.jl/OmegaExamples/src/intelligence.
# For each entry in _data/intelligence_tutorials.yml this script
#
# 1. copies the notebook into _scripts/pluto/build/ and switches it to install
#    the published Omega.jl branch (`use_local_omega = false`), so the code
#    shown on the site is the code readers can run;
# 2. runs it with PlutoStaticHTML and writes `_tutorials/<slug>.md`;
# 3. writes a full Pluto HTML export to build/export/<slug>.html, which is the
#    file to upload to pluto.land. Drop it on https://pluto.land and paste the
#    resulting link into the chapter's `pluto_land` field in the data file.
#
# Pass `--pages-only` to skip step 3.

using PlutoStaticHTML
using PlutoSliderServer
using YAML

const ROOT = normpath(joinpath(@__DIR__, "..", ".."))
const BUILD = joinpath(@__DIR__, "build")
const DATA = joinpath(ROOT, "_data", "intelligence_tutorials.yml")
const SERIES = "intelligence_tutorials"

posargs = filter(a -> !startswith(a, "--"), ARGS)
notebook_dir = isempty(posargs) ?
    normpath(joinpath(ROOT, "..", "Omega.jl", "OmegaExamples", "src", "intelligence")) :
    abspath(posargs[1])
export_full = !("--pages-only" in ARGS)

chapters = YAML.load_file(DATA)

# --- Stage notebooks --------------------------------------------------------

fragment_dir = joinpath(BUILD, "fragments")
export_dir = joinpath(BUILD, "export")
staged_dirs = export_full ? [fragment_dir, export_dir] : [fragment_dir]
for dir in staged_dirs
    rm(dir; force=true, recursive=true)
    mkpath(dir)
end

files = String[]
for ch in chapters
    src = joinpath(notebook_dir, ch["slug"] * ".jl")
    isfile(src) || error("Notebook not found: $src")
    text = read(src, String)
    occursin("use_local_omega = true", text) &&
        (text = replace(text, "use_local_omega = true" => "use_local_omega = false"))
    for dir in staged_dirs
        write(joinpath(dir, basename(src)), text)
    end
    push!(files, basename(src))
end

# --- Run notebooks ----------------------------------------------------------

build_notebooks(
    # One at a time: concurrent `Pkg.add` from git URLs contend for a git lock.
    BuildOptions(fragment_dir; output_format=html_output, max_concurrent_runs=1),
    files,
    OutputOptions(; append_build_context=false),
)

if export_full
    for f in files
        PlutoSliderServer.export_notebook(joinpath(export_dir, f))
    end
end

# --- Convert fragments to Jekyll pages -------------------------------------

function unescape_html(s)
    replace(s, "&lt;" => "<", "&gt;" => ">", "&quot;" => "\"", "&#39;" => "'",
        "&#x27;" => "'", "&amp;" => "&")
end

fence(lang, body) = "```$lang\n$(rstrip(unescape_html(body)))\n```"

const CODE_RE = r"<pre class='language-julia'><code class='language-julia'>(.*?)</code></pre>"s
const OUTPUT_RE = r"<pre class=\"code-output documenter-example-output\" id=\"[^\"]*\">(.*?)</pre>"s
# Terminal colour codes from UnicodePlots; Pluto turns ESC into U+FFFD.
const ANSI_RE = r"(?:\e|\N{U+FFFD})\[[0-9;]*m"
# Outputs that only echo a function definition add nothing to the page.
const FUNCTION_OUTPUT_RE = r"^\S+ \(generic function with \d+ methods?\)$"

function fragment2markdown(html)
    html = replace(html, r"<!-- PlutoStaticHTML\.(Begin|End) -->" => "")
    html = replace(html, r"<!--\s*# This information is used for caching\..*?-->"s => "")
    html = replace(html, ANSI_RE => "")
    # The page layout already shows the chapter title.
    html = replace(html, r"<h1[^>]*>.*?</h1>"s => ""; count=1)

    blocks = String[]
    first_code = true
    pos = 1
    pattern = Regex("$(CODE_RE.pattern)|$(OUTPUT_RE.pattern)|<div class=\"markdown\">.*?</div>(?=\\s*(?:<pre|<div class=\"markdown\"|\$))", "s")
    for m in eachmatch(pattern, html)
        if m[1] !== nothing
            block = fence("julia", m[1])
            if first_code
                # The first cell only installs and loads packages.
                block = """
                <details class="notebook-setup" markdown="1">
                <summary>Setup: install and load Omega</summary>

                $block

                </details>"""
                first_code = false
            end
            push!(blocks, block)
        elseif m[2] !== nothing
            out = rstrip(unescape_html(m[2]))
            occursin(FUNCTION_OUTPUT_RE, out) && continue
            isempty(out) && continue
            push!(blocks, "```text\n$out\n```\n{: .notebook-output}")
        else
            push!(blocks, m.match)
        end
    end
    # Fail loudly if a cell produced output in a form the patterns above miss.
    leftover = strip(replace(html, pattern => ""))
    isempty(leftover) || error("Unconverted notebook output:\n" * first(leftover, 500))
    join(blocks, "\n\n")
end

pages_dir = joinpath(ROOT, "_tutorials")
mkpath(pages_dir)
for ch in chapters
    slug = ch["slug"]
    fragment = read(joinpath(fragment_dir, slug * ".html"), String)
    body = fragment2markdown(fragment)
    page = """
    ---
    layout: page
    title: "$(ch["chapter"]). $(ch["title"])"
    description: "$(replace(ch["description"], "\"" => "\\\""))"
    series: $SERIES
    chapter: $(ch["chapter"])
    toc:
      sidebar: left
    ---

    <!-- Generated by _scripts/pluto/build.jl from $(slug).jl. Do not edit by hand. -->

    {% include notebook_series.liquid position="top" %}

    {% raw %}
    $body
    {% endraw %}

    {% include notebook_series.liquid position="bottom" %}
    """
    write(joinpath(pages_dir, "$slug.md"), page)
    @info "Wrote _tutorials/$slug.md"
end
