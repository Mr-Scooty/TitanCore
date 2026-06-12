#!/usr/bin/env python3
"""Split a mysqldump file into one .sql file per table.

Tables whose dump exceeds --chunk-bytes are split into a structure+data file
(<table>.sql) plus data-only part files (<table>_pNN.sql). Part files sort
after the structure file ('.' < '_' byte-wise), so applying all files of a
directory in sorted order is always correct.

Every output file is self-contained: it carries the mysqldump session header
(SET NAMES, TIME_ZONE='+00:00', FOREIGN_KEY_CHECKS=0, NO_AUTO_VALUE_ON_ZERO)
and the matching restore footer, so files can also be re-applied individually.

Input line endings are normalized to LF (the repo's .gitattributes would do
this on commit anyway). Reads from stdin with --input -.
"""

import argparse
import os
import re
import sys

TABLE_MARKER = b'-- Table structure for table `'
TABLE_RE = re.compile(rb'^-- Table structure for table `(.+)`')
FOOTER_MARKER = b'/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE'
INSERT_MARKER = b'INSERT INTO `'
PART_RE = re.compile(r'^(.+)_p\d+$')

HARD_LIMIT = 50 * 1024 * 1024  # GitHub large-file warning threshold


def parse_dump(stream):
    """Return (header_lines, [(table, section_lines)], footer_lines)."""
    header, sections, footer = [], [], []
    current = None  # (table, lines)
    in_footer = False

    for raw in stream:
        line = raw.replace(b'\r\n', b'\n')
        if not line.endswith(b'\n'):
            line += b'\n'

        if not in_footer and line.startswith(FOOTER_MARKER):
            in_footer = True

        if in_footer:
            if line.startswith(b'/*!'):
                footer.append(line)
            continue

        match = TABLE_RE.match(line)
        if match:
            current = (match.group(1).decode(), [])
            sections.append(current)

        if current is None:
            # Pre-table region: keep session SET conditionals, drop banner.
            if line.startswith(b'/*!'):
                header.append(line)
        else:
            current[1].append(line)

    return header, sections, footer


def write_file(path, chunks):
    data = b''.join(chunks)
    if len(data) >= HARD_LIMIT:
        sys.exit(f'ERROR: {path} would be {len(data)} bytes (>= 50 MB limit); '
                 f'lower --chunk-bytes')
    with open(path, 'wb') as f:
        f.write(data)
    return len(data)


def emit_table(table, lines, header, footer, out_dir, chunk_bytes, report):
    base_path = os.path.join(out_dir, table + '.sql')
    total = sum(len(l) for l in lines)

    if total <= chunk_bytes:
        size = write_file(base_path, [b''.join(header), b'\n',
                                      b''.join(lines), b''.join(footer)])
        report.append((os.path.basename(base_path), size))
        return

    # Oversized: split at INSERT-line boundaries.
    first_insert = next(i for i, l in enumerate(lines)
                        if l.startswith(INSERT_MARKER))
    last_insert = max(i for i, l in enumerate(lines)
                      if l.startswith(INSERT_MARKER))
    pre, data, post = (lines[:first_insert],
                       lines[first_insert:last_insert + 1],
                       lines[last_insert + 1:])

    lock_line = next(l for l in pre if l.startswith(b'LOCK TABLES'))
    disable_line = next(l for l in pre if b'DISABLE KEYS' in l)

    batches, batch, batch_size = [], [], 0
    for line in data:
        if batch and batch_size + len(line) > chunk_bytes:
            batches.append(batch)
            batch, batch_size = [], 0
        batch.append(line)
        batch_size += len(line)
    if batch:
        batches.append(batch)

    if len(batches) > 100:
        sys.exit(f'ERROR: {table} would need {len(batches)} parts; '
                 f'raise --chunk-bytes')

    size = write_file(base_path, [b''.join(header), b'\n', b''.join(pre),
                                  b''.join(batches[0]), b''.join(post),
                                  b''.join(footer)])
    report.append((os.path.basename(base_path), size))

    for idx, part in enumerate(batches[1:], start=1):
        part_path = os.path.join(out_dir, f'{table}_p{idx:02d}.sql')
        size = write_file(part_path, [b''.join(header), b'\n',
                                      lock_line, disable_line,
                                      b''.join(part), b''.join(post),
                                      b''.join(footer)])
        report.append((os.path.basename(part_path), size))


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument('--input', required=True,
                        help='mysqldump file to split, or - for stdin')
    parser.add_argument('--output-dir', required=True)
    parser.add_argument('--chunk-bytes', type=int, default=40 * 1024 * 1024,
                        help='split tables larger than this (default 40 MiB)')
    args = parser.parse_args()

    stream = sys.stdin.buffer if args.input == '-' else open(args.input, 'rb')
    header, sections, footer = parse_dump(stream)
    if args.input != '-':
        stream.close()

    if not sections:
        sys.exit('ERROR: no "-- Table structure for table" sections found')
    if not footer:
        sys.exit('ERROR: dump footer (TIME_ZONE=@OLD_TIME_ZONE) not found')

    # A real table named like a part file would break the naming scheme.
    names = {table for table, _ in sections}
    for name in names:
        match = PART_RE.match(name)
        if match and match.group(1) in names:
            sys.exit(f'ERROR: table "{name}" collides with part-file naming')

    os.makedirs(args.output_dir, exist_ok=True)
    report = []
    for table, lines in sections:
        emit_table(table, lines, header, footer, args.output_dir,
                   args.chunk_bytes, report)

    parts = len(report) - len(sections)
    print(f'{len(sections)} tables -> {len(report)} files '
          f'({parts} extra part files), largest:')
    for name, size in sorted(report, key=lambda r: -r[1])[:5]:
        print(f'  {size / 1024 / 1024:7.1f} MB  {name}')


if __name__ == '__main__':
    main()
