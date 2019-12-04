$(document).ready(() => {
  let listAnchors = []
  getList()

  $('#submit-url').click(() => {
    userInput = $('#input-url').val()
    postData(userInput)
    $('#input-url').val('http://')
  })

  function getList () {
    $.get('/api/urls-list', (data) => {
      links = JSON.parse(data)
      listAnchors = links.urlList.map((link) => {
        return `<a href=${link.url}>/${link.short} -> ${link.url}</a>`
      })
      updateList()
    });
  }

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
