const { environment } = require('@rails/webpacker')

module.exports = environment

// 以下bootstrapの為追記、12行目ratyの為
const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    jquery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)