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

namespace Lycheese {
	/**
	 *  a struct to collect all the inhibit cookies
	 */

	public struct CookieCollector
	{
		public uint logout_cookie;
		public uint switch_user_cookie;
		public uint suspend_cookie;
		public uint idle_cookie;
	}
}
