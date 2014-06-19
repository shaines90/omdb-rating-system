$ ->

  $('#search').on 'submit', (e) ->
    e.preventDefault()
    searchTerm = $('#searchField').val()
    masterResponse = $.ajax(
      "http://www.omdbapi.com/?s=#{searchTerm}"
      dataType: "json"
    )

    masterResponse.done (data) ->

      movies = data.Search

      for movie in movies
        imdb = movie.imdbID
        detail = $.ajax(
            "http://www.omdbapi.com/?i=#{imdb}"
            dataType: 'json'
        )

        detail.done (movie) ->
          rating = movie.imdbRating
          rating = parseFloat(movie.imdbRating)

          if rating <= 2
            $('.nope').append("<li>#{movie.Title}</li>")
          else if rating <= 4
            $('.meh').append("<li>#{movie.Title}</li>")
          else if rating <= 6
            $('.ok').append("<li>#{movie.Title}</li>")
          else if rating <= 8
            $('.veryGood').append("<li>#{movie.Title}</li>")
          else
            $('.fantastic').append("<li>#{movie.Title}</li>")

  $('#reset').click ->
    $('.movieColumns li').html("")