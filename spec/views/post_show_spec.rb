# require 'rails_helper'

# RSpec.describe 'User Features', type: :feature do
#     before do
#         @author_user = User.create!(name: 'Shei', photo:
#         'https://example.com/shei_profile.png',
#         bio: 'TouristGuide from Peru.')
#         @commenter_user = User.create!(name: 'Ivonne Benites',
#         photo: 'https//example.com/ivonne_profile.png',
#         bio: 'Junior Developer from Peru.')

#         @post = Post.create!(title: 'Love', text: 'Hi, visit my post.', comments_counter: 0,
#         likes_counter: 2, author: @author_user)
#         @comment = Comment.create(post: @post, user:
#         @commenter_user, text: 'My wonderful comment.')
#         @like = Like.create(post: @post, user: @commenter_user)
#     end

#     describe 'User Profile Page' do
#         it "displays author's name" do
#             visit user_posts_path(@commenter_user)
#             expect(page).to have_content(@commenter_user.name)
#         end

#         it 'displays the username of each commenter' do
#             comment = @post.comments.first
#             expected_username = @commenter_user.name

#             expect(comment.user.name).to eq(expected_username)
#         end

#         it "displays post's title" do
#             visit user_posts_path(@commenter_user)
#             expect(@post.title).to have_content('Love')
#         end

#         it "displays post's body" do
#             visit user_posts_path(@commenter_user)
#             expect(@post.text).to have_content("Hi, visit my post.")
#         end

#         it 'displays comments' do
#             visit user_post_path(@commenter_user, @post)
#             expect(@post.comments.map(&:text)).to include('My meaningful comment.')
#         end

#         it 'displays the number of comments' do
#             visit user_post_path(@commenter_user, @post)
#             expect(@post.comments.count).to have_content(1)
#         end

#         it 'displays the number of likes' do
#             visit user_post_path(@commenter_user, @post)
#             expect(@post.likes.count).to have_content(1)
#         end
#     end
# end
