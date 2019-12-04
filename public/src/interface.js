$(document).ready(() => {

  $('#submit-url').click(() => {
    userInput = $('#input-url').val()
    postData(userInput)
  })

  function postData (input) {
    $.post('/', `{ "url": "${input}" }`, (data) => {
      response = JSON.parse(data)
      console.log(response)
    })
  }
})
