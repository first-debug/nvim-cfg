return {
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = { "*" }, -- Типы файлов, в которых будет работать подсветка цветовых кодов (можно указать конкретные)
      options = {
        parsers = {
          css = false, -- Включить все функции CSS: rgb_fn, hsl_fn, имена, RGB, RRGGBB
          css_fn = false, -- Включить все *функции* CSS: rgb_fn, hsl_fn
          tailwind = { enable = false }, -- Включить цвета попутного ветра(tailwind colors)
          sass = { enable = false, parsers = { "css" }, }, -- Включить цвета Sass
          hex = {
            rgb = true, -- Поддержка #RGB
            rrggbb = true, -- Поддержка #RRGGBB
            names = true, -- Поддержка названий цветов (например, Blue или blue, то есть синий)
            rrggbbaa = false, -- Поддержка #RRGGBBAA
            aarrggbb = false, -- Поддержка 0xAARRGGBB
          },
          rgb_fn = { enable = false }, -- Поддержка rgb() и rgba() функций CSS
          hsl_fn = { enable = false }, -- Поддержка hsl() и hsla() функций CSS
        },
        dysplay = {
          mode = "background", -- Установить режим отображения
          virtualtext = "■",
        },
        always_update = false
      },
      buftypes = {},
    },
  },
}
