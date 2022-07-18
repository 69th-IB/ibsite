class ManageServerChannel < ApplicationCable::Channel
  def subscribed
    unless current_user.can? :manage_server
      reject
      return
    end

    stream_from :manage_server_channel

    transmit({
      state: "stopped",
    })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
