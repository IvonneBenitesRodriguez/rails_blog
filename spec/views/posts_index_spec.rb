require 'rails_helper'

RSpec.describe 'User Features', type: :feature do
  before do
    @doctor = User.create!(id: 5, name: 'Doctor',
                           photo:
      'https://upload.wikimedia.org/wikipedia/commons/
        4/41/Profile-720.png',
                           bio: 'Mastology doctor')
    @patient = User.create!(id: 6, name: 'Patient',
                            photo:
    'https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-720.png',
                            bio: 'Advent Hospital patient')

    Post.create!(title: 'Welcome', text: 'Welcome to my site.',
                 comments_counter: 0, likes_counter: 2,
                 author: @doctor)

    Post.create!(title: 'Meeting nice people!!', text: 'Hi, nice to meet you.',
                 comments_counter: 0,
                 likes_counter: 2, author: @doctor)

    Post.create!(title: 'Doctor life', text: 'Sharing experiences as a doctor.',
                 comments_counter: 0,
                 likes_counter: 2, author: @doctor)

    Post.create!(title: 'Tips to care your health',
                 text: 'Discussing tips to care your health.',
                 comments_counter: 0, likes_counter: 2,
                 author: @doctor)

    Post.create!(title: 'News for my patients', text: 'new treatments.',
                 comments_counter: 0, likes_counter: 2, author: @doctor)

    @patient_post = Post.create!(title: 'First day at the hospital!',
                                 text: 'Exciting times on my first day!',
                                 comments_counter: 0, likes_counter: 2, author: @patient)
    @comment1 = Comment.create(post: @patient_post, user:
    @patient, text: 'My comment on the student post')
    @like1 = Like.create(post: @patient_post, user: @patient)
  end

  describe 'User Profile Page' do
    it 'displays user profile information' do
      visit user_posts_path(@patient)
      expect(page).to have_css("img[src*='#{@patient.photo}']")
      expect(page).to have_content('Patient')
    end

    it 'displays the number of posts' do
      visit user_posts_path(@patient)
      expect(@patient.posts.count).to have_content(1)
    end

    it 'displays a pagination button for posts' do
      visit user_posts_path(@doctor)
      expect(page).to have_css('.pagination-button')
    end
  end

  describe 'User Post Page' do
    it 'displays post details' do
      visit user_posts_path(@patient)
      expect(@patient.posts[0].title).to have_content('First day at the hospital')
      expect(@patient.posts[0].text).to have_content('Exciting times on my first day!')
    end

    it 'displays the first comment and its count' do
      visit user_post_path(@patient, @patient_post)
      expect(page).to have_content('My comment on the patient post')
      expect(@patient.posts[0].comments.count).to have_content(1)
    end

    it 'displays the number of likes' do
      visit user_post_path(@patient, @patient_post)
      expect(@patient.posts[0].likes.count).to have_content(1)
    end

    it 'redirects to the specific post when the user
        clicks on it' do
      visit user_path(@patient)
      click_link @patient_post.title
      expect(current_path).to eq(user_post_path(@patient, @patient_post))
    end

    it 'displays a section for pagination if there are more posts than fit on the
        view' do
      5.times do |n|
        Post.create!(title: "Test Post #{n + 1}", text: "Test post text
                #{n + 1}",
                     comments_counter: 0, likes_counter: 2, author: @patient)
      end

      visit user_posts_path(@patient)
      expect(page).to have_css('.pagination-button')
    end
  end
end
