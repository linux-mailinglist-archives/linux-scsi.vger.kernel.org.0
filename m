Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A31CD172426
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Feb 2020 17:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgB0Q7U (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Feb 2020 11:59:20 -0500
Received: from smtp.infotech.no ([82.134.31.41]:47124 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729223AbgB0Q7T (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 27 Feb 2020 11:59:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 7ABC0204197;
        Thu, 27 Feb 2020 17:59:17 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KqvsppYxKnt5; Thu, 27 Feb 2020 17:59:10 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 0B2E220416A;
        Thu, 27 Feb 2020 17:59:09 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v7 00/38] sg: add v4 interface
Date:   Thu, 27 Feb 2020 11:58:24 -0500
Message-Id: <20200227165902.11861-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patchset is the first stage of a two stage rewrite of the scsi
generic (sg) driver. The main goal of the first stage is to
introduce the sg v4 interface that uses 'struct sg_io_v4' as well
as keeping and modernizing the sg v3 interface (based on 'struct
sg_io_hdr'). The async interface formerly requiring the use of
write() and read() system calls now have ioctl(SG_IOSUBMIT) and
ioctl(SG_IORECEIVE) replacements. See:
    http://sg.danny.cz/sg/sg_v40.html
for more details.

Due to changes in the production sg driver (mainly due to
compat_ioctl() work) there are many changes in this patchset just
keeping up. Significant changes appeared in lk 5.5.3 with more
in lk 5.6.0-rc1. This patchset is build on the latter.

The complete patchset, whose second stage has an additional 25
patches (i.e. 63 patches in all), can be found at the above link.

Changes since v6 (sent to linux-scsi list on 20200112)
  - based on Martin Petersen's 5.7/scsi-queue branch in his
    linux-scsi repository
  - major work on mmap support: when mmap(2) is used the reserve
    request scatter gather list is rebuilt to have order=0
    elements (i.e. each is PAGE_SIZE bytes).
  - address one kbuild robot issue: add include defining size_t
  - nearly all patches that have been reviewed have been changed,
    usually in minor ways. Those patches have "***" before the
    "Reviewed-by" line.

Changes since v5 (sent to linux-scsi list on 20191008)
  - replace linked lists with xarray mechanism
  - use the locking in the xarray implementation to
    replace several discrete locks
  - some patches that were previously reviewed by
    Hannes Reinecke have had small changes made to
    them usually associated with xarrays. Those have
    been marked with "***" prepended to the
    "Reviewed-by" line
  - bump the driver version number to 4.0.08

Changes since v4 (sent to linux-scsi list on 20190829)
  - remove much of the logic in the previous patchset
    series from and including:
        [PATCH v4 11/22] sg: replace rq array with lists
    to
        [PATCH v4 22/22] sg: bump version to 4.0.03
  - bump the driver version number from 3.5.36 to 3.9.01
    [20190606] reflecting that the v4 interface has not
    been implemented (in this patchset)
  - patches 13/23 through to 22/23 reduce the complexity
    of "[PATCH v4 11/22] sg: replace rq array with lists"
    measured in KiloBytes from about 130 KB to 80 KB.
  - various changes suggested by reviewers of the v4
    patchset have been implemented
  - change all %p descriptors (mainly in SG_LOG() macros)
    to %pK so that the debug output remains useful in
    recent kernels. Evidently sys admins can selectively
    turn on pointer obfuscation on %pK as required on
    secure systems.

Changes since v3 (sent to linux-scsi list on 20190807):
  - move __must_hold attributes into separate patch
  - move procfs and debugfs file scope definitions toward
    the end of sg.c to avoid forward declarations
  - move module_param* and MODULE_* macros to end of sg.c
  - expand debugfs support with snapshot_devs which allows
    filtering of snapshot output by sg device(s)
  - add a WARN_ONCE when write(2) is used with the sg v3
    interface. Suggest using SG_IOSUBMIT_V3 instead.
  - address more of the review comments from Hannes Reinecke
    and Christoph Hellwig
  - add various reviewed-by tags where appropriate

Changes since v2 (sent to linux-scsi list on 20190727):
  - address issues "Reported-by: kbuild test robot <lkp@intel.com>".
    The main one was to change the bsg header included to:
    include/uapi/linux/bsg.h rather than include/linux/bsg.h
  - address some of the review comments from Hannes Reinecke;
    email responses have been sent for review comments that
    did not result in code changes

Changes since v1 (sent to linux-scsi list on 20190616):
  - change ktime_get_boot_ns() to ktime_get_boottime_ns() to reflect
    kernel API change first seen in lk 5.3.0-rc1

Douglas Gilbert (38):
  sg: move functions around
  sg: remove typedefs, type+formatting cleanup
  sg: sg_log and is_enabled
  sg: rework sg_poll(), minor changes
  sg: bitops in sg_device
  sg: make open count an atomic
  sg: move header to uapi section
  sg: speed sg_poll and sg_get_num_waiting
  sg: sg_allow_if_err_recovery and renames
  sg: improve naming
  sg: change rwlock to spinlock
  sg: ioctl handling
  sg: split sg_read
  sg: sg_common_write add structure for arguments
  sg: rework sg_vma_fault
  sg: rework sg_mmap
  sg: replace sg_allow_access
  sg: rework scatter gather handling
  sg: introduce request state machine
  sg: sg_find_srp_by_id
  sg: sg_fill_request_element
  sg: printk change %p to %pK
  sg: xarray for fds in device
  sg: xarray for reqs in fd
  sg: replace rq array with lists
  sg: sense buffer rework
  sg: add sg v4 interface support
  sg: rework debug info
  sg: add 8 byte SCSI LUN to sg_scsi_id
  sg: expand sg_comm_wr_t
  sg: add sg_iosubmit_v3 and sg_ioreceive_v3 ioctls
  sg: add some __must_hold macros
  sg: move procfs objects to avoid forward decls
  sg: protect multiple receivers
  sg: first debugfs support
  sg: rework mmap support
  sg: warn v3 write system call users
  sg: bump version to 4.0.08

 drivers/scsi/sg.c      | 5182 +++++++++++++++++++++++++++-------------
 include/scsi/sg.h      |  270 +--
 include/uapi/scsi/sg.h |  374 +++
 3 files changed, 3917 insertions(+), 1909 deletions(-)
 create mode 100644 include/uapi/scsi/sg.h

-- 
2.25.1

