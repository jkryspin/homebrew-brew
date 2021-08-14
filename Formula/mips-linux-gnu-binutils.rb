# https://github.com/zeldaret/oot/blob/master/docs/BUILDING_BINUTILS_MACOS.md

class MipsLinuxGnuBinutils < Formula
  desc "A set of programs to assemble and manipulate binary and object files for the MIPS target"
  homepage "https://www.gnu.org/software/binutils/binutils.html"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.35.tar.gz"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.35.tar.gz"
  sha256 "a3ac62bae4f339855b5449cfa9b49df90c635adbd67ecb8a0e7f3ae86a058da6"
  license all_of: ["GPL-2.0-or-later", "GPL-3.0-or-later", "LGPL-2.0-or-later", "LGPL-3.0-only"]

  uses_from_macos "zlib"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--infodir=#{info}",
                          "--mandir=#{man}",
                          "--target=mips-linux-gnu",
                          "--disable-gprof",
                          "--disable-gdb",
                          "--disable-werror"
    system "make"
    system "make", "install"
  end
end
