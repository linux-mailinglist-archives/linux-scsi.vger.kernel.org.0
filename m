Return-Path: <linux-scsi+bounces-4004-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA2189690B
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Apr 2024 10:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EEA1C246B7
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Apr 2024 08:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8957A6EB4A;
	Wed,  3 Apr 2024 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9ocLjEm"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408116CDBD;
	Wed,  3 Apr 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133770; cv=none; b=P3ISX1ujB+rMfOOxvNXpetIwhCY60XSZSXXSXpJULCk6FGx0frVGgfWy/9UkJWmZNyXXBmmMkEvyMpcoVk7RRUgzW/Rf54RtbA3rVXsawpzyfa3S/hLzTfoYcO8T3ryt8MrWLEav248nH1clluqN6jbXAOsad/U4hbKmMSBAyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133770; c=relaxed/simple;
	bh=+T+ibh0+AgWdP7ASAEc+ipRxPN0k38PcRgj5nJ6UyE0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eotDSBdD9gAVmiEvI+oI5V9KWx6LmlsFQwnbNlI2umJ70lanVmKv0MJNU2NS1KMq5l7/JuFs3yQJe2Ot0oeBytCtuVm+OoDmjJQCtAyGHDutCm2x67swjKCIIOrCwyPMtPtNY6rH4zZQ+YrknIxHAmPIDAQUlRN1Vv8XPOhJd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9ocLjEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BBDC43390;
	Wed,  3 Apr 2024 08:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133769;
	bh=+T+ibh0+AgWdP7ASAEc+ipRxPN0k38PcRgj5nJ6UyE0=;
	h=From:To:Subject:Date:From;
	b=B9ocLjEmbAkF7Z+/b9DJPbTfHPmygnq9rBmCodYjX0k3hkA/IYzCOsGoKTg98MC1R
	 zR2+mQPl99xFCEHaJE36ImEFu9XLAJkF/PeG83l+GcAkET/BOh2bnkRG41LL4ocwdb
	 p5/MuZzEWD+fPK5alYCXzUj/Oyi1gMpvvieys+WkahloGaXxYJMv7tfyolz2rX0dlE
	 UHxxBKifQvp1YRUb+4O5+L3QxsnCUNA8GF92kOc64gdDGXbouWakcb6CrRu6w4F++F
	 Lks3FNEETa1klG4NKb0Q55OHf6+7I7I1i4du/5SnZS9cLYtKx/AZxTRMJr2Wmy8PEF
	 Z7wKK6lmS4K7A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 00/28] Zone write plugging
Date: Wed,  3 Apr 2024 17:42:19 +0900
Message-ID: <20240403084247.856481-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch series introduces zone write plugging (ZWP) as the new
mechanism to control the ordering of writes to zoned block devices.
ZWP replaces zone write locking (ZWL) which is implemented only by
mq-deadline today. ZWP also allows emulating zone append operations
using regular writes for zoned devices that do not natively support this
operation (e.g. SMR HDDs). This patch series removes the scsi disk
driver and device mapper zone append emulation to use ZWP emulation.

Unlike ZWL which operates on requests, ZWP operates on BIOs. A zone
write plug is simply a BIO list that is atomically manipulated using a
spinlock and a kblockd submission work. A write BIO to a zone is
"plugged" to delay its execution if a write BIO for the same zone was
already issued, that is, if a write request for the same zone is being
executed. The next plugged BIO is unplugged and issued once the write
request completes.

This mechanism allows to:
 - Untangle zone write ordering from the block IO schedulers. This
   allows removing the restriction on using only mq-deadline for zoned
   block devices. Any block IO scheduler, including "none" can be used.
 - Zone write plugging operates on BIOs instead of requests. Plugged
   BIOs waiting for execution thus do not hold scheduling tags and thus
   do not prevent other BIOs from being submitted to the device (reads
   or writes to other zones). Depending on the workload, this can
   significantly improve the device use and the performance.
 - Both blk-mq (request) based zoned devices and BIO-based devices (e.g.
   device mapper) can use ZWP. It is mandatory for the
   former but optional for the latter: BIO-based driver can use zone
   write plugging to implement write ordering guarantees, or the drivers
   can implement their own if needed.
 - The code is less invasive in the block layer and in device drivers.
   ZWP implementation is mostly limited to blk-zoned.c, with some small
   changes in blk-mq.c, blk-merge.c and bio.c.

Performance evaluation results are shown below.

