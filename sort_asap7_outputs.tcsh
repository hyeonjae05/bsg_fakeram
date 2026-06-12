#!/bin/tcsh

# Usage:
#   ./sort_asap7_outputs.tcsh <macro_name> [tech]
# Example:
#   ./sort_asap7_outputs.tcsh fakeram_1024x256_1rw_mask
#   ./sort_asap7_outputs.tcsh fakeram_256x1024_1rw asap7

if ( $#argv < 1 || $#argv > 2 ) then
  echo "Usage: $0 <macro_name> [tech]"
  exit 1
endif

set macro = "$1"
set tech  = "asap7"
if ( $#argv == 2 ) then
  set tech = "$2"
endif

set src_dir = "$HOME/1_WORKSPACE/Tech/tools/bsg_fakeram/results/${tech}/${macro}"
set dst_root = "$HOME/1_WORKSPACE/Tech/${tech}"
set dst_lib = "${dst_root}/lib"
set dst_lef = "${dst_root}/lef"
set dst_rtl = "${dst_root}/rtl"

if ( ! -d "${src_dir}" ) then
  echo "[ERROR] Source dir not found: ${src_dir}"
  exit 2
endif

mkdir -p "${dst_lib}" "${dst_lef}" "${dst_rtl}"

set lib_file = "${src_dir}/${macro}.lib"
set lef_file = "${src_dir}/${macro}.lef"
set rtl_file = "${src_dir}/${macro}.v"
set bb_file  = "${src_dir}/${macro}.bb.v"

if ( ! -f "${lib_file}" ) then
  echo "[ERROR] Missing file: ${lib_file}"
  exit 3
endif
if ( ! -f "${lef_file}" ) then
  echo "[ERROR] Missing file: ${lef_file}"
  exit 3
endif
if ( ! -f "${rtl_file}" ) then
  echo "[ERROR] Missing file: ${rtl_file}"
  exit 3
endif
if ( ! -f "${bb_file}" ) then
  echo "[ERROR] Missing file: ${bb_file}"
  exit 3
endif

cp -f "${lib_file}" "${dst_lib}/"
cp -f "${lef_file}" "${dst_lef}/"
cp -f "${rtl_file}" "${dst_rtl}/"
cp -f "${bb_file}"  "${dst_rtl}/"

if ( $status != 0 ) then
  echo "[ERROR] Copy failed."
  exit 4
endif

echo "[DONE] Copied files for ${macro} (${tech})"
echo "  - ${dst_lib}/${macro}.lib"
echo "  - ${dst_lef}/${macro}.lef"
echo "  - ${dst_rtl}/${macro}.v"
echo "  - ${dst_rtl}/${macro}.bb.v"
