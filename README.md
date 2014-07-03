# Tethys -- a small postgresql event store

WIP

## Features

- EventSets, created for each commit
- EventSets can be compressed to save on row count
- Snapshots for faster deserialization

## Todo

- Repository uses snapshots if they're available
- Partial playback from snapshot