The series is based on block/for-next and organized as follows:

 - Patch 1 to 6 are preparatory changes for patch 7.
 - Patch 7 and 8 introduce ZWP
 - Patch 9 and 10 add zone append emulation to ZWP.
 - Patch 11 to 18 modify zoned block device drivers to use ZWP and
   prepare for the removal of ZWL.
 - Patch 19 to 28 remove zone write locking

Overall, these changes do not significantly increase the amount of code
(the higher number of addition shown by diff-stat is in fact due to a
larger amount of comments in the code).

Many thanks must go to Christoph Hellwig for comments and suggestions
he provided on earlier versions of these patches.

Performance evaluation results
==============================

Environments:
 - Intel Xeon 16-cores/32-threads, 128GB of RAM
 - Kernel:
   - ZWL (baseline): block/for-next (based on 6.9.0-rc2)
   - ZWP: block/for-next patched kernel to add zone write plugging
     (both kernels were compiled with the same configuration turning
     off most heavy debug features)

Workoads:
 - seqw4K1: 4KB sequential write, qd=1
 - seqw4K16: 4KB sequential write, qd=16
 - seqw1M16: 1MB sequential write, qd=16
 - rndw4K16: 4KB random write, qd=16
 - rndw128K16: 128KB random write, qd=16
 - btrfs workoad: Single fio job writing 128 MB files using 128 KB
   direct IOs at qd=16.

Devices:
 - nullblk (zoned): 4096 zones of 256 MB, 128 max open zones.
 - NVMe ZNS drive: 1 TB ZNS drive with 2GB zone size, 14 max open and
   active zones.
 - SMR HDD: 20 TB disk with 256MB zone size, 128 max open zones.

For ZWP, the result show the performance percentage increase (or
decrease) against ZWL (baseline) case.

1) null_blk zoned device:

             +--------+--------+-------+--------+---------+---------+
             |seqw4K1 |seqw4K16|seqw1M1|seqw1M16|rndw4K16|rndw128K16|
             |(MB/s)  | (MB/s) |(MB/s) | (MB/s) | (KIOPS)| (KIOPS)  |
 +-----------+--------+--------+-------+--------+--------+----------+
 |    ZWL    | 940    | 840    | 18550 | 14400  | 424    | 167      |
 |mq-deadline|        |        |       |        |        |          |
 +-----------+--------+--------+-------+--------+--------+----------+
 |    ZWP    | 943    | 845    | 18660 | 14770  | 461    | 165      |
 |mq-deadline| (+0%)  | (+0%)  | (+0%) | (+1%)  | (+8%)  | (-1%)    |
 +-----------+--------+--------+-------+--------+--------+----------+
 |    ZWP    | 756    | 668    | 16020 | 12980  | 135    | 101      |
 |    bfq    | (-19%) | (-20%) | (-13%)| (-9%)  | (-68%) | (-39%)   |
 +-----------+--------+--------+-------+--------+--------+----------+
 |    ZWP    | 2639   | 1715   | 28190 | 19760  | 344    | 150      |
 |   none    | (+180%)| (+104%)| (+51%)| (+37%) | (-18%) | (-10%)   |
 +-----------+--------+--------+-------+--------+--------+----------+

ZWP with mq-deadline gives performance very similar to zone write
locking, showing that zone write plugging overhead is acceptable.
But ZWP ability to run fast block devices with the none scheduler
shows brings all the benefits of zone write plugging and results in
significant performance increase for all workloads. The exception to
this are random write workloads with multiple jobs: for these, the
faster request submission rate achieved by zone write plugging results
in higher contention on null-blk zone spinlock, which degrades
performance.

2) NVMe ZNS drive:

             +--------+--------+-------+--------+--------+----------+
             |seqw4K1 |seqw4K16|seqw1M1|seqw1M16|rndw4K16|rndw128K16|
             |(MB/s)  | (MB/s) |(MB/s) | (MB/s) | (KIOPS)|  (KIOPS) |
 +-----------+--------+--------+-------+--------+--------+----------+
 |    ZWL    | 183    | 702    | 1066  | 1103   | 53.5   | 14.5     |
 |mq-deadline|        |        |       |        |        |          |
 +-----------+--------+--------+-------+--------+--------+----------+
 |    ZWP    | 183    | 719    | 1086  | 1108   | 55.6   | 14.7     |
 |mq-deadline| (-0%)  | (+1%)  | (+0%) | (+0%)  | (+3%)  | (+1%)    |
 +-----------+--------+--------+-------+--------+--------+----------+
 |    ZWP    | 178    | 691    | 1082  | 1106   | 30.8   | 11.5     |
 |    bfq    | (-3%)  | (-2%)  | (-0%) | (+0%)  | (-42%) | (-20%)   |
 +-----------+--------+--------+-------+--------+--------+----------+
 |    ZWP    | 190    | 666    | 1083  | 1108   | 51.4   | 14.7     |
 |   none    | (+4%)  | (-5%)  | (+0%) | (+0%)  | (-4%)  | (+0%)    |
 +-----------+--------+--------+-------+--------+--------+----------+

