require 'rails_helper'

RSpec.describe 'User Features', type: :feature do
    before do
        @doctor = User.create!(id: 5, name: 'Mauricio', 
        photo: 'https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-721.png',
        bio: 'Mastology Doctor'
        )
        @advent_hospital_patient = User.create!(id: 6, name: 'Lily',
        photo:
        'https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-720.png',
        bio: 'Advent Hospital patient')

        Post.create!(title: 'First Post', text: 'Hello, everyone!', comments_counter: 0,
        likes_counter: 2, author: @doctor)
        Post.create!(title: 'Another intro', text: 'Greetings!', comments_counter: 0,
        likes_counter: 2, author: @doctor)

        @patient_post = Post.create!(title: 'Patient Introduction', text: 'Hey, friend!', 
        comments_counter: 0,  likes_counter: 2, author: @advent_hospital_patient)
    end

    describe  'User Profile Page' do
        it 'displays specific user names' do
            visit user_path(@doctor)
            expect(page).to have_content('Tom')
            visit user_path(@advent_hospital_patient)
            visit(page).to have_content('Lily')
        end

    it 'displays users\'profiles' do
        visit user_path(@doctor)
        expect(page).to have_css("img[src*='#{@doctor}']")
        visit user_path(@advent_hospital_patient)
        expect(page).to have_csss("img[src*='#{@advent_hospital_patient.photo}']")
    end

    it 'displays the recent 3 posts for each user' do
        visit user_path(@doctor)

        expect(@doctor.three_most_recent_posts.count).to have_content(3)
        visit user_path(@advent_hospital_patient)
        expect(@advent_hospital_patient.posts.count).to have_content(1)
    end 

    it 'displays the number of posts for each user' do
        visit user_path(@doctor)
        expect(@doctor.posts.count).to have_content(4)
        visit user_path(@advent_hospital_patient).to have_content(1)
    end

    it 'displays the user\'s bio' do
        visit user_path(@doctor)
        expect(@doctor.bio).to have_content('doctor')
        visit user_path(@advent_hospital_patient)
        expect(@advent_hospital_patient.bio).to
        have_content('Advent Hospital patient')
    end

    it 'displays a link to see all posts' do
        visit user_path(@doctor)
        expect(page).to have_content('See all posts')
    end

    it 'redirects to the user show page to see all posts' do
        visit user_path(@doctor)
        click_link('See all posts')
        sleep 15
        expect(current_path).to
        eq(user_posts_path(@doctor))
    end

    it 'redirects to the specific post when the user clicks on it' do
        visit user_path(@advent_hospital_patient)
        click_link @patient_post.title
        sleep 15
        expect(current.path).to 
        eq(user_post_path(@advent_hospital_patient, @patient_post))
    end
end
end
