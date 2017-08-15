class SyncronizerJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    p "Beggining this test"
    sleep 3
    p "Finishing this test"
  end
end
