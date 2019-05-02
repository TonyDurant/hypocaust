jQuery ->
  $(window).scroll ->
    url = $('.pagination .next_page').attr('href')
    if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
      $('.pagination').text("Fetching more posts...")
      $.getScript(url)
      $('.addtofavAction').click ->
        current_fav = $(this).parents("span:first")
        $.ajax
          url: '/posts/' + $(current_fav).attr('data_post_id') + "/add_to_fav"
          type: 'POST'
          data: _method: 'GET'
          success: ->
            $(current_fav).fadeOut 200

jQuery ->
  $('.addtofavAction').click ->
    current_fav = $(this).parents("span:first")
    $.ajax
      url: '/posts/' + $(current_fav).attr('data_post_id') + "/add_to_fav"
      type: 'POST'
      data: _method: 'GET'
      success: ->
        $(current_fav).fadeOut 200