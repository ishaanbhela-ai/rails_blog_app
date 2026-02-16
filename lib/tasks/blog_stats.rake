namespace :blog do
  desc "Print published and unpublished blog counts"
  task stats: :environment do
    published_count = Blog.published.count
    unpublished_count = Blog.unpublished.count

    puts "Blog Stats:"
    puts "  Published:   #{published_count}"
    puts "  Unpublished: #{unpublished_count}"
    puts "  Total:       #{Blog.count}"
  end
end
