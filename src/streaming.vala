using Gst;
using GLib;

namespace Streaming
{
	class StreamPipeline : Gst.Pipeline	
	{
		private Gst.Element audio;
		private Gst.Element speex_encoder;
		private Gst.Element screen;
		private Gst.Element color_convert;
		private Gst.Element x264_encoder;
		private Gst.Element flv_muxer;
		private Gst.Element file;

		public StreamPipeline ()
		{
			common_init ();
			encoder_init ();
			file_init ();
			muxer_init ();
			screen_init ();

			this.add_many (
				audio,
				speex_encoder,
				screen,
				color_convert,
				x264_encoder,
				flv_muxer,
				file
				);

			// video linking
			screen.link (color_convert);
			color_convert.link (x264_encoder);
			x264_encoder.link (flv_muxer);

			// audio linking
			audio.link (speex_encoder);
			speex_encoder.link (flv_muxer);

			// muxed stream to sink
			flv_muxer.link (file);

		}

		private void common_init ()
		{
			audio = Gst.ElementFactory.make (
				"audiotestsrc", "audio"
			);

			// TODO: move somewhere else audio
			audio.set ("is-live", true);

			speex_encoder = Gst.ElementFactory.make (
				"speexenc", "speexenc"
				);

			screen = Gst.ElementFactory.make (
				"ximagesrc", "screen"
				);
			color_convert = Gst.ElementFactory.make (
				"videoconvert", "convert"
				);
			x264_encoder = Gst.ElementFactory.make (
				"x264enc", "x264enc"
				);
			flv_muxer = Gst.ElementFactory.make (
				"flvmux", "muxer"
				);
			file = Gst.ElementFactory.make (
				"filesink", "sink"
				);

			if (
				audio == null ||
				speex_encoder == null ||
				screen == null ||
				color_convert == null ||
				x264_encoder == null ||
				flv_muxer == null ||
				file == null )
			{
				stderr.puts ("Could not create an element\n");
			}
		}

		private void encoder_init ()
		{
			x264_encoder.set ("byte-stream", true);
			x264_encoder.set ("sliced-threads", true);
		}

		private void file_init ()
		{
			file.set ("location", "./test.flv");
		}

		private void muxer_init ()
		{
			flv_muxer.set ("streamable", true);
		}

		private void screen_init ()
		{
			screen.set ("use-damage", false);
		}


		private void switch_source (
			Gst.Element source,
			Gst.Element pipeline_head
		)
		{
			
		}

		public void stream ()
		{
			
			Gst.StateChangeReturn ret = this.set_state (
							Gst.State.PLAYING
							);

			if (ret == Gst.StateChangeReturn.FAILURE)
			{
				stderr.puts ("Could not start pipeline\n");
			} else {
				stdout.puts ("Pipeline is playing\n");
			}
		}

		public void end_stream ()
		{
			Gst.StateChangeReturn ret = this.set_state (
							Gst.State.NULL
							);
			if (ret == Gst.StateChangeReturn.FAILURE)
			{
				stderr.puts ("Could not stop pipeline\n");
			} else {
				stdout.puts ("Pipeline was stopped\n");
			}
		}

		public bool stream_webcam ()
		{
			return true;
		}

		public bool stream_screen ()
		{
			return true;
		}

		public bool stream_both ()
		{
			return true;
		}

	}
}

