# ActsAsFlyingSaucer
#
module ActsAsFlyingSaucer

  # Xhtml2Pdf
  #
  class Xhtml2Pdf
   
    # Xhtml2Pdf.write_pdf
    #
    def self.write_pdf(options)
     
      File.open(options[:input_file], 'w') do |file|
        file << options[:html]
      end

      if defined?(JRUBY_VERSION)
        input = options[:input_file]
        output = options[:output_file]
        url = java.io.File.new(input).toURI.toURL.toString

        os = java.io.FileOutputStream.new(output)

        renderer = org.xhtmlrenderer.pdf.ITextRenderer.new
        renderer.setDocument(url)
        renderer.layout
        renderer.createPDF(os)
        os.close
      else
        java_dir = File.join(File.expand_path(File.dirname(__FILE__)), "java")
        class_path = ".:#{java_dir}/jar/acts_as_flying_saucer.jar"

        if options[:nailgun]
	        command = "#{Nailgun::NgCommand::NGPATH} Xhtml2Pdf #{options[:input_file]} #{options[:output_file]}"
        else
          command = "#{options[:java_bin]} -Xmx512m -Djava.awt.headless=true -cp #{class_path} acts_as_flying_saucer.Xhtml2Pdf #{options[:input_file]} #{options[:output_file]}"
        end
        system(command)
      end
     end
      def self.encrypt_pdf(options,output_file_name,password)
        java_dir = File.join(File.expand_path(File.dirname(__FILE__)), "java")
        class_path = ".:#{java_dir}/jar/acts_as_flying_saucer.jar"
        if options[:nailgun]
	        command = "#{Nailgun::NgCommand::NGPATH} encryptPdf #{options[:input_file]} #{options[:output_file]}"
	      else  
	        command = "#{options[:java_bin]} -Xmx512m -Djava.awt.headless=true -cp #{class_path} acts_as_flying_saucer.encryptPdf #{options[:output_file]} #{output_file_name} #{password}"
	      end
        system(command)
      end
   
  end
end

