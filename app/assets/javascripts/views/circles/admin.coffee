$(document).on 'page:load ready', ->
  $('#circle_role_role_type').on 'change', (e)->
    $type = $(e.target)
    $name = $type.siblings('#circle_role_name')
    console.log(e)
    console.log($type.val())
    if $type.val() == "circle.custom"
      $name.removeClass("hidden")
    else
      $name.addClass("hidden")
      $name.val("")

  $('#add-role a').on 'click', (e)->
    $('#add-role').addClass('hidden')
    $('#add-role-fields').removeClass('hidden')

  clipboard = new Clipboard('button[type="submit"]');
  clipboard.on 'success', (e)->
      e.clearSelection()

      Lale.Flash.info I18n.t('workflow.copied')

