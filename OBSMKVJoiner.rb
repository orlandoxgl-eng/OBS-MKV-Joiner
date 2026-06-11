require 'gtk4'

class OBSJoiner
  def initialize
    @app = Gtk::Application.new("com.obs.joiner")

    @app.signal_connect("activate") do
      build_ui
    end
  end

  def build_ui
    @window = Gtk::ApplicationWindow.new(@app)
    @window.set_title("OBS MKV Joiner")
    @window.set_default_size(600, 250)

    box = Gtk::Box.new(:vertical, 10)
    box.margin_top = 15
    box.margin_bottom = 15
    box.margin_start = 15
    box.margin_end = 15

    title = Gtk::Label.new("OBS MKV Joiner")
    box.append(title)

    folder_label = Gtk::Label.new("Carpeta con videos MKV:")
    box.append(folder_label)

    @folder_entry = Gtk::Entry.new
    @folder_entry.placeholder_text = "/home/usuario/Vídeos/OBS"
    box.append(@folder_entry)

    join_button = Gtk::Button.new(label: "Unir Videos")

    join_button.signal_connect("clicked") do
      join_videos
    end

    box.append(join_button)

    @status = Gtk::Label.new("Esperando...")
    box.append(@status)

    @window.set_child(box)
    @window.present
  end

  def join_videos
    begin
      folder = @folder_entry.text.strip

      if folder.empty?
        @status.set_text("Ingrese una carpeta.")
        return
      end

      unless Dir.exist?(folder)
        @status.set_text("La carpeta no existe.")
        return
      end

      files = Dir.glob(File.join(folder, "*.mkv")).sort

      if files.empty?
        @status.set_text("No se encontraron archivos MKV.")
        return
      end

      list_file = File.join(folder, "obs_join_list.txt")

      File.open(list_file, "w") do |f|
        files.each do |video|
          f.puts "file '#{video}'"
        end
      end

      output_file = File.join(folder, "video_final.mkv")

      @status.set_text("Procesando #{files.length} archivos...")

      command = [
        "ffmpeg",
        "-f", "concat",
        "-safe", "0",
        "-i", list_file,
        "-c", "copy",
        "-y",
        output_file
      ]

      success = system(*command)

      if success
        @status.set_text("Listo: #{output_file}")
      else
        @status.set_text("FFmpeg devolvió un error.")
      end

    rescue => e
      @status.set_text("Error: #{e.message}")
      puts e.full_message
    end
  end

  def run
    @app.run
  end
end

OBSJoiner.new.run