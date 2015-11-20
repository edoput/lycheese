using Gst;
using GLib;

namespace Streaming
{
	class StreamPipeline : Gst.Pipeline	
	{
		private Gst.Element audio;
		private Gst.Element mp3_encoder;
		private Gst.Element screen;
		private Gst.Element color_convert;
		private Gst.Element x264_encoder;
		private Gst.Element flv_muxer;
		private Gst.Element rtmp_sink;

		public StreamPipeline ()
		{
			common_init ();
			encoder_init ();
			muxer_init ();
			screen_init ();

			this.add_many (
				audio,
				mp3_encoder,
				screen,
				color_convert,
				x264_encoder,
				flv_muxer,
				rtmp_sink
				);

			// video linking
			screen.link (color_convert);
			color_convert.link (x264_encoder);
			x264_encoder.link (flv_muxer);

			// audio linking
			audio.link (mp3_encoder);
			mp3_encoder.link (flv_muxer);

			// muxed stream to sink
			flv_muxer.link (rtmp_sink);

		}

		private void common_init ()
		{
			audio = Gst.ElementFactory.make (
				"audiotestsrc", "audio"
			);

			// TODO: move somewhere else audio
			audio.set ("is-live", true);

			mp3_encoder = Gst.ElementFactory.make (
				"lamemp3enc", "mp3enc"
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
			rtmp_sink = Gst.ElementFactory.make (
				"rtmpsink", "rtmp_sink"
				);

			if (
				audio == null ||
				mp3_encoder == null ||
				screen == null ||
				color_convert == null ||
				x264_encoder == null ||
				flv_muxer == null ||
				rtmp_sink == null
				)
			{
				stderr.puts ("Could not create an element\n");
			}
		}

		private void encoder_init ()
		{
			x264_encoder.set ("byte-stream", true);
		}

		private void muxer_init ()
		{
			flv_muxer.set ("streamable", true);
		}

		private void rtmp_sink_init ()
		{
			rtmp_sink.set ("location", "rtmp://127.0.0.1:1935/live/livestream");
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

		public bool stream_default ()
		{
			return true;
		}

		public void set_rtmp (string url, string key)
		{
			rtmp_sink.set ("location", url + "/" + key);
		}

	}
}

