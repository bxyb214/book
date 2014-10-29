#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require jquery.autosize
#= require jquery.validate
#= require jquery.timeago
#= require nprogress
#= require campo
#= require jquery.atwho
#= require_tree ./plugins
#= require social-share-button


$ ->
  console.log "对源代码感兴趣？更多关于本站技术栈信息请参考: http://swiftist.org/topics/11"

$(document).on 'page:update', ->
  $('[data-behaviors~=autosize]').autosize()

  $("time[data-behaviors~=timeago]").timeago()

$(document).on 'page:fetch', ->
  NProgress.start()
$(document).on 'page:change', ->
  NProgress.done()
$(document).on 'page:restore', ->
  NProgress.remove()

$ ->
  data = ['tom','john'];
  commenters = {}
  a = $('#comments .comment-user')
  for e in a
    $e = $(e)
    commenters[$e.attr("data-name")] = $e.attr("data-name")
  $('textarea').atwho({at:"@", 'data': Object.keys(commenters)});
