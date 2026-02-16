Comment.destroy_all
Blog.destroy_all
10.times do
  blog = Blog.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
    published: [ true, false ].sample
  )

  # Only add comments if the blog is published
  if blog.published?
    rand(0..5).times do
      blog.comments.create!(
        body: Faker::Lorem.sentence
      )
    end
  end
end
puts "Created #{Blog.count} blogs and #{Comment.count} comments."
