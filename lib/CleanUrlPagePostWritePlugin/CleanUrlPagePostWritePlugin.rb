# CleanUrlPagePostWritePlugin - a page post-write hook plugin to allow for clean permalinks to html pages
#
# As of Jekyll 3.6.2, there did not seem to be a way to add a hook to modify the file
# extension for HTML files before they were written during site generation. This plugin
# looks for HTML files (*.html or *.htm) that have already been written to disk, and renames
# them if they have a clean (exensionless) permalink set in the YAML front matter.
#
# Copyright 2017 James Kearney
# License: MIT License
#
module CleanUrlPagePostWritePlugin

  Jekyll::Hooks.register :pages, :post_write do |page|

    if ((page.output_ext.casecmp(".html") == 0) || (page.output_ext.casecmp(".htm") ==0))
      if !(page.data["permalink"].end_with?(".html") || page.data["permalink"].end_with?("/"))
        render_dest = page.destination(page.dir)
        clean_dest = render_dest.sub(/\.html$/,"")
        File.rename(render_dest, clean_dest)
      end
    end

  end

end
