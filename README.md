# cb-museum-theme

Two looks for [CollectionBuilder-CSV](https://github.com/CollectionBuilder/collectionbuilder-csv) sites, packaged as a Jekyll theme gem:

- **modern**: white and navy, sans-serif headings, the site name, menu and search on one row
- **museum**: warm paper, serif headings, the title banner above the menu

Both come with a light/dark switch and work through Bootstrap 5.3 CSS variables, so CollectionBuilder's own components follow the palette. The gem only adds files. It does not replace CollectionBuilder's templates.

## What the gem contains

| File | What it does |
| --- | --- |
| `_sass/_museum.scss` | museum palette (`--museum-*` variables) and component styles |
| `_sass/_modern.scss` | modern palette, dark palettes, one-row header, item-page layout |
| `_includes/head/color-mode.html` | sets light/dark before the page is drawn, so a dark page does not flash white |
| `_includes/color-mode-toggle.html` | the light/dark button in the menu |
| `_layouts/home-museum.html` | optional home page: large search box, example queries, image grid |

## Install

1. Add the gem to `Gemfile`:

   ```ruby
   gem "cb-museum-theme", git: "https://github.com/nakamura196/cb-museum-theme.git", ref: "<commit>"
   ```

2. Add the theme to `_config.yml`:

   ```yaml
   theme: cb-museum-theme
   ```

3. Load the styles at the end of `_sass/_custom.scss`:

   ```scss
   @use "museum";
   @use "modern";
   ```

4. Choose the look in `_data/theme.yml`:

   ```yaml
   theme-style: modern     # modern / museum
   color-mode-toggle: true # light/dark switch; follows the OS setting until a visitor picks one
   ```

5. Add the small hooks below to CollectionBuilder's templates.

### Hooks in CollectionBuilder's templates

Jekyll uses a site's own file when the site and the theme have files with the same name. Every CollectionBuilder site already has these templates, so the theme cannot change them from the gem. Add these lines by hand instead.

`_includes/head/head.html`, inside `<head>`:

```liquid
{% if site.data.theme.color-mode-toggle %}{% include head/color-mode.html %}{% endif %}
```

`_layouts/default.html`: put the look on `<html>`, and in the modern look draw the menu above the banner:

```liquid
{%- assign style = site.data.theme.theme-style | default: "modern" -%}
<html lang="{{ site.lang | default: "en" }}" class="h-100" data-style="{{ style }}">
...
    {% if style == "modern" %}{% include collection-nav.html %}
    {% include collection-banner.html %}{% else %}{% include collection-banner.html %}
    {% include collection-nav.html %}{% endif %}
```

`_includes/collection-nav.html`: in the modern look the bar also holds the site name, and the switch sits at its right end. Four changes:

1. Before `<nav>`, pick the style. The modern bar holds more, so it folds into the menu button below 1200px instead of 992px:

   ```liquid
   {%- assign style = site.data.theme.theme-style | default: "modern" -%}
   {%- if style == "modern" %}{% assign bp = "xl" %}{% else %}{% assign bp = "lg" %}{% endif -%}
   ```

2. On `<nav>`, use that breakpoint, and drop the fixed `data-bs-theme` when the switch is on (otherwise the bar stays light in dark mode):

   ```liquid
   <nav class="navbar navbar-expand-{{ bp }} {{ site.data.theme.navbar-background | default: 'bg-black' }}"{% unless site.data.theme.color-mode-toggle %} data-bs-theme="{{ site.data.theme.navbar-color | default: 'dark' }}"{% endunless %}>
   ```

3. Right after `<div class="container">`, the site name, and on the mobile logo `d-lg-none` becomes `d-{{ bp }}-none`:

   ```liquid
   {% if style == "modern" %}<a class="navbar-brand" href="{{ '/' | relative_url }}">{{ site.title }}</a>{% endif %}
   ```

4. After `{% include nav-search-lunr.html %}`, the switch:

   ```liquid
   {% if site.data.theme.color-mode-toggle %}{% include color-mode-toggle.html %}{% endif %}
   ```

## Customize

Try these in order. The earlier ones keep receiving fixes from the gem.

1. **Settings** in `_data/theme.yml` (`theme-style`, `color-mode-toggle`, `font-cdn`).
2. **Variables and extra rules** in `_sass/_custom.scss`, after the `@use` lines. For example:

   ```scss
   :root { --museum-accent: #2a4f7a; --museum-accent-rgb: 42, 79, 122; }
   :root[data-bs-theme="dark"] { --museum-accent: #7da8d6; }
   ```

3. **Replace one file**: copy a file from this gem into your site under the same path and edit it. Your copy is used instead of the gem's. It no longer receives fixes from the gem.
4. **Take everything**: copy all files into your site and remove the gem. You are then on your own copy.

## Fonts

No font files ship with the theme. Load web fonts with `font-cdn` in `_data/theme.yml`. The comment at the top of `_sass/_museum.scss` has the line for the Latin defaults (Source Serif 4 / Source Sans 3).

## License

MIT
