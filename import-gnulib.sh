git clone https://git.savannah.gnu.org/git/gnulib.git gnulib-tool
gnulib-tool/gnulib-tool --import \
  --lib=libgnu \
  --source-base=gnulib \
  --m4-base=m4 \
  --doc-base=doc \
  --tests-base=tests \
  --aux-dir=. \
  --no-conditional-dependencies \
  --no-libtool \
  --macro-prefix=gl \
  --no-vc-files \
  fnmatch \
  regex
