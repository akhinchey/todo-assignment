require 'rails_helper'
require 'pry'

RSpec.describe TasksController, type: :controller do
  feature "Creating a task" do
    before(:all) do
      @user = User.create(name:"test", email:"aa@aa.com", password: "password")
      @list = @user.lists.create(title:"test list")
      visit login_path
      fill_in "email", with: "aa@aa.com"
      fill_in "password", with: "password"
      click_button "Submit"
    end

    after(:all) do
      @user.destroy
    end
  
    scenario "redirects to the list show page on success" do
      visit user_list_path(@user, @list)
      expect(page).to have_content("You currently have no incomplete tasks for this list. Add some below!")
      expect(page).to have_content("Add a task:")
  
      fill_in "Name", with: "Test my app"
      click_button "Add Task"
  
      expect(page).to have_content("Test my app")
    end
  
    # scenario "displays an error when no name is provided" do
    #   visit new_task_path
    #   fill_in "Name", with: ""
    #   click_button "Save"
  
    #   expect(page).to have_content("Name can't be blank")
    # end
  end

end

