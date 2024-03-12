/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./*/*.html', "./src/**/*.{html,js,css}"],
  theme: {
    extend: {
      colors: {
        primary: '#FF6363',
        secondary: {
          100: '#E2E2D5',
          200: '#888883',
        }
      },
      fontsFamily: {
        body: ['Nunito']
      }
    },
  },
  plugins: [],
}
