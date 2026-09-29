#!/usr/bin/env -S PYTHONPATH=../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The PixelOS Project
# SPDX-License-Identifier: Apache-2.0
#

import os
import re
import subprocess
import sys
from pathlib import Path

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = []


blob_fixups: blob_fixups_user_type = {
}  # fmt: skip

REPO_ROOT = Path(__file__).resolve().parent
COMMON_DIR = REPO_ROOT / 'common'
ANDROID_BP = COMMON_DIR / 'Android.bp'
PRODUCT_MK = COMMON_DIR / 'common-vendor.mk'
GENERATE_OVERLAYS_PY = REPO_ROOT / 'rro-utils' / 'generate-overlays.py'
OVERLAY_DIR = COMMON_DIR / 'proprietary' / 'product' / 'overlay'


def append_overlays_include():
    if not PRODUCT_MK.is_file():
        return
    line = '\ninclude vendor/gms/common/overlays.mk\n'
    body = PRODUCT_MK.read_text()
    if 'overlays.mk' not in body:
        PRODUCT_MK.write_text(body.rstrip() + line)


def run_generate_overlays(src: str):
    if not GENERATE_OVERLAYS_PY.is_file() or not OVERLAY_DIR.is_dir():
        return
    src_path = Path(src)
    dump_path = src_path if src_path.is_dir() else src_path.with_suffix('')
    if not dump_path.is_dir():
        return
    framework_path = dump_path / 'system' / 'framework' / 'framework-res.apk'
    if not framework_path.is_file():
        return
    subprocess.run(
        [
            str(GENERATE_OVERLAYS_PY),
            str(OVERLAY_DIR),
            '--framework-res', str(framework_path),
        ],
        cwd=REPO_ROOT,
        check=False,
    )


def detect_source() -> str:
    for arg in reversed(sys.argv[1:]):
        if arg.startswith('-'):
            continue
        return arg
    return os.environ.get('SRC', '')


module = ExtractUtilsModule(
    'common',
    'gms',
    device_rel_path='vendor/gms',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
    skip_main_proprietary_file=True,
)

module.add_proprietary_file('proprietary-files.txt')


if __name__ == '__main__':
    if not COMMON_DIR.is_dir():
        COMMON_DIR.mkdir()
    for _f in [
        COMMON_DIR / 'Android.bp',
        COMMON_DIR / 'Android.mk',
        COMMON_DIR / 'BoardConfigVendor.mk',
        COMMON_DIR / 'common-vendor.mk',
    ]:
        if not _f.exists():
            _f.touch()

    utils = ExtractUtils.device(module)
    utils.run()

    append_overlays_include()

    if not any(a in ('--regenerate_makefiles', '-m') for a in sys.argv):
        src = detect_source()
        if src and src not in ('adb', ''):
            run_generate_overlays(src)
