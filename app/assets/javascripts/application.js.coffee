#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require jquery.remotipart
#= require jquery.autosize
#= require jquery.validate
#= require jquery.timeago
#= require nprogress
#= require campo
#= require lib/qrcode.min
#= require lib/mediaelement-and-player
#= require_tree ./plugins
#= require social-share-button



$ ->
  console.log "对源代码感兴趣？更多关于本站技术栈信息请参考: https://github.com/bxyb214/book"

$(document).on 'page:update', ->
  $('[data-behaviors~=autosize]').autosize()

  $("time[data-behaviors~=timeago]").timeago()

$(document).on 'page:fetch', ->
  NProgress.start()
$(document).on 'page:change', ->
  NProgress.done()
$(document).on 'page:restore', ->
  NProgress.remove()
