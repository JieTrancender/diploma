class PicturesController < ApplicationController
	BUCKET = 'sources'
	DOMAIN = 'sources.jie-trancender.org/'

	def index
		@user = User.find(params[:id])
		@pictures = @user.pictures.paginate(page: params[:page])
	end

	def show
		@picture = Picture.find_by(id: params[:id])
		if @picture.nil?
			# redirect_to :index
			@pictures = Picture.all
			flash.now[:alert] = "Your picture was not found."
			render 'index'
		end
	end

	def new
		logger.info params.inspect
		@qiniu_upload_token = generate_qiniu_upload_token endUser: params[:endUser] || 'default'
		@picture = Picture.new
	end

	def create
		logger.info params.inspect

		@picture = @user.pictures.create(
			key = params[:key],
			url = DOMAIN + params[:key],
			endUser = params[:endUser]
		)

		if @picture.save
			render json: params
		else
			render json: {faild: '404'}
		end
	end

	def create1
		logger.info params.inspect

		upload_ret = JSON.parse(Base64.urlsafe_decode64(params[:upload_ret]))
		logger.info upload_ret
		@picture = Picture.new(
			key = upload_ret[:key],
			url = DOMAIN + upload_ret[:key],
			endUser = upload_ret[:endUser]
		)

		if @picture.save
			render @picture
		else
			render :new
		end
	end

	private
	  def generate_qiniu_upload_token(params)
	  	put_policy = Qiniu::Auth::PutPolicy.new(
	  		BUCKET,
	  		nil,
	  		3600
	  	)

	  	callback_url = create_pictures_url + "?endUser=#{params[:endUser]}"
	  	# logger.info callback_url
	  	# callback_url = "jie-trancender.org:3001/callback?endUser=#{params[:endUser]}"
	  	callback_body = 'bucket=$(bucket)&key=$(key)&etag=$(etag)&fname=$(fname)&fsize=$(fsize)&mimeType=$(mimeType)&' +
        'endUser=$(endUser)&imageInfo=$(imageInfo)&ext=$(ext)&uuid=$(uuid)'


      logger.info callback_url
      logger.info callback_body

      put_policy.callback_url = callback_url
      put_policy.callback_body = callback_body

      Qiniu::Auth.generate_uptoken(put_policy)
    end
end