Zone write plugging overhead does not significantly impact performance.
Similar to nullblk, using the none scheduler leads to performance
increase for most workloads.

3) SMR SATA HDD:

             +-------+--------+-------+--------+--------+----------+
             |seqw4K1|seqw4K16|seqw1M1|seqw1M16|rndw4K16|rndw128K16|
             |(MB/s) | (MB/s) |(MB/s) | (MB/s) | (KIOPS)|  (KIOPS) |
 +-----------+-------+--------+-------+--------+--------+----------+
 |    ZWL    | 107   | 243    | 245   | 246    | 2.2    | 0.763    |
 |mq-deadline|       |        |       |        |        |          |
 +-----------+-------+--------+-------+--------+--------+----------+
 |    ZWP    | 107   | 242    | 245   | 245    | 2.2    | 0.772    |
 |mq-deadline| (+0%) | (-0%)  | (+0%) | (-0%)  | (+0%)  | (+0%)    |
 +-----------+-------+--------+-------+--------+--------+----------+
 |    ZWP    | 104   | 241    | 246   | 242    | 2.2    | 0.765    |
 |    bfq    | (-2%) | (-0%)  | (+0%) | (-0%)  | (+0%)  | (+0%)    |
 +-----------+-------+--------+-------+--------+--------+----------+
 |    ZWP    | 115   | 235    | 249   | 242    | 2.2    | 0.763    |
 |   none    | (+7%) | (-3%)  | (+1%) | (-1%)  | (+0%)  | (+0%)    |
 +-----------+-------+--------+-------+--------+--------+----------+

Performance with purely sequential write workloads at high queue depth
somewhat decrease a little when using zone write plugging. This is due
to the different IO pattern that ZWP generates where the first writes to
a zone start being issued when the end of the previous zone are still
being written. Depending on how the disk handles queued commands, seek
may be generated, slightly impacting the throughput achieved. Such pure
sequential write workloads are however rare with SMR drives.

4) Zone append tests using btrfs:

             +-------------+-------------+-----------+-------------+
             |  null-blk   |  null_blk   |    ZNS    |     SMR     |
             |  native ZA  | emulated ZA | native ZA | emulated ZA |
             |    (MB/s)   |   (MB/s)    |   (MB/s)  |    (MB/s)   |
 +-----------+-------------+-------------+-----------+-------------+
 |    ZWL    | 2441        | N/A         | 1081      | 243         |
 |mq-deadline|             |             |           |             |
 +-----------+-------------+-------------+-----------+-------------+
 |    ZWP    | 2361        | 2999        | 1085      | 239         |
 |mq-deadline| (-1%)       |             | (+0%)     | (-2%)       |
 +-----------+-------------+-------------+-----------+-------------+
 |    ZWP    | 2299        | 2730        | 1080      | 240         |
 |    bfq    | (-4%)       |             | (+0%)     | (-2%)       |
 +-----------+-------------+-------------+-----------+-------------+
 |    ZWP    | 2443        | 3152        | 1083      | 240         |
 |    none   | (+0%)       |             | (+0%)     | (-1%)       |
 +-----------+-------------+-------------+-----------+-------------+

With a more realistic use of the device though a file system, ZWP does
not introduce significant performance differences, except for SMR for
the same reason as with the fio sequential workloads at high queue
depth.

Changes from v4:
 - Modified patch 7 to:
   - Fix a compilation warning
   - Integrate disk_lookup_zone_wplug() into disk_get_zone_wplug() so
     that all users of a zone write plug do a get+put when referencing
     the plug.
   - Introduced inline functions blk_zone_write_complete_request() and
     blk_zone_write_bio_endio() to integrate the "if (plugging)" test
     and avoid repeating it for all calls.
 - Added review tags

Changes from v3:
 - Rebase on block/for-next
 - Removed old patch 1 as it is already applied
 - Addressed Bart and Christoph comment in patch 4
 - Merged former patch 8 and 9 together and changed the zone write plug
   allocation to use a mempool
 - Removed the zone_wplugs_mempool_size filed from patch 8 and instead
   directly reference mempool->min_nr
 - Added review tags

