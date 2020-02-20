Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B26166802
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Feb 2020 21:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgBTUIs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Feb 2020 15:08:48 -0500
Received: from smtp.infotech.no ([82.134.31.41]:47204 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbgBTUIs (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 20 Feb 2020 15:08:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 3485C204259;
        Thu, 20 Feb 2020 21:08:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aHTkePfw4SU1; Thu, 20 Feb 2020 21:08:42 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id C46A1204155;
        Thu, 20 Feb 2020 21:08:41 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Damien.LeMoal@wdc.com
Subject: [PATCH v3 00/15] host managed ZBC + doublestore
Date:   Thu, 20 Feb 2020 15:08:23 -0500
Message-Id: <20200220200838.15809-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patchset is a follow-on from an earlier patchset titled:
    [RFC v2 0/6] scsi_debug: random doublestore verify
posted on the linux-scsi list on 20200109.

The major addition is support for host-managed ZBC devices.
The bulk of the work in this area was done by Damien Le Moal.
It allows ZBC devices with a mix of conventional and
"sequential write required" zones to be specified. These
follow the same model as direct access devices in this
driver. Namely, each device has its own metadata (including
its write pointer(s)) but all (scsi_debug) devices share the
same user data store (see doublestore below).

Significantly, this simulation passes the test/zbc_tests.sh
script in the https://github.com/hgst/libzbc repository.

The lower numbered patches in this set contain various
measures to improve the speed and usefulness of this driver.
It is being used to test the rewrite of the SCSI generic (sg)
driver which is still underway. Disk to disk copies are the
test of choice by the author [DG]. Comparing the results
between (simulated) disks is useless since all scsi_debug
devices share the same user data store. This limitation was
circumvented by adding the doublestore parameter. When set,
doublestore doubles the data store and allocates them in an
alternating pattern to each scsi_debug device. To enhance
the comparisons, simulations of VERIFY(10 and 16) commands
have been added. A further enhancement is to simulate the
PRE-FETCH command (which does nothing as the data is
already cached).

doublestore can also help with ZBC testing. Single threaded
copy commands like dd (and ddpt) can be used to copy one
non-empty zone into another empty zone. Multiple-threaded
copies (e.g. sgp_dd) can do out-of-order WRITEs which
become a WRITE VIOLATION error in a "sequential write
required" zone.

The author [DG] found that precise command duration timing
gave a false impression of how "bulletproof" the sg driver
state machines and locking were. The first patch involves
randomizing the command durations and it did expose various
issues in the driver under test (sg).

Since all scsi_debug memory store accesses are done in the
context of queuecommand() call, the *_irqsave() and
*_irqrestore() variants of the associated locks have been
removed.  That could be a problem if queuecommand() can ever
be called form an interrupt or related context.

Finally to address the discrepancy between command duration
times seen by the sg driver compared to what was set with
this driver's ndelay option, this driver's timekeeping for
short durations was made more accurate.

If and when this patchset is accepted, this page will be
updated:   http://sg.danny.cz/sg/sdebug26.html
This patchset is against Martin Petersen's git repository
and its 5.7/scsi-queue branch.

Changes since v2 (RFC):
  - add support for host-managed zbc devices with
    conventional and "sequential write required"
    zones [DLM]

Changes since v1 (RFC):
  - testing with version 1 caused several strange crashes that
    turned out to be caused by a code trick to read in the
    data-out buffer but _not_ place it in the big fake_storep
    array. This approach failed badly when multiple threads
    were doing verifies at the same time.
  - replace the code trick with a new do_dout_fetch() function
  - since the code trick was borrowed from the COMPARE AND
    WRITE implementation [resp_comp_write()] using
    do_dout_fetch() fixes the same bug in the existing driver
    which hasn't been reported (yet).

Damien Le Moal (3):
  scsi_debug: zone_max_open module parameter
  scsi_debug: zone_nr_conv module parameter
  scsi_debug: zone_size_mb module parameter

Douglas Gilbert (12):
  scsi_debug: randomize command completion time
  scsi_debug: add doublestore option
  scsi_debug: implement verify(10), add verify(16)
  scsi_debug: weaken rwlock around ramdisk access
  scsi_debug: improve command duration calculation
  scsi_debug: implement pre-fetch commands
  scsi_debug: expand zbc support
  scsi_debug: add zone commands
  scsi_debug: zbc module parameter
  scsi_debug: re-arrange parameters alphabetically
  scsi_debug: zbc parameter can be string
  scsi_debug: bump to version 1.89

 drivers/scsi/scsi_debug.c | 1593 ++++++++++++++++++++++++++++++++-----
 1 file changed, 1389 insertions(+), 204 deletions(-)

-- 
2.25.0

