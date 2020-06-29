Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECF620D7FC
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2020 22:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgF2Ten (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jun 2020 15:34:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:36630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733145AbgF2Tb0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Jun 2020 15:31:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6EB0B077;
        Mon, 29 Jun 2020 07:20:55 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        Don Brace <don.brace@microchip.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCHv5 00/22] scsi: enable reserved commands for LLDDs
Date:   Mon, 29 Jun 2020 09:19:59 +0200
Message-Id: <20200629072021.9864-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

quite some drivers use internal commands for various purposes, most
commonly sending TMFs or querying the HBA status.
While these commands use the same submission mechanism than normal
I/O commands, they will not be counted as outstanding commands,
requiring those drivers to implement their own mechanism to figure
out outstanding commands.
The block layer already has the concept of 'reserved' tags for
precisely this purpose, namely non-I/O tags which live off a separate
tag pool. That guarantees that these commands can always be sent,
and won't be influenced by tag starvation from the I/O tag pool.
This patchset enables the use of reserved tags for the SCSI midlayer
by allocating a virtual LUN for the HBA itself which just serves
as a resource to allocate valid tags from.
This removes quite some hacks which were required for some
drivers (eg. fnic or snic), and allows the use of tagset
iterators within the drivers.

The entire patchset can be found at

git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git reserved-tags.v5

As usual, comments and reviews are welcome.

Changes to v4:
- Fixup kbuild warning
- Include reviews from Bart

Changes to v3:
- Kill gdth
- Only convert fnic, snic, hpsa, and aacraid
- Drop command emulation for pseudo host device
- make 'can_queue' exclude the number or reserved tags
- Drop persistent commands proposal
- Sanitize host device handling

Changes to v2:
- Update patches from John Garry
- Use virtual LUN as suggested by Christoph
- Improve SCSI Host device to present a real SCSI device
- Implement 'persistent' commands for AENs
- Convert Megaraid SAS

Changes to v1:
- Make scsi_{get, put}_reserved_cmd() for Scsi host
- Previously we separate scsi_{get, put}_reserved_cmd() for sdev
  and scsi_host_get_reserved_cmd() for the host
- Fix how Scsi_Host.can_queue is set in the virtio-scsi change
- Drop Scsi_Host.use_reserved_cmd_q
- Drop scsi_is_reserved_cmd()
- Add support in libsas and associated HBA drivers
- Allocate reserved command in slow task
- Switch hisi_sas to use reserved Scsi command
- Reorder the series a little
- Some tidying
	      
Hannes Reinecke (22):
  scsi: drop gdth driver
  block: add flag for internal commands
  scsi: add scsi_{get,put}_internal_cmd() helper
  fnic: use internal commands
  fnic: use scsi_host_busy_iter() to traverse commands
  fnic: check for started requests in fnic_wq_copy_cleanup_handler()
  csiostor: use internal command for LUN reset
  scsi: implement reserved command handling
  scsi: use real inquiry data when initialising devices
  scsi: Use dummy inquiry data for the host device
  scsi: revamp host device handling
  snic: use reserved commands
  snic: use tagset iter for traversing commands
  snic: check for started requests in snic_hba_reset_cmpl_handler()
  hpsa: move hpsa_hba_inquiry after scsi_add_host()
  hpsa: use reserved commands
  hpsa: use scsi_host_busy_iter() to traverse outstanding commands
  hpsa: drop refcount field from CommandList
  aacraid: move scsi_add_host()
  aacraid: store target id in host_scribble
  aacraid: use scsi_get_internal_cmd()
  aacraid: use scsi_host_busy_iter() to traverse outstanding commands

 Documentation/kbuild/makefiles.rst                 |    4 +-
 Documentation/process/magic-number.rst             |    2 -
 Documentation/scsi/scsi-parameters.rst             |    3 -
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 -
 block/blk-exec.c                                   |    5 +
 drivers/scsi/Kconfig                               |   14 -
 drivers/scsi/Makefile                              |    2 -
 drivers/scsi/aacraid/aachba.c                      |  137 +-
 drivers/scsi/aacraid/aacraid.h                     |    9 +-
 drivers/scsi/aacraid/commctrl.c                    |   25 +-
 drivers/scsi/aacraid/comminit.c                    |    2 +-
 drivers/scsi/aacraid/commsup.c                     |  106 +-
 drivers/scsi/aacraid/dpcsup.c                      |    2 +-
 drivers/scsi/aacraid/linit.c                       |  175 +-
 drivers/scsi/csiostor/csio_scsi.c                  |   48 +-
 drivers/scsi/fnic/fnic_scsi.c                      |  944 ++---
 drivers/scsi/gdth.c                                | 4323 --------------------
 drivers/scsi/gdth.h                                |  981 -----
 drivers/scsi/gdth_ioctl.h                          |  251 --
 drivers/scsi/gdth_proc.c                           |  586 ---
 drivers/scsi/gdth_proc.h                           |   18 -
 drivers/scsi/hpsa.c                                |  368 +-
 drivers/scsi/hpsa.h                                |    3 +-
 drivers/scsi/hpsa_cmd.h                            |    1 -
 drivers/scsi/scsi_devinfo.c                        |    1 +
 drivers/scsi/scsi_lib.c                            |   54 +-
 drivers/scsi/scsi_scan.c                           |   96 +-
 drivers/scsi/scsi_sysfs.c                          |    3 +-
 drivers/scsi/snic/snic.h                           |    4 +-
 drivers/scsi/snic/snic_main.c                      |    7 +
 drivers/scsi/snic/snic_scsi.c                      |  525 ++-
 include/linux/blk_types.h                          |    2 +
 include/linux/blkdev.h                             |    5 +
 include/scsi/scsi_device.h                         |    4 +
 include/scsi/scsi_host.h                           |   25 +-
 35 files changed, 1243 insertions(+), 7493 deletions(-)
 delete mode 100644 drivers/scsi/gdth.c
 delete mode 100644 drivers/scsi/gdth.h
 delete mode 100644 drivers/scsi/gdth_ioctl.h
 delete mode 100644 drivers/scsi/gdth_proc.c
 delete mode 100644 drivers/scsi/gdth_proc.h

-- 
2.16.4

