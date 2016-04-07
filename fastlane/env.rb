itc_email_path = File.expand_path(File.join(File.dirname(__FILE__), *%w[.. .itc-email]))
github_key_path = File.expand_path(File.join(File.dirname(__FILE__), *%w[.. .github-key]))

ENV['ITC_EMAIL'] = File.read(itc_email_path).chomp
ENV['GITHUB_KEY'] = File.read(github_key_path).chomp
