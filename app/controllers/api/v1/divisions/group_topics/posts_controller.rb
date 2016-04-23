module Api::V1::Divisions::GroupTopics
  class PostsController < Api::V1::Divisions::GroupTopics::BaseController

    before_action :post, except: [:new, :create, :draft]

    def draft
      draft_posts = @group_topic.posts.draft

      render_ok({ posts: draft_posts })
    end

    def new
      render_ok
    end

    def create
      post = @group_topic.posts.new(post_params)
      post.publish! unless post.draft?
      post.save!

      render_ok
    end

    def edit
      render_ok({ post: @post })
    end

    def update
      @post.update(post_params)
      post.publish! unless post.draft?

      render_ok
    end

    private

    def post
      unless @post
        id = params[:post_id] || params[:id]
        @post = Post.find(id)
      end

      raise ActiveRecord::RecordNotFound unless @post
      @post
    end

    def post_params
      params.require(:post).permit(
        :body, :is_draft,
      ).merge({
        author: current_account,
        division: @division,
      })
    end
  end
end
