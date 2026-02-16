10.times do |i|
  blog = Blog.create!(
    title: "Published Blog #{i}",
    body: "Content",
    published: true
  )
  2.times { blog.comments.create!(body: "Comment") }
end

10.times do |i|
  Blog.create!(
    title: "Unpublished Blog #{i}",
    body: "Draft",
    published: false
  )
end
