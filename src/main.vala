using Gst;

public int main(string args[])
{
	Gst.init (ref args);

	return new Lycheese.Application ().run (args);
}
