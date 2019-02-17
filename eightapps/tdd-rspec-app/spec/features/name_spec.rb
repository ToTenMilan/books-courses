require 'rails_helper.rb'

feature 'visiting the home page' do
  scenario 'index page shows welcome text' do
    visit '/'
    expect(page).to have_text('Welcome To Posts')
  end
end