itc_email_path = File.expand_path(File.join(File.dirname(__FILE__), *%w[.. .itc-email]))

ENV['ITC_EMAIL'] = File.read(itc_email_path).chomp
