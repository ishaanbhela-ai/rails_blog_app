class CommentSerializer < Blueprinter::Base
  identifier :id
  fields :body, :created_at
end
