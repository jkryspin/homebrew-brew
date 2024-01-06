class MipsLinuxGnuGcc < Formula
  desc "GNU compiler collection for mips-linux-gnu"
  homepage "https://gcc.gnu.org"
  url "https://ftp.gnu.org/gnu/gcc/gcc-13.2.0/gcc-13.2.0.tar.xz"
  mirror "https://ftpmirror.gnu.org/gcc/gcc-13.2.0/gcc-13.2.0.tar.xz"
  sha256 "e275e76442a6067341a27f04c5c6b83d8613144004c0413528863dc6b5c743da"
  license "GPL-3.0-or-later" => { with: "GCC-exception-3.1" }

  livecheck do
    formula "gcc"
  end

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mips-linux-gnu-binutils"
  depends_on "mpfr"

  def install
    target = "mips-linux-gnu"
    mkdir "mips-linux-gnu-gcc-build" do
      system "../configure", "--target=#{target}",
                              "--prefix=#{prefix}",
                              "--infodir=#{info}/#{target}",
                              "--disable-nls",
                              "--without-isl",
                              "--without-headers",
                              "--with-as=#{Formula["mips-linux-gnu-binutils"].bin}/mips-linux-gnu-as",
                              "--with-ld=#{Formula["mips-linux-gnu-binutils"].bin}/mips-linux-gnu-ld",
                              "--enable-languages=c,c++",
                              "--disable-shared"
      system "make", "all-gcc", "-j#{ENV.make_jobs}"
      system "make", "install-gcc"
      # system "make", "all-target-libgcc"
      # system "make", "install-target-libgcc"

      # FSF-related man pages may conflict with native gcc
      (share/"man/man7").rmtree
    end
  end

  test do
    (testpath/"test-c.c").write <<~EOS
      int main(void)
      {
        int i=0;
        while(i<10) i++;
        return i;
      }
    EOS
    system "#{bin}/mips-linux-gnu-gcc", "-c", "-o", "test-c.o", "test-c.c"
    assert_match "file format elf32-tradbigmips",
                  shell_output("#{Formula["mips-linux-gnu-binutils"].bin}/mips-linux-gnu-objdump -a test-c.o")
  end
end
