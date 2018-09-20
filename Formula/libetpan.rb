class Libetpan < Formula
  desc "Portable mail library handling several protocols"
  homepage "https://www.etpan.org/libetpan.html"
  url "https://github.com/dinhviethoa/libetpan/archive/1.9.1.tar.gz"
  sha256 "f5e354ccf1014c6ee313ade1009b8a82f28043d2504655e388bb4c1328700fcd"

  bottle do
    cellar :any
    sha256 "2794eb0a205cbd29549208b8cfb70b85a3e8b2a44b6649c0acdfa2caaf38904c" => :mojave
    sha256 "ff101491c3d0ab63daa872418476e1e8a0d8884163b6b23e1044324368924444" => :high_sierra
    sha256 "d4dc8cccd6f5db46bf0a857401b36bfdce2d19547b2fc764f71cda39c841f5fe" => :sierra
    sha256 "ac094e06ea8c19f32bb71ec444280e66fb1821ff53236f8c8d3b449b89a36592" => :el_capitan
    sha256 "1478d36967c7fa2850488ca83d9985d525224c658dbb1d40a656877b69601991" => :yosemite
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./autogen.sh", "--disable-debug",
                           "--disable-dependency-tracking",
                           "--disable-silent-rules",
                           "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libetpan/libetpan.h>
      #include <string.h>
      #include <stdlib.h>

      int main(int argc, char ** argv)
      {
        printf("version is %d.%d",libetpan_get_version_major(), libetpan_get_version_minor());
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-letpan", "-o", "test"
    system "./test"
  end
end
