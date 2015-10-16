# deps

writing a gstreamer plugin bind requires a handful of tools, the most notable are

- gstreamer1.0-tools, required for gst-inspect, a utility to inspect plugin installed on the system
- gstreamer1.0-plugin-good, the plugins required
- automake
- valadoc
- valac


## inspect for gstreamer plugins

To inspect your system and list the gstreamer plugins installed use `gst-inspect1.0` from the _gstreamer1.0-tools_ package

	gst-inspect1.0 ximagesrc

 you can find the sample output from my machine in [inspect.log](./inspect.log).


## inspect for gstreamer available plugins from Vala

Here it is a snippet of the code needed to retrieve the names of the plugins available with Gstreamer from Vala

	 // namespace
	 using Gst;

	 int main (string args[])
	 {
		// init Gstreamer
		Gst.init(ref args);
		// retrieves the singleton of the plugin registry
		Registry registry = Registry.get ();
		// instantiae and retrieve the list of plugin available
		List<Plugin> plugins = registry.get_plugin_list();
		// print the name of each plugin
		plugins.foreach ((entry)=>{
			stdouts.puts (entry.get_name ());
			stdouts.puts ("\n");
		});
		// end
		return 0;
	 }
 
