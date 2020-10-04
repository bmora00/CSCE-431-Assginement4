require 'rails_helper'

RSpec.feature 'books page', type: :feature do
    # Add href selector
    Capybara.add_selector(:href) do
        xpath {|href| XPath.descendant[XPath.attr(:href).contains(href)] }
    end

    context 'view books' do
      before(:each) do
        Capybara.current_driver = :selenium_chrome
        visit books_path
      end
      scenario "should be successful" do
        expect(page).to have_content('Book Collection')
      end
    end

    context 'create event' do
      before(:each) do
        Capybara.current_driver = :selenium_chrome
        visit new_book_path
      end
      scenario "should be successful" do
          within('form') do
              fill_in 'book_title', with: 'Test Book'
              fill_in 'book_author', with: 'Test Author'
              select "Action", from: "book_genre"
              fill_in 'book_price', with: '12.00'
              select "2021", from: "book_published_date_1i"
              select "November", from: "book_published_date_2i"
              select "18", from: "book_published_date_3i"
          end
          click_button 'Create Book'
          expect(page).to have_content('Test Book Test Author Action 12.0 2021-11-18')
      end
    end

    context 'edit event' do
        before(:each) do
            Capybara.current_driver = :selenium_chrome
            visit new_book_path
            within('form') do
                fill_in 'book_title', with: 'Test Book'
            end
            click_button 'Create Book'
        end
        scenario "should be successful" do
            visit books_path
            find(:href, "/edit").click
            within('form') do
                fill_in 'book_title', with: 'Changed Book'
            end
            click_button 'Update Book'
            visit books_path
            expect(page).to have_content('Book Collection')
            expect(page).to have_content('Changed Book')
        end
    end

    context 'delete event' do
        before(:each) do
            Capybara.current_driver = :selenium_chrome
            visit new_book_path
            within('form') do
                fill_in 'book_title', with: 'Test Book'
            end
            click_button 'Create Book'
        end
        scenario "should be successful" do
            visit books_path
            find(:href, "/delete").click
            click_button 'Delete Book'
            visit books_path
            expect(page).to have_no_content('Test Book')
        end
    end
  end
