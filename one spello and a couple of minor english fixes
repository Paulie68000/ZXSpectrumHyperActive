# ZXSpectrumHyperActive
Fully reverse engineered source code to Jonathan Smith's Hyper Active covermount game

The second in a series of fully documented source code of Jonathan Joffa Smith's ZX Spectrum titles.

This game was featured as a giveaway as a cover tape on Sinclair User.  It started life straight after
Cobra as a Defender/Dropzone clone, named "Newt". I actually started working on the C64 version of this when I first
started at Ocean.  Alas, the game ceased development in just a few weeks as Joff was about to set up Special FX
alongside Paul Finnegan and move to a new office at the Albert Dock in Liverpool.

Several years later as a final Spectrum game before moving to the 16 bit computers, Joff rekindled and finished
the title, now renamed "Hyper Acticve" as a giveaway for Sinclair User - Tony Pomfret then did a covermount version for the C64 at the same time.

If you've gone through the Cobra source code you can see Hyper Active's heritage, as I say it was developed directly after it and, as with a lot
of Joff's games, had a lot of reusable code.

## A Peek under the hood

In order to run the game at 50 fps, a few shorcuts were taken, noticably only the player sprite and pods are masked onto the screen, all other sprites are
OR'ed into the framebuffer.

There is no backbuffer used in Hyperactive - the game draws everything directly to video memory and "chases the beam" in order to not flicker.  The play area is quickly
cleared with a tight loop of push instructions, followed by the landscape which is zig-zag drawn with preshifted mountain tiles.  The Player sprite doesn't move in X so
no preshifts are required and so they are drawn with the stack using zig-zagged interleaved mask and data words like Cobra.  The baddy sprites are first sorted on Y to ensure an
ascending order in which to draw everything before the CRT beam catches us.  These sprites are OR'ed directly into the framebuffer (which is why they tend to noticably blend into
the mountain range and each other when there are loads of baddies on the screen).


