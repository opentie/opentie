module Api::V1::Groups::Topics
  class PostsController < Api::V1::Groups::Topics::BaseController

    before_action :post, except: [:new, :create, :index]

    def index
      draft_posts = @group_topic.posts.draft

      render_ok({ posts: draft_posts })
    end

    def new
      render_ok
    end

    def create
      post = @group_topic.posts.create(post_params)
      post.publish! unless post.draft?

      render_created
    end

    def edit
      render_ok(@post.attributes)
    end

    def update
      @post.update(post_params)
      @post.publish! unless @post.draft?

      render_ok
    end

    def destroy
      @post.destroy

      render_ok
    end

    private

    def post
      id = params[:post_id] || params[:id]
      @post = @group_topic.posts.draft.find(id)

      raise ActiveRecord::RecordNotFound unless @post
      @post
    end

    def post_params
      params.require(:post).permit(
        :body, :is_draft
      ).merge({
        author: current_account
      })
    end
  end
end
