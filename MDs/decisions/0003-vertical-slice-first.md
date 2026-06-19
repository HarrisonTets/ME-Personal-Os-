# Decision 0003 · Build a "vertical slice" first

**Date:** 2026-06-19 · **Status:** Accepted

## The decision
Build **one complete feature through all three layers** (the Today screen +
habits) before spreading out to every pillar.

## The choice we faced
- **Vertical slice first** — finish one feature end-to-end (brain + memory + face).
- **Full breadth first** — build all of Phase 1 (every pillar's screens) at once.

## Why vertical slice
- It **proves the architecture works** before we copy the pattern five times. If
  something's wrong with how the layers connect, we find out now — cheaply.
- It gives you a **real, runnable app** immediately to look at and learn from.
- Every later pillar becomes "follow the same proven recipe," which is faster and
  more consistent.

## Trade-off we accepted
The app does only one thing at first (Today + habits). That's intentional — depth
before breadth.

## Result
The slice is built and verified (analyze clean, tests pass, APK builds). The
pattern is now ready to replicate for Finance, Spiritual, Focus, etc.

See: [build-log/2026-06-19-session-01.md](../build-log/2026-06-19-session-01.md)
