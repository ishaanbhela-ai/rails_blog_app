class BlogSerializer < Blueprinter::Base
  identifier :id
  fields :title, :body, :published, :created_at
  # Association
  association :comments, blueprint: CommentSerializer
end
