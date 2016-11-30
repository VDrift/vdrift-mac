# VDrift - Open Source Racing Simulator

## VDrift OS X Dependencies

VDrift is a cross-platform, open source driving simulation made with drift
racing in mind. The driving physics engine was recently re-written from scratch
but was inspired and owes much to the Vamos physics engine. It is released under
the GNU General Public License (GPL) v3. It is currently available for Windows,
macOS, Linux, and FreeBSD.

### See also

- http://wiki.vdrift.net/About_the_project
- http://wiki.vdrift.net/License

## Hardware Requirements

### CPU

VDrift requires a relatively fast CPU. A 2 GHz or better clock speed is
recommended, although it should be possible to run VDrift with a 1 GHz or better
CPU.

### GPU

VDrift requires a recent nVidia or ATI graphics card. Intel graphics cards are
not recommended.

A nVidia GeForce 7-series or ATI Radeon X1000-Series card is recommended in
order to enable all the visual effects. By reducing or disabling some of the
display options, it should be possible to play VDrift with a nVidia GeForce 2 or
an ATI Radeon 7000.

### Hard Drive

When following this readme, one will typically need about 5.5 GiB hard disk
space. VDrift source code and data sum up to about 3.5 GiB at the build location
and installation requires about 2 GiB of space including dependencies.

### Network Transfer

About 2 - 3 GiB network transfer volume are required for downloading VDrift, its
data and dependencies.

### RAM

VDrift consumes 300 MiB of memory space on a typical run, so 512 MiB of memory
is the minimum requirement. However, 1 GiB or more of memory is recommended,
especially for larger tracks.

### See also

- http://wiki.vdrift.net/Hardware_requirements

## Downloading VDrift

VDrift consists of two essential parts; the core source code and content data.
You will also need the dependancies for OS X.

### Downloading Source

Download the source code from the repository

    git clone https://github.com/VDrift/vdrift.git

### Downloading Data

VDrift Data is expected to reside in a folder called *data* in the root of
VDrift, so change your directory to the root of the sources:

    cd vdrift

Currently the data is still hosted at Sourceforge, so to getting it requires
checking out the repository with subversion:

    svn checkout https://vdrift.svn.sourceforge.net/svnroot/vdrift/vdrift-data data

### Downloading OS X Dependencies

Download platform specific build dependencies on macOS:

    git clone https://github.com/VDrift/vdrift-mac.git

### See also

- http://wiki.vdrift.net/Getting_the_latest_release
- http://wiki.vdrift.net/Getting_the_development_version
- http://wiki.vdrift.net/Software_requirements

## Compiling VDrift

- The VDrift OS X project requires Xcode 3.2 or later. You can download the latest version for free at https://developer.apple.com/xcode/.
- Open *vdrift/vdrift-mac/vdrift.xcodeproj* and in Xcode 4 or higher click
"Build" in the "Product" menu, otherwise hit "Build" from Xcode's "Build" menu.

## Error Fixing

If when building, you get some errors, it is most likely because the Xcode
project is out of date (it often is as we don't have an active macOS developer).
To fix it:

- Remove files from Xcode that are in the project but not in the repository
anymore.
- Add new files to Xcode that are in the repository, but have not yet been added
to the project.

## Everything further

For configuring, running and extending the game, playing, contributing and
developing please search the wiki for an article on your topic:

- http://wiki.vdrift.net/Main_Page
