// Copyright (C) 2016 Edoardo Putti
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>

using Gst;
using GLib;

namespace Streaming
{
        struct Pipeline {
                public double volume;
                public bool screen;
                public bool webcam;
        }

        class StreamPipeline : Gst.Pipeline
        {
                private Gst.Element audio;
                private Gst.Element audio_volume;
		private Gst.Element audio_queue;
		private Gst.Element aac_encoder;
		private Gst.Element screen;
		private Gst.Element color_convert;
		private Gst.Element video_queue;
		private Gst.Element x264_encoder;
		private Gst.Element flv_muxer;
		private Gst.Element stream_queue;
		private Gst.Element rtmp_sink;

                public signal void pipeline_start_error ();
                public signal void pipeline_start_ok ();
                public signal void pipeline_stop_error ();
                public signal void pipeline_stop_ok ();

		public StreamPipeline ()
		{
			common_init ();
			encoder_init ();
			muxer_init ();
			screen_init ();

			this.add_many (
				audio,
                                audio_volume,
				audio_queue,
				aac_encoder,
				screen,
				color_convert,
				video_queue,
				x264_encoder,
				flv_muxer,
				stream_queue,
				rtmp_sink
				);

			// video linking
			screen.link (video_queue);
			video_queue.link (color_convert);
			color_convert.link  (x264_encoder);
			x264_encoder.link (flv_muxer);

			// audio linking
			audio.link (audio_volume);
                        audio_volume.link (audio_queue);
			audio_queue.link (aac_encoder);
			aac_encoder.link (flv_muxer);

			// muxed stream to sink
			flv_muxer.link (stream_queue);
			stream_queue.link (rtmp_sink);

		}

		private void common_init ()
		{
			audio = Gst.ElementFactory.make (
				"autoaudiosrc", "audio"
			        );

                        audio_volume = Gst.ElementFactory.make (
                                "volume", "volume_control"
                                );

			audio_queue = Gst.ElementFactory.make (
				"queue", "audioqueue"
				);

			aac_encoder = Gst.ElementFactory.make (
				"voaacenc", "aacenc"
				);

			screen = Gst.ElementFactory.make (
				"ximagesrc", "screen"
				);
			video_queue = Gst.ElementFactory.make (
				"queue", "videoqueue"
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
			stream_queue = Gst.ElementFactory.make (
				"queue", "streamqueue"
				);
			rtmp_sink = Gst.ElementFactory.make (
				"rtmpsink", "rtmp_sink"
				);

			if (
				audio == null ||
				aac_encoder == null ||
				audio_queue == null ||
				screen == null ||
				video_queue == null ||
				color_convert == null ||
				x264_encoder == null ||
				flv_muxer == null ||
				stream_queue == null ||
				rtmp_sink == null
				)
			{
				stderr.puts ("Could not create an element\n");
			}
		}

		private void encoder_init ()
		{
                        // 0: Constant Bitrate Encoding is required in many
                        // streaming services
                        x264_encoder.set ("pass", 0);
                        // byte-stream: false, do not generate byte stream format of NALU
			x264_encoder.set ("byte-stream", false);
                        // Maximal distance between two key-frames
			x264_encoder.set ("key-int-max", 60);
                        // Number of B-frames between I and P
			x264_encoder.set ("bframes", 0);
                        // Use AU (Access Unit) delimiter
			x264_encoder.set ("aud", true);
                        // Preset name for non-psychovisual tuning options
                        // 0x00000004: zerolatency
                        x264_encoder.set ("tune", 0x00000004);
                        
                        // Preset name for speed/quality tradeoff options
                        // (can affect decode compatibility - impose
                        // restrictions separately for your target decoder)
                        // 1: ultrafast
                        x264_encoder.set ("speed-preset", 1);
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
                                pipeline_start_error ();
			} else {
				stdout.puts ("Pipeline is playing\n");
                                pipeline_start_ok ();
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
                                pipeline_stop_error ();
			} else {
				stdout.puts ("Pipeline was stopped\n");
                                pipeline_stop_ok ();
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
                        return;
		}

                public void set_volume (double val)
                {
                        audio_volume.set ("volume", val);
                        return;
                }

	}
}

