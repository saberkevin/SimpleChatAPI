module Api
    module V1
        class ConversationController < ApplicationController
            def create
                

                @room_exists = Conversation.find_by_sql("SELECT rooms.* FROM rooms WHERE user_id_1 IN("+conversation_params[:user_id_from].to_s+"," +conversation_params[:user_id_to].to_s+") AND user_id_2 IN("+conversation_params[:user_id_from].to_s+"," +conversation_params[:user_id_to].to_s+") LIMIT 1")

                if @room_exists.empty? 
                    @room_exists = Room.new(:user_id_1 => conversation_params[:user_id_from], :user_id_2 => conversation_params[:user_id_to])
                    @room_exists.save                 
                end

                @idRoom =  Conversation.find_by_sql("SELECT rooms.id FROM rooms WHERE user_id_1 IN("+conversation_params[:user_id_from].to_s+"," +conversation_params[:user_id_to].to_s+") AND user_id_2 IN("+conversation_params[:user_id_from].to_s+"," +conversation_params[:user_id_to].to_s+") LIMIT 1")

                @conversation = Conversation.new(
                    :user_id_from => conversation_params[:user_id_from],
                    :user_id_to => conversation_params[:user_id_to],
                    :message => conversation_params[:message],
                    :read_status => conversation_params[:read_status],
                    :room_id => @idRoom[0].id
                )

                if conversation_params[:message].empty?
                    render @conversation.errors, status: :unprocessable_entity
                elsif @conversation.save
                    render json: @conversation
                else 
                    render json: @conversation.errors, status: :unprocessable_entity
                end

            end

            def currentChat
                Conversation.where(:user_id_from => currentChat_params[:user_id_to]).update_all(read_status: true)

                @conversation = Conversation.find_by_sql("SELECT conversations.* FROM conversations WHERE user_id_from IN("+currentChat_params[:user_id_from].to_s+"," +currentChat_params[:user_id_to].to_s+") AND user_id_to IN("+currentChat_params[:user_id_from].to_s+"," +currentChat_params[:user_id_to].to_s+")")
                render json: @conversation
            end

            def seeAllChat
                @conversation = Conversation.find_by_sql("SELECT c.user_id_from, c.user_id_to, d.name as name_from, e.name AS name_to, c.message, c.read_status, c.created_at, c.id FROM conversations c 
                    JOIN users d ON c.user_id_from = d.id 
                    JOIN users e ON c.user_id_to = e.id
                    JOIN rooms f ON c.room_id = f.id
                    WHERE 1 IN (c.user_id_from,c.user_id_to) 
                    AND c.updated_at = (
                        SELECT MAX(g.updated_at) FROM conversations g
                        JOIN rooms h ON g.room_id = h.id
                        WHERE 1 IN (g.user_id_from,g.user_id_to) 
                        AND c.room_id = h.id
                    )")
                render json: @conversation
            end

            private
            def currentChat_params
                params.require(:conversation).permit(:user_id_from, :user_id_to)
            end

            private
            def conversation_params
                params.require(:conversation).permit(:user_id_from, :user_id_to, :message,:read_status, :room_id)
            end
            
        end        
    end
end