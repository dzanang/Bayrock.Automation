describe 'Attempting to add new experience' do
  let(:user) { @user }
  let(:member) { @member }
  let(:exp) { @exp }
  let(:login) { LoginPage.new(@browser) }
  let(:homepage) { HomePage.new(@browser) }
  let(:experience) { AddExperiencePage.new(@browser) }

  context 'Successfully logged into Bayrock' do
    let(:email) { user['email']}
    let(:password) { user['password'] }
    include_context 'Login with user'
  end

  context 'Adding new experience' do
    it 'Opened experience modal' do
      homepage.add_new_experience
      expect(experience.check_save_button_present?).to be true
    end

    it 'Filled in the necessary data' do
      experience.enter_title exp['title']
      experience.enter_company exp['company']
      experience.enter_location exp['location']
      experience.enter_from_date exp['from_date']
      experience.enter_to_date exp['to_date']
      # experience.set_currently_work
      experience.enter_description exp['description']
    end

    it 'Added new experience' do
      experience.click_save_button
      sleep 5
      expect(homepage.check_experience_added(exp['title'])).to be true
    end

    it 'Edit newly added experience' do
      homepage.edit_experience
      experience.enter_title exp['edit_title']
      experience.click_save_button
      sleep 5
      expect(homepage.check_experience_title).to include exp['edit_title']
    end

    it 'Removed test experience' do
      homepage.delete_test_experience
      sleep 5
      expect(homepage.check_experience_added(exp['title'])).not_to be true
    end
  end
end
