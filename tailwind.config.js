module.exports = {
  theme: {
    extend: {
      width: {
        '380': '380px',
      },
      height: {
        '419': '419px',
      },
    },
  },
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require("daisyui")
  ],
  daisyui: {
    themes: [
      "bumblebee"
    ],
  },
}