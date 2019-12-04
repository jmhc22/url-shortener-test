feature 'Can use a front end page to add and view short urls' do
  scenario 'Inputting www.farmdrop.com will create and display short url', js: true do
    allow_any_instance_of(UrlShortener).to receive(:rand).and_return(2)
    visit ('/')
    expect(page).not_to have_content '/frm222 -> http://www.farmdrop.com'
    fill_in "input-url", with: "www.farmdrop.com"
    click_button 'submit-url'
    expect(page).to have_content '/frm222 -> http://www.farmdrop.com'
  end

  scenario 'Displayed short urls persist with a page refresh', js: true do
    allow_any_instance_of(UrlShortener).to receive(:rand).and_return(3)
    visit ('/')
    expect(page).not_to have_content '/frm333 -> http://www.farmdrop.com'
    fill_in "input-url", with: "www.farmdrop.com"
    click_button 'submit-url'
    expect(page).to have_content '/frm333 -> http://www.farmdrop.com'
    visit ('/')
    expect(page).to have_content '/frm333 -> http://www.farmdrop.com'
  end
end