Changes from v2:
 - Added Patch 1 (Christoph's comment)
 - Fixed error code setup in Patch 3 (Bart's comment)
 - Split former patch 26 into patches 27 and 28
 - Modified patch 8 (zone write plugging) introduction to remove the
   kmem_cache use and address Bart's and Christoph comments.
 - Changed from using a mempool of zone write plugs to using a simple
   free-list (patch 9)
 - Simplified patch 10 as suggested by Christoph
 - Moved common code to a helper in patch 13 as suggested by Christoph

Changes from v1:
 - Added patch 6
 - Rewrite of patch 7 to use a hash table of dynamically allocated zone
   write plugs. This results in changes in patch 11 and the addition of
   patch 8 and 9.
 - Rebased everything on 6.9.0-rc1
 - Added review tags for patches that did not change

Damien Le Moal (28):
  block: Restore sector of flush requests
  block: Remove req_bio_endio()
  block: Introduce blk_zone_update_request_bio()
  block: Introduce bio_straddles_zones() and bio_offset_from_zone_start()
  block: Allow using bio_attempt_back_merge() internally
  block: Remember zone capacity when revalidating zones
  block: Introduce zone write plugging
  block: Fake max open zones limit when there is no limit
  block: Allow zero value of max_zone_append_sectors queue limit
  block: Implement zone append emulation
  block: Allow BIO-based drivers to use blk_revalidate_disk_zones()
  dm: Use the block layer zone append emulation
  scsi: sd: Use the block layer zone append emulation
  ublk_drv: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
  null_blk: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
  null_blk: Introduce zone_append_max_sectors attribute
  null_blk: Introduce fua attribute
  nvmet: zns: Do not reference the gendisk conv_zones_bitmap
  block: Remove BLK_STS_ZONE_RESOURCE
  block: Simplify blk_revalidate_disk_zones() interface
  block: mq-deadline: Remove support for zone write locking
  block: Remove elevator required features
  block: Do not check zone type in blk_check_zone_append()
  block: Move zone related debugfs attribute to blk-zoned.c
  block: Replace zone_wlock debugfs entry with zone_wplugs entry
  block: Remove zone write locking
  block: Do not force select mq-deadline with CONFIG_BLK_DEV_ZONED
  block: Do not special-case plugging of zone write operations

 block/Kconfig                     |    5 -
 block/Makefile                    |    1 -
 block/bio.c                       |    6 +
 block/blk-core.c                  |   11 +-
 block/blk-flush.c                 |    1 +
 block/blk-merge.c                 |   22 +-
 block/blk-mq-debugfs-zoned.c      |   22 -
 block/blk-mq-debugfs.c            |    3 +-
 block/blk-mq-debugfs.h            |    6 +-
 block/blk-mq.c                    |  125 ++-
 block/blk-mq.h                    |   31 -
 block/blk-settings.c              |   46 +-
 block/blk-sysfs.c                 |    2 +-
 block/blk-zoned.c                 | 1336 +++++++++++++++++++++++++++--
 block/blk.h                       |   80 +-
 block/elevator.c                  |   46 +-
 block/elevator.h                  |    1 -
 block/genhd.c                     |    3 +-
 block/mq-deadline.c               |  176 +---
 drivers/block/null_blk/main.c     |   22 +-
 drivers/block/null_blk/null_blk.h |    2 +
 drivers/block/null_blk/zoned.c    |   23 +-
 drivers/block/ublk_drv.c          |    5 +-
 drivers/block/virtio_blk.c        |    2 +-
 drivers/md/dm-core.h              |    2 +-
 drivers/md/dm-zone.c              |  476 +---------
 drivers/md/dm.c                   |   75 +-
 drivers/md/dm.h                   |    4 +-
 drivers/nvme/host/core.c          |    2 +-
 drivers/nvme/target/zns.c         |   10 +-
 drivers/scsi/scsi_lib.c           |    1 -
 drivers/scsi/sd.c                 |    8 -
 drivers/scsi/sd.h                 |   19 -
 drivers/scsi/sd_zbc.c             |  335 +-------
 include/linux/blk-mq.h            |   85 +-
 include/linux/blk_types.h         |   30 +-
 include/linux/blkdev.h            |  103 ++-
 37 files changed, 1663 insertions(+), 1464 deletions(-)
 delete mode 100644 block/blk-mq-debugfs-zoned.c

-- 
2.44.0


