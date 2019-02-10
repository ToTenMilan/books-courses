module CommentsHelper
  def posted_by(comment)
    "By: #{comment.user.email} #{time_ago_in_words(comment.created_at)} ago"
  end
end
