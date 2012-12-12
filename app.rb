module RFC5861
  STATUS_FILE = 'app.status'
  
  class App
    def call(env)
      headers = {
        "Content-Type"  => "text/plain",
        "Last-Modified" => Time.now.to_s,
        "Connection"    => "close"
      }
      
      status_code = File.exists?(STATUS_FILE) ? File.open(STATUS_FILE,'r').read.to_i : 200
      
      case status_code
      when 200
        message = "Hello world! I'm ok @ #{Time.now}"
        headers["Cache-Control"] = "max-age=10,stale-while-revalidate=10,stale-if-error=20"
      when 500..599
        message = "Ops! I'm not ok @ #{Time.now}"
        headers["Cache-Control"] = "must-revalidate,no-cache,no-store"
      end
      
      final_message = message + " (status code: #{status_code})\n"
      headers["Content-Length"] = final_message.bytesize.to_s    
      [status_code, headers, [final_message]]
    end
  end
end
