using Gst;

public int main(string args[])
{
	// Gst.init(ref args);
	// Gtk.init(ref args);

	// if (!Gst.is_initialized ()) {
	// 	stderr.puts ("Gstremer is not initialised\n");	
	// 	return -1;
	// }
	
	// Gst.Element screen = Gst.ElementFactory.make ("ximagesrc", "source");
	// Gst.Element color_convert = Gst.ElementFactory.make ("videoconvert", "convert");
	// Gst.Element encoder = Gst.ElementFactory.make ("x264enc","encoder");
	// Gst.Element flv_muxer = Gst.ElementFactory.make ("flvmux", "muxer");
	// Gst.Element file = Gst.ElementFactory.make ("filesink", "sink");

	// if (screen == null || color_convert == null || encoder == null || flv_muxer == null || file == null) {
	// 	stderr.puts ("Couldn't create a element:\n");

	// 	if (screen == null) stderr.puts ("screen");
	// 	if (color_convert == null) stderr.puts ("color converter\n");
	// 	if (encoder == null) stderr.puts ("x264 encoder\n");
	// 	if (flv_muxer== null) stderr.puts ("flv muxer\n");
	// 	if (file == null) stderr.puts ("file sink\n");

	// 	return -1;
	// }


	// // create a pipeline
	// Pipeline pipe = new Gst.Pipeline ("test");
	// 
	// pipe.add_many (
	// 	screen,
	// 	color_convert,
	// 	encoder,
	// 	flv_muxer,
	// 	file
	// );

	// if (screen.link (color_convert) != true) {
	// 	stderr.puts ("1");
	// 	return -1;
	// }
	// if (color_convert.link (encoder) != true) {
	// 	stderr.puts ("2");
	// 	return -1;
	// }
	// if (encoder.link (flv_muxer) != true) {
	// 	stderr.puts ("3");
	// 	return -1;
	// }
	// if (flv_muxer.link (file) != true) {
	// 	stderr.puts ("4");
	// 	return -1;
	// }


	// // set parameters from ximagesrc
	// file.set ("location", "./test.flv");

	// Gst.StateChangeReturn ret = pipe.set_state (Gst.State.PLAYING);

	// if (ret == Gst.StateChangeReturn.FAILURE) {
	// 	stderr.puts ("Couldn't start pipeline\n");
	// 	return -1;
	// }
	// else if ( ret == Gst.StateChangeReturn.SUCCESS)
	// {
	// 	stdout.puts ("Pipeline is playing\n");
	// }

	// get a bus before setting playing state
	// Gst.Bus bus = pipe.get_bus ();

	// Message msg = bus.timed_pop_filtered (Gst.CLOCK_TIME_NONE, Gst.MessageType.ERROR | Gst.MessageType.EOS);

	// if (msg != null)
	// {
	// 	switch (msg.type)
	// 	{
	// 		case Gst.MessageType.ERROR:
	// 			break;
	// 		case Gst.MessageType.EOS:
	// 			stdout.puts ("Stream ended");
	// 			break;
	// 		default:
	// 			assert_not_reached();
	// 	}
	// }

	// free resources
	// pipe.set_state (Gst.State.NULL);

	Gst.init (ref args);

	return new Lycheese.Application ().run (args);
}
