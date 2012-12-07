module RFC5861
  class App
    def call(env)
      headers = {
        "Content-Type"  => "text/plain",
        "Last-Modified" => Time.now.to_s,
        "Connection"    => "close"
      }
      
      if File.open('app.status','r').read.match(/^1/)
        status  = 200
        message = "Hello world! I'm ok @ #{Time.now}\n"
        headers["Cache-Control"] = "max-age=10, stale-while-revalidate=10, stale-if-error=20"
      else
        status  = 500
        message = "Ops! I'm not ok @ #{Time.now}\n"
      end
      
      headers["Content-Length"] = message.bytesize.to_s    
      [status, headers, [message]]
    end
  end
end
