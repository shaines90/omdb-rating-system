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
            $('.nope').append("<li><a href='#'>#{movie.Title}</a></li>")
          else if rating <= 4
            $('.meh').append("<li><a href='#'>#{movie.Title}</a></li>")
          else if rating <= 6
            $('.ok').append("<li><a href='#'>#{movie.Title}</a></li>")
          else if rating <= 8
            $('.veryGood').append("<li><a href='#'>#{movie.Title}</a></li>")
          else
            $('.fantastic').append("<li><a href='#'>#{movie.Title}</a></li>")

        # poster = "<img src='#{movie.Poster}'>"

        # $('.detail .title').html(movie.Title)
        # $('.detail .poster').html(poster)
        # $('.detail .year').html(movie.Year)


  $('#reset').click ->
    $('.movieColumns li').html("")