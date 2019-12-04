$(document).ready(() => {
  let listAnchors = []

  $('#submit-url').click(() => {
    userInput = $('#input-url').val()
    postData(userInput)
    $('#input-url').val('http://')
  })

  function postData (input) {
    $.post('/', `{ "url": "${input}" }`, (data) => {
      res = JSON.parse(data)
      listAnchors.push(`<a href=${res.url}>${res.short_url} -> ${res.url}</a>`)
      updateList()
    })
  }

  function updateList () {
    $('#url-list').html(listAnchors.join('\n<br>\n'))
  }
})
