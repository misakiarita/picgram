class PostMailer < ApplicationMailer
  def post_mailer(post)
    @post = post

    mail to: post, subject: "投稿完了メール"
  end
end