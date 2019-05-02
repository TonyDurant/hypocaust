$(document).on "click", ".show-chart", (event) ->
    id = $(this).parents(".panel-heading").attr("id")
    $(this).children(".panel-body").load("/show_chart?type=#{id}")

jQuery ->
  $(window).scroll ->
    url = $('.pagination .next_page').attr('href')
    if url && $(window).scrollTop() > $(document).height() - $(window).height() - 550
      $('.pagination').html('<center><i class="fa fa-spinner fa-spin" style="font-size:30px"></i></center>')
      $.ajax({
        type: "GET",
        url: url,
        data: {scrolling: "filescroll"},
        dataType: "script"
      });
