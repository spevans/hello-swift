# project1 - Implementing a minimal bare metal kernel in Swift

## What is it?

A project to write a kernel in Swift with that can boot on a Mac or PC.
The main aim is to get a simple kernel booting up with a CLI with full
concurrency/thread support.

There is a short writeup about it [here](http://si.org/projects/project1).

## What does it do?

- Boots up Under QEMU/Bochs or on a Macbook as a EFI image (via GRUB) or .iso
  on a usbkey
- Scans ACPI/SMBIOS tables
- Installs interrupts and exception/fault handlers
- Sets up paging
- Scans PCI bus
- Initialises the APIC and IO/APIC (or PIC), PIT and PS/2 keyboard controller
- Setups an APIC timer and PIT timer and shows a test message with interrupt
  counts.
- Runs a simple task reading keyboard scan codes from a circular buffer and
  translates them to ASCII codes to show on the screen. The Macbook doesnt
  have an i8042 PS/2 keyboard controller so the keyboard will not work.

The next major tasks are:

- ACPI parser and bytecode interpreter to find the full device tree
- USB controller and USB keyboard driver
- Bring all processor cores online
- Run a task on each core to show up concurrency issues
- Implement locking and mutexs etc to try and solve the concurrency issues


## How to build it

Currently it only builds on linux. It requires:

* clang
* nasm (known to work with 2.11.09rc1 but earlier should be ok)

To build a .iso for a usbkey also requires:
* xorriso
* mtools


A special version of the Swift compiler and stdlib is required to disable the
red zone and also remove floating point functions from the stdlib library.
See [here](doc/development.md#red-zone) to build this version. A snapshot can
be downloaded from (https://github.com/spevans/swift-kstdlib/releases). Normally
the latest one with the highest date is required. The version required is listed
in the `Makedefs` file in the `SWIFTDIR` variable eg:
```
SWIFTDIR := $(shell readlink -f ~/swift-kernel-20170314)
```

A normal Swift 3.0 [snapshot](https://swift.org/download/#snapshots) is required
to build some build tools that patch the image for booting.

You should now have 2 compilers installed, one in `~/swift-kernel-<YYYYMMDD>`
and the other where ever you installed the snapshot (I install it and symlink
`~/swift-3` to it).

Edit the `Makedefs` file and alter the `SWIFT3DIR` and `SWIFTDIR` as appropriate.


then:
```
$ make
```

To run under qemu with a copy of the console output being sent to a virtual
serial port use:
```
$ qemu-system-x86_64 -hda output/boot-hd.img -serial stdio -D log -d int,cpu_reset,guest_errors,unimp -no-reboot
```

There is a bochsrc to specify the HD image so it can be run with:
```
$ bochs -q  (then press 'c' to run)
```

To build a .ISO image suitable for booting one from a USB stick, use the `iso`
target. This will also create a `kernel.efi` file that can be booted in GRUB
```
$ make iso
```


![Screenshot](doc/screenshot.png)

## Build using Docker

**Note: This method can be used to build with *Docker for Mac***

The docker image is based on ubuntu:16.04 and contains packages needed to build the repo.

```
$ docker run --rm -v <absolute-path-to-repo>:/root/swift-project1 -v <absolute-path-to-normal-swift3>:/root/swift -v <absolute-path-to-swift-kernel>:/root/swift-kernel-20170407 abhishekmunie/swift-project1
```

To run under qemu with a copy of the console output being sent to a virtual
serial port use:
```
$ qemu-system-x86_64 -hda output/boot-hd.img -serial stdio -D log -d int,cpu_reset,guest_errors,unimp -no-reboot
```

To build a .ISO image suitable for booting one from a USB stick, use the `iso`
target. This will also create a `kernel.efi` file that can be booted in GRUB
```
$ docker run --rm -v <absolute-path-to-repo>:/root/swift-project1 abhishekmunie/swift-project1 make iso
```

To clean repository
```
$ docker run --rm -v <absolute-path-to-repo>:/root/swift-project1 abhishekmunie/swift-project1 make clean
```


Copyright (c) 2015 - 2017 Simon Evans

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
