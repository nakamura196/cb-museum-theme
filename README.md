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
| `_includes/museum-header.html` | the top of every page: menu and title banner, in the order of the look |
| `_includes/museum-nav.html` | the theme's menu bar, a copy of CB-CSV's `collection-nav.html` with the site name (modern) and the switch, without the small-screen logo |
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

Jekyll uses a site's own file when the site and the theme have files with the same name. Every CollectionBuilder site already has these templates, so the theme cannot change them from the gem. Add these lines by hand instead: a few lines in two files.
CollectionBuilder's menu (`_includes/collection-nav.html`) and banner (`_includes/collection-banner.html`) are not edited; the theme uses its own copy of the menu, `_includes/museum-nav.html`.
To remove the theme, undo these edits and the steps above.

`_includes/head/head.html`, on a new line right after `<meta charset="utf-8">`:

```liquid
{% if site.data.theme.color-mode-toggle %}{% include head/color-mode.html %}{% endif %}
```

`_layouts/default.html`: put the look on `<html>`, and draw the top of the page with the theme's menu.

Replace the first two lines:

```liquid
<!doctype html>
<html lang="en" class="h-100">
```

with:

```liquid
{%- assign style = site.data.theme.theme-style | default: "modern" -%}
<!doctype html>
<html lang="en" class="h-100" data-style="{{ style }}">
```

Replace:

```liquid
    {% include collection-banner.html %}
    {% include collection-nav.html %}
```

with:

```liquid
    {% include museum-header.html %}
```

If your site is not in English, also change `lang="en"` to your language (for example `lang="ja"`). The theme picks its fonts from it.

The menu items still come from `_data/config-nav.csv`, as before.
If you have changed `_includes/collection-nav.html` yourself, copy `_includes/museum-nav.html` from this gem into your site and make the same change there; the same applies when a newer CollectionBuilder changes its menu.

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
